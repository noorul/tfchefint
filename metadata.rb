name             'ctfchefint'
maintainer       'CollabNet, Inc.'
maintainer_email 'dev-devops@collab.net'
license          'Apache 2.0'
description      'Installs/Configures TeamForge and Chef integration'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w{sudo users}.each do |d|
  depends d
end
