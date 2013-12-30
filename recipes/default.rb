#
# Cookbook Name:: pgbarman
# Recipe:: default
#
# Copyright 2013, Geoforce, Inc
#
# All rights reserved - Do Not Redistribute
#
#
include_recipe "postgresql"
include_recipe "python"
include_recipe "rsync"

%w{ argcomplete argh psycopg2 python-dateutil distribute }.each do |pip|
  python_pip pip
end

remote_file "#{Chef::Config[:file_cache_path]}/barman.tar.gz" do
  source "http://downloads.sourceforge.net/project/pgbarman/1.2.3/barman-1.2.3.tar.gz?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fpgbarman%2Ffiles%2F1.2.3%2F&ts=1388419154&use_mirror=optimate"
  not_if { ::File.exists?({"#{Chef::Config[:file_cache_path]}/barman.tar.gz") }
end

bash "Build Barman" do
  user "root"
  cwd "#{Chef::Config[:file_cache_path]}"
  code <<-EOH
  tar xvf barman.tar.gz
  cd barman-1.2.3
  ./setup.py build
  ./setup.py install
  EOH
end
