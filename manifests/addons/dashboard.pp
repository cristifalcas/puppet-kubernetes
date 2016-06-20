class kubernetes::addons::dashboard {
  include ::kubernetes::addons::base

  file{ '/etc/kubernetes/addons/dashboard':
    ensure  => directory,
    source  => "puppet:///modules/${module_name}/etc/kubernetes/addons/dashboard",
    recurse => true,
    require => File['/etc/kubernetes/addons'],
  }
}
