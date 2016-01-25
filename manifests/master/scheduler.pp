# == Class: kubernetes::master::scheduler
#
# [*ensure*]
#   Whether you want the scheduler daemon to start up
#   Defaults to running
#
# [*enable*]
#   Whether you want the scheduler daemon to start up at boot
#   Defaults to true
#
# [*address*]
#   The IP address to serve on (set to 0.0.0.0 for all interfaces)
#   Defaults to 127.0.0.1
#
# [*bind_pods_burst*]
#   Number of bindings per second scheduler is allowed to make during bursts
#   Defaults to 100
#
# [*bind_pods_qps*]
#   Number of bindings per second scheduler is allowed to continuously make
#   Defaults to 50
#
# [*google_json_key*]
#   The Google Cloud Platform Service Account JSON Key to use for authentication.
#   Defaults to undef
#
# [*kubeconfig*]
#   Path to kubeconfig file with authorization and master location information.
#   Defaults to undef
#
# [*log_flush_frequency*]
#   Maximum number of seconds between log flushes
#   Defaults to 5s
#
# [*master*]
#   The address of the Kubernetes API server (overrides any value in kubeconfig)
#   Defaults to 'http://127.0.0.1:8080'
#
# [*port*]
#   The port that the scheduler's http service runs on
#   Defaults to 10251
#
# [*minimum_version*]
#   Minimum supported Kubernetes version. Don't enable new features when
#   incompatbile with that version.
#   Default to 1.1.
#
class kubernetes::master::scheduler (
  $ensure              = $kubernetes::master::params::kube_scheduler_service_ensure,
  $enable              = $kubernetes::master::params::kube_scheduler_service_enable,
  $address             = $kubernetes::master::params::kube_scheduler_address,
  $bind_pods_burst     = $kubernetes::master::params::kube_scheduler_bind_pods_burst,
  $bind_pods_qps       = $kubernetes::master::params::kube_scheduler_bind_pods_qps,
  $google_json_key     = $kubernetes::master::params::kube_scheduler_google_json_key,
  $kubeconfig          = $kubernetes::master::params::kube_scheduler_kubeconfig,
  $log_flush_frequency = $kubernetes::master::params::kube_scheduler_log_flush_frequency,
  $master              = $kubernetes::master::params::kube_scheduler_master,
  $port                = $kubernetes::master::params::kube_scheduler_port,
  $extra_args          = $kubernetes::master::params::kube_scheduler_args,
  $minimum_version     = $kubernetes::master::params::kube_scheduler_minimum_version,
) inherits kubernetes::master::params {
  include ::kubernetes
  include ::kubernetes::master

  File['/etc/kubernetes/config'] ~> Service['kube-scheduler']

  file { '/etc/kubernetes/scheduler':
    ensure  => 'file',
    force   => true,
    content => template("${module_name}/etc/kubernetes/scheduler.erb"),
  } ~>
  service { 'kube-scheduler':
    ensure => $ensure,
    enable => $enable,
  }
}
