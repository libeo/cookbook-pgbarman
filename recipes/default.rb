#
# Cookbook Name:: pgbarman
# Recipe:: user
#
# Copyright 2013, Geoforce, Inc
#


include_recipe "pgbarman::user"

node.set["pgbarman"]["backup_this"] = true
