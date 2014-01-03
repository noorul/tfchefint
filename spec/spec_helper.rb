require 'chefspec'
require 'chefspec/berkshelf'

::CENTOS_OPTS = {
  :platform  => "centos",
  :version   => "6.3",
  :log_level => :fatal
}
