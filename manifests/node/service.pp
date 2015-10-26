# == Class: kubernetes::node::service
#
# Class to manage the kubernetes::node service daemon
#
class kubernetes::node::service {
  service { 'kube-proxy':
    ensure => $kubernetes::node::service_state,
    enable => $kubernetes::node::service_enable,
  }

  service { 'kubelet':
    ensure => $kubernetes::node::service_state,
    enable => $kubernetes::node::service_enable,
  }
}
