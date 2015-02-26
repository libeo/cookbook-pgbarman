#
# Copyright 2013, Geoforce, Inc
#
#
#

default['pgbarman']['version'] = '1.4.0'
default['pgbarman']['url'] = "http://downloads.sourceforge.net/project/pgbarman/#{node['pgbarman']['version']}/barman-#{node['pgbarman']['version']}.tar.gz?r=&ts=1424906716&use_mirror=optimate"

default['pgbarman']['home'] = '/var/lib/barman'
default['pgbarman']['user'] = 'barman'
default['pgbarman']['log_dir'] = '/var/log/barman'
default['pgbarman']['log_file'] = "#{node['pgbarman']['log_dir']}/barman.log"
default['pgbarman']['compression'] = 'gzip'
default['pgbarman']['conf_dir'] = '/etc/barman/conf.d'
default['pgbarman']['minimum_redundancy'] = 0
default['pgbarman']['retention_policy'] = ''
default['pgbarman']['bandwidth_limit'] = 0
default['pgbarman']['backup_this'] = false
