#
# Cookbook Name:: pgbarman
# Recipe:: default
#
# Copyright 2013, Geoforce, Inc
#

include_recipe 'postgresql'
include_recipe 'python'
include_recipe 'rsync'

include_recipe 'pgbarman::user'
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

template '/etc/barman.conf' do
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

nodes = search(:node, 'name:* AND backup_this:true')

nodes.each do |n|
  template "#{node['pgbarman']['conf_dir']}/#{n['name']}.conf" do
    source 'postgresql.conf.erb'
    owner node['pgbarman']['user']
    group node['pgbarman']['user']
    mode 00644
    variables(name: n['name'],
              description: 'Lolnoidea',
              ssh_command: "ssh #{node['pgbarman']['user']}@#{n['ipaddress']}",
              redundancy: n['pgbarman']['redundancy'])
    # TODO: Notify barman service ?
  end
end
