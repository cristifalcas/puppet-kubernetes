class kubernetes::addons::namespace {

  file{ '/etc/kubernetes/addons/namespace.yaml':
    source  => "puppet:///modules/${module_name}/etc/kubernetes/addons/namespace.yaml",
    require => File['/etc/kubernetes/addons'],
  }
}
