# == Class: kubernetes::client
#
# Module to install and configure kubernetes client package
#
# === Parameters
#
# [*ensure*]
#   Passed to the docker package.
#   Defaults to present
#
class kubernetes::client (
  $ensure = $kubernetes::client::params::ensure,
) inherits kubernetes::client::params {
  class { 'kubernetes::client::install': } ->
  class { 'kubernetes::client::config': }

  contain 'kubernetes::client::install'
  contain 'kubernetes::client::config'
}
