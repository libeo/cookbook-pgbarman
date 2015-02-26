#
# Cookbook Name:: pgbarman
# Recipe:: default
#
# Copyright 2013, Geoforce, Inc
#

include_recipe 'postgresql'
include_recipe 'python'
include_recipe 'rsync'

include_recipe 'build-essential'
include_recipe 'tar'

%w(argcomplete argh psycopg2 python-dateutil distribute).each do |pip|
  python_pip pip
end

tar_extract node['pgbarman']['url'] do
  target_dir Chef::Config[:file_cache_path]
  notifies :run, 'bash[Build Barman]', :immediately
end

bash 'Build Barman' do
  user 'root'
  cwd "#{Chef::Config[:file_cache_path]}/barman-#{node['pgbarman']['version']}"
  code <<-EOH
  ./setup.py build
  ./setup.py install
  EOH
  action :nothing
end

directory '/etc/barman' do
  owner node['pgbarman']['user']
  group node['pgbarman']['user']
  mode 00700
end

template '/etc/barman/barman.conf' do
  owner 'root'
  group 'root'
  mode 00644
  variables(home: node['pgbarman']['home'],
            user: node['pgbarman']['user'],
            log_file: node['pgbarman']['log'],
            conf_dir: node['pgbarman']['conf_dir'],
            compression: node['pgbarman']['compression'],
            redundancy: node['pgbarman']['minimum_redundancy'],
            retention_policy: node['pgbarman']['retention_policy'],
            bandwidth_limit: node['pgbarman']['bandwidth_limit'])
end

directory node['pgbarman']['conf_dir'] do
  owner node['pgbarman']['user']
  group node['pgbarman']['user']
  mode 00700
end

file node['pgbarman']['log'] do
  action :create
  owner node['pgbarman']['user']
  group node['pgbarman']['user']
  mode '0600'
end

nodes = search(:node, 'pgbarman_postgres_pubkey:*')

client_keys = []
nodes.each do |n|
  client_keys << node['pgbarman']['postgres_pubkey']
  template "#{node['pgbarman']['conf_dir']}/#{n['fqdn']}.conf" do
    source 'postgresql.conf.erb'
    owner node['pgbarman']['user']
    group node['pgbarman']['user']
    mode 00644
    variables(description: 'Lolnoidea',
              redundancy: n['pgbarman']['minimum_redundancy'])
  end
end

user_account node['pgbarman']['user'] do
  action :create
  home node['pgbarman']['home']
  ssh_keys client_keys
end
