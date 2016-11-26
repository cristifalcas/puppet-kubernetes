# Class: kubernetes::client
#
# This module manages kubernetes-client package.
# It only populates the /etc/kubernetes/config file: it empties all variables.
#
# Parameters:
#
# [*manage_package*]
#   If the module should take care of installing the package
#   Defaults to true
#
# [*ensure*]
#   Set package version to be installed or use 'installed'/'latest'
#   Defaults to installed
#
# [*purge_kube_dir*]
#   If we should purge the kubernetes config directory
#   Defaults to false
#
class kubernetes::client (
  $manage_package = true,
  $ensure         = 'present',
  $purge_kube_dir = false,
) {
  # /etc/kubernetes/config is managed by both master and node rpms
  # so we take care of it here
  validate_string($ensure)

  file { '/etc/kubernetes/':
    ensure  => 'directory',
    purge   => $purge_kube_dir,
    recurse => $purge_kube_dir,
  } ->
  file { '/etc/kubernetes/config':
    ensure  => 'file',
    force   => true,
    content => template("${module_name}/etc/kubernetes/config.erb"),
  }

  if $manage_package {
    package { 'kubernetes-client': ensure => $ensure, } ->
    File['/etc/kubernetes/']
  }
}
