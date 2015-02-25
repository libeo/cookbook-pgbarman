#
# Copyright 2013, Geoforce, Inc
#
#
#

default['pgbarman']['version'] = '1.4.0'
default['pgbarman']['url'] = "http://downloads.sourceforge.net/project/pgbarman/#{node['pgbarman']['version']}/barman-#{node['pgbarman']['version']}.tar.gz?r=&ts=1424906716&use_mirror=optimate"

default['pgbarman']['home'] = '/var/lib/barman'
default['pgbarman']['user'] = 'barman'
default['pgbarman']['log'] = '/var/log/barman/barman.log'
default['pgbarman']['compression'] = 'None'
default['pgbarman']['conf_dir'] = '/etc/barman.d'
default['pgbarman']['minimum_redundancy'] = 0
default['pgbarman']['retention_policy'] = ''
default['pgbarman']['bandwidth_limit'] = 0
default['pgbarman']['backup_this'] = false
