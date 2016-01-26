# Class: kubernetes
#
# This module manages kubernetes
#
# Parameters:
#
# [*ensure*]
#   Set package version to be installed or use 'installed'/'latest'
#   Defaults to installed
#
class kubernetes ($ensure = 'installed',) {
  # /etc/kubernetes/config is managed by both master and node rpms
  # so we take care of it here
  package { 'kubernetes-client': ensure => $ensure, } ->
  file { '/etc/kubernetes/': ensure => 'directory', } ->
  file { '/etc/kubernetes/config':
    ensure  => 'file',
    force   => true,
    content => template("${module_name}/etc/kubernetes/config.erb"),
  }
}
