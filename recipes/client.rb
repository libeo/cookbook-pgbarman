#
# Cookbook Name:: pgbarman
# Recipe:: client
#
# Copyright 2013, Geoforce, Inc
#

user node["pgbarman"]["user"] do
  home "/home/#{node["pgbarman"]["user"]}"
  shell "/bin/bash"
end
