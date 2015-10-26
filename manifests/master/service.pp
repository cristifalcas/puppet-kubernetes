# == Class: kubernetes::master::service
#
# Class to manage the kubernetes::master service daemons
#
class kubernetes::master::service {
  service { 'kube-apiserver':
    ensure => $kubernetes::master::service_state_apiserver,
    enable => $kubernetes::master::service_enable_apiserver,
  }

  service { 'kube-controller-manager':
    ensure => $kubernetes::master::service_state_controller,
    enable => $kubernetes::master::service_enable_controller,
  }

  service { 'kube-scheduler':
    ensure => $kubernetes::master::service_state_scheduler,
    enable => $kubernetes::master::service_enable_scheduler,
  }
}
