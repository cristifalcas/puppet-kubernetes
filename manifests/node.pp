# == Class: kubernetes::node
#
# Module to install an up-to-date version of kubernetes::node from package.
#
# === Parameters
#
# [*ensure*]
#   Passed to the kubernetes::node package.
#   Defaults to present
#
class kubernetes::node ($ensure = 'present',) {
  include ::kubernetes

  # this should ensure also that all files from /etc/kubernetes are managed after package install
  package { ['kubernetes-node']: ensure => $ensure, } -> File['/etc/kubernetes/'] ->
  file { '/etc/kubernetes/manifests/': ensure => directory, } ->
  file { '/var/run/kubernetes/':
    ensure => directory,
    owner  => 'kube',
  }
}
