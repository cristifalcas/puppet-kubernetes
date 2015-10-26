# == Class: kubernetes::master::config
#
class kubernetes::master::config {
  file { '/etc/kubernetes/apiserver':
    ensure  => present,
    force   => true,
    content => template("${module_name}/etc/kubernetes/apiserver.erb"),
  } ~>
  Service['kube-apiserver']

  file { '/etc/kubernetes/controller-manager':
    ensure  => present,
    force   => true,
    content => template("${module_name}/etc/kubernetes/controller-manager.erb"),
  } ~>
  Service['kube-controller-manager']

  file { '/etc/kubernetes/scheduler':
    ensure  => present,
    force   => true,
    content => template("${module_name}/etc/kubernetes/scheduler.erb"),
  } ~>
  Service['kube-scheduler']
}
