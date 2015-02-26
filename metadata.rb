name             'pgbarman'
maintainer       'Libeo'
maintainer_email 'maxime.pelletier@libeo.com'
license          'All rights reserved'
description      'Installs/Configures pgbarman'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

%w(postgresql python rsync build-essential tar user).each do |ckbk|
  depends ckbk
end
