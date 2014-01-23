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

ssh_keys = data_bag_item("pgbarman", "barman")

directory "/home/#{node["pgbarman"]["user"]}/.ssh" do
  owner node["pgbarman"]["user"]
  group node["pgbarman"]["user"]
  mode 00700
end

file "/home/#{node["pgbarman"]["user"]}/.ssh/id_rsa" do
  owner node["pgbarman"]["user"]
  group node["pgbarman"]["user"]
  mode 00600
  content ssh_keys["private_key"]
end

file "/home/#{node["pgbarman"]["user"]}/.ssh/authozized_keys" do
  owner node["pgbarman"]["user"]
  group node["pgbarman"]["user"]
  mode 00600
  content ssh_keys["private_key"]
end
