class kubernetes::addons::base {
  include ::kubernetes::addons::updater

  class { '::kubernetes::addons::namespace':
    require => Class['::kubernetes::addons::updater'],
  }
}
