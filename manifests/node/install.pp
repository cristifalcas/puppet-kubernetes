# == Class: kubernetes::node::install
#
class kubernetes::node::install {
  package { ['kubernetes-node']: ensure => $kubernetes::node::ensure, }

  if $kubernetes::node::kubelet_configure_cbr0 {
    package { ['bridge-utils']: ensure => $kubernetes::node::ensure, }
  }
}
