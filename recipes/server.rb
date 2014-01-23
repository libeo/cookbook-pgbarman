#
# Cookbook Name:: pgbarman
# Recipe:: default
#
# Copyright 2013, Geoforce, Inc
#

include_recipe "postgresql"
include_recipe "python"
include_recipe "rsync"

%w{ argcomplete argh psycopg2 python-dateutil distribute }.each do |pip|
  python_pip pip
end

remote_file "#{Chef::Config[:file_cache_path]}/barman.tar.gz" do
  source "http://downloads.sourceforge.net/project/pgbarman/#{node["pgbarman"]["version"]}/barman-#{node["pgbarman"]["version"]}.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fpgbarman%2Ffiles%2F#{node["pgbarman"]["version"]}%2F&ts=1388419154&use_mirror=optimate"
  not_if { ::File.exists?("#{Chef::Config[:file_cache_path]}/barman.tar.gz") }
  notifies :run, "bash[Build Barman]", :immediately
end

bash "Build Barman" do
  user "root"
  cwd "#{Chef::Config[:file_cache_path]}"
  code <<-EOH
  tar xvf barman.tar.gz
  cd barman-#{node["pgbarman"]["version"]}
  ./setup.py build
  ./setup.py install
  EOH
  action :nothing
end

template "/etc/barman.conf" do
  owner "root"
  group "root"
  mode 00644
  variables({
    :home => node["pgbarman"]["home"],
    :user => node["pgbarman"]["user"],
    :log_file => node["pgbarman"]["log"],
    :conf_dir => node["pgbarman"]["conf_dir"],
    :compression => node["pgbarman"]["compression"],
    :redundancy => node["pgbarman"]["minimum_redundancy"],
    :retention_policy => node["pgbarman"]["retention_policy"],
    :bandwidth_limit => node["pgbarman"]["bandwidth_limit"]
  })
end

directory node["pgbarman"]["conf_dir"] do
  owner node["pgbarman"]["user"]
  group node["pgbarman"]["user"]
  mode 00700
end

include_recipe "pgbarman::user"
