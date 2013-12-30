name             'pgbarman'
maintainer       'Geoforce, Inc'
maintainer_email 'masterkorp@masterkorp.net'
license          'All rights reserved'
description      'Installs/Configures pgbarman'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{ postgresql }.each do |ckbk|
  depends ckbk
end
