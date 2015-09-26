# == Class: kubernetes::master::service
#
# Class to manage the kubernetes::master service daemons
#
class kubernetes::master::service {
  service { 'kube-apiserver':
    ensure => $kubernetes::master::service_state,
    enable => $kubernetes::master::service_enable,
  }

  service { 'kube-controller-manager':
    ensure => $kubernetes::master::service_state,
    enable => $kubernetes::master::service_enable,
  }

  service { 'kube-scheduler':
    ensure => $kubernetes::master::service_state,
    enable => $kubernetes::master::service_enable,
  }
}
