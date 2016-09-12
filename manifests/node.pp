# == Class: kubernetes::node
#
# Module to install an up-to-date version of kubernetes::node from package.
#
# === Parameters
#
# [*manage_package*]
#   if you want to install the software from a package.
#   Defaults to true
#
# [*ensure*]
#   Passed to the kubernetes::node package.
#   Defaults to present
#
class kubernetes::node (
  $manage_package = true,
  $ensure         = 'present',
) {
  validate_string($ensure)

  include ::kubernetes::client

  if $manage_package {
    # this should ensure also that all files from /etc/kubernetes are managed after package install
    package { ['kubernetes-node']: ensure => $ensure, } ->
    File['/etc/kubernetes/'] ->
    file { '/var/run/kubernetes/':
      ensure => directory,
      owner  => 'kube',
    }
  }
}
