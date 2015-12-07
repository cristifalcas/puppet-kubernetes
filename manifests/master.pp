# == Class: kubernetes::master
#
# Module to install an up-to-date version of Docker from package.
#
# === Parameters
#
# [*ensure*]
#   Passed to the kubernetes-master package.
#   Defaults to present
#
class kubernetes::master ($ensure = 'present',) {
  package { 'kubernetes-master': ensure => $ensure, }
}
