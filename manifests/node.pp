# == Class: kubernetes::node
#
# Module to install an up-to-date version of kubernetes::node from package.
#
# === Parameters
#
# [*ensure*]
#   Passed to the kubernetes::node package.
#   Defaults to present
class kubernetes::node (
  $ensure = $kubernetes::node::params::pkg_ensure,
) inherits kubernetes::node::params {
  include kubernetes

  package { ['kubernetes-node']: ensure => $ensure, } ->
  file { '/etc/kubernetes/manifests/': ensure => directory, } ->
  file { '/var/run/kubernetes/':
    ensure => directory,
    owner  => 'kube'
  }
}
