# == Class: kubernetes::master::config
#
class kubernetes::master::config {
  file { '/etc/kubernetes/apiserver':
    ensure  => present,
    force   => true,
    content => template("${module_name}/etc/kubernetes/apiserver.erb"),
  }

  file { '/etc/kubernetes/controller-manager':
    ensure  => present,
    force   => true,
    content => template("${module_name}/etc/kubernetes/controller-manager.erb"),
  }

  file { '/etc/kubernetes/scheduler':
    ensure  => present,
    force   => true,
    content => template("${module_name}/etc/kubernetes/scheduler.erb"),
  }
}
