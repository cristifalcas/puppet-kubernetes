# == Class: kubernetes::master::scheduler
# http://kubernetes.io/docs/admin/kube-scheduler/
#
# [*ensure*]
#   Whether you want the scheduler daemon to start up
#   Defaults to running
#
# [*journald_forward_enable*]
#   Fix for SIGPIPE sent to registry daemon during journald restart
#   Defaults to false
#
# [*enable*]
#   Whether you want the scheduler daemon to start up at boot
#   Defaults to true
#
## Parameters ##
#
# [*address*]
#   The IP address to serve on (set to 0.0.0.0 for all interfaces)
#   Defaults to 127.0.0.1
#
# [*algorithm_provider*]
#   The scheduling algorithm provider to use, one of: DefaultProvider
#   Defaults to DefaultProvider
#
# [*google_json_key*]
#   The Google Cloud Platform Service Account JSON Key to use for authentication.
#   Defaults to undef
#
# [*kube_api_burst*]
#   Burst to use while talking with kubernetes apiserver
#   Default 100
#
# [*kube_api_qps*]
#   QPS to use while talking with kubernetes apiserver
#   Default 50
#
# [*kubeconfig*]
#   Path to kubeconfig file with authorization and master location information.
#   Defaults to undef
#
# [*leader_elect*]
#   Start a leader election client and gain leadership before executing the main loop. Enable this when running
#   replicated components for high availability.
#   Defaults to undef
#
# [*leader_elect_lease_duration*]
#   The duration that non-leader candidates will wait after observing a leadership renewal until attempting to
#   acquire leadership of a led but unrenewed leader slot. This is effectively the maximum duration that a leader can be
#   stopped before it is replaced by another candidate. This is only applicable if leader election is enabled.
#   Defaults to '15s'
#
# [*leader_elect_renew_deadline*]
#   The interval between attempts by the acting master to renew a leadership slot before it stops leading. This must
#   be less than or equal to the lease duration. This is only applicable if leader election is enabled.
#   Defaults to '10s'
#
# [*leader_elect_retry_period*]
#   The duration the clients should wait between attempting acquisition and renewal of a leadership. This is only applicable
#   if leader election is enabled.
#   Defaults to '2s"
#
# [*log_flush_frequency*]
#   Maximum number of seconds between log flushes
#   Defaults to 5s
#
# [*master*]
#   The address of the Kubernetes API server (overrides any value in kubeconfig)
#   Defaults to 'http://127.0.0.1:8080'
#
# [*policy_config_file*]
#   File with scheduler policy configuration
#   Defaults to undef
#
# [*port*]
#   The port that the scheduler's http service runs on
#   Defaults to 10251
#
# [*profiling*]
#   Enable profiling via web interface host:port/debug/pprof/
#   Defaults to true
#
# [*scheduler_name*]
#   Name of the scheduler, used to select which pods will be processed by this scheduler,
#    based on pod's annotation with key 'scheduler.alpha.kubernetes.io/name'
#    If not defined, defaults to default-scheduler
#   Defaults to undef
#
class kubernetes::master::scheduler (
  $ensure                      = $kubernetes::master::params::kube_scheduler_service_ensure,
  $journald_forward_enable     = $kubernetes::master::params::kube_scheduler_journald_forward_enable,
  $enable                      = $kubernetes::master::params::kube_scheduler_service_enable,
  $address                     = $kubernetes::master::params::kube_scheduler_address,
  $algorithm_provider          = $kubernetes::master::params::kube_scheduler_algorithm_provider,
  $google_json_key             = $kubernetes::master::params::kube_scheduler_google_json_key,
  $kube_api_burst              = $kubernetes::master::params::kube_scheduler_kube_api_burst,
  $kube_api_qps                = $kubernetes::master::params::kube_scheduler_kube_api_qps,
  $kubeconfig                  = $kubernetes::master::params::kube_scheduler_kubeconfig,
  $leader_elect                = $kubernetes::master::params::kube_scheduler_leader_elect,
  $leader_elect_lease_duration = $kubernetes::master::params::kube_scheduler_leader_elect_lease_duration,
  $leader_elect_renew_deadline = $kubernetes::master::params::kube_scheduler_leader_elect_renew_deadline,
  $leader_elect_retry_period   = $kubernetes::master::params::kube_scheduler_leader_elect_retry_period,
  $log_flush_frequency         = $kubernetes::master::params::kube_scheduler_log_flush_frequency,
  $master                      = $kubernetes::master::params::kube_scheduler_master,
  $policy_config_file          = $kubernetes::master::params::kube_scheduler_policy_config_file,
  $port                        = $kubernetes::master::params::kube_scheduler_port,
  $profiling                   = $kubernetes::master::params::kube_scheduler_profiling,
  $scheduler_name              = $kubernetes::master::params::kube_scheduler_scheduler_name,
  $verbosity                   = $kubernetes::master::params::kube_scheduler_verbosity,
  $extra_args                  = $kubernetes::master::params::kube_scheduler_extra_args,
) inherits kubernetes::master::params {
  validate_re($ensure, '^(running|stopped)$')
  validate_bool($enable)

  include ::kubernetes::master

  if $journald_forward_enable and $::operatingsystemmajrelease == 7 {
    file { '/etc/systemd/system/kube-scheduler.service.d':
      ensure => 'directory',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
    }
    file { '/etc/systemd/system/kube-scheduler.service.d/journald.conf':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template("${module_name}/systemd/scheduler_journald.conf.erb"),
    } ~>
    exec { 'reload systemctl daemon for kube-scheduler':
      command     => '/bin/systemctl daemon-reload',
      refreshonly => true,
    } ~> Service['kube-scheduler']
  }

  case $::osfamily {
    'redhat' : {
    }
    'debian' : {
      file { '/etc/default/kube-scheduler':
        ensure  => 'file',
        force   => true,
        content => template("${module_name}/etc/default/scheduler.erb"),
      } ~> Service['kube-scheduler']
    }
    default  : {
      fail("Unsupport OS: ${::osfamily}")
    }
  }

  file { '/etc/kubernetes/scheduler':
    ensure  => 'file',
    force   => true,
    content => template("${module_name}/etc/kubernetes/scheduler.erb"),
  } ~> Service['kube-scheduler']

  service { 'kube-scheduler':
    ensure => $ensure,
    enable => $enable,
  }
}
