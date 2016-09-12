# == Class: kubernetes::master
#
# Module to install an up-to-date version of kubernetes from package.
#
# === Parameters
#
# [*manage_package*]
#   if you want to install the software from a package.
#   Defaults to true
#
# [*ensure*]
#   Passed to the kubernetes-master package.
#   Defaults to present
#
class kubernetes::master (
  $manage_package = true,
  $ensure         = 'present',
) {
  validate_string($ensure)

  include ::kubernetes::client

  if $manage_package {
    # this should ensure also that all files from /etc/kubernetes are managed after package install
    package { 'kubernetes-master': ensure => $ensure, } -> File['/etc/kubernetes/']
  }
}
