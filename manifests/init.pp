# Class: kubernetes
#
# This module manages kubernetes
#
# Parameters:
#
# [*kube_logtostderr*]
#   logging to stderr means we get it in the systemd journal
#   Defaults to true
#
# [*kube_log_level*]
#   journal message level, 0 is debug
#   Defaults to 0
#
# [*kube_allow_priv*]
#   Should this cluster be allowed to run privileged docker containers
#   Defaults to false
#
# [*kube_master*]
#   How the controller-manager, scheduler, and proxy find the apiserver
#
class kubernetes (
  $kube_logtostderr = true,
  $kube_log_level   = 0,
  $kube_allow_priv  = false,
  $kube_master      = 'http://127.0.0.1:8080',
) {
  file { '/etc/kubernetes/config':
    ensure  => present,
    force   => true,
    content => template("${module_name}/etc/kubernetes/config.erb"),
  }
}
