#
# Copyright 2013, Geoforce, Inc
#
#
#

default["pgbarman"]["version"] = "1.2.3"

default["pgbarman"]["home"] = "/var/lib/barman"
default["pgbarman"]["user"] = "barman"
default["pgbarman"]["log"] = "/var/log/barman/barman.log"
default["pgbarman"]["compression"] = "None"
default["pgbarman"]["conf_dir"] = "/etc/barman.d"
default["pgbarman"]["minimum_redundancy"] = 0
default["pgbarman"]["retention_policy"] = ""
default["pgbarman"]["bandwidth_limit"] = 0
