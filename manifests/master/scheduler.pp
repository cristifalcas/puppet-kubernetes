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
# [*leader_elect*]
#   Start a leader election client and gain leadership before executing the main loop. Enable this when running replicated components for high availability.
#   Defaults to undef
#
# [*leader_elect_lease_duration*]
#   The duration that non-leader candidates will wait after observing a leadership renewal until attempting to acquire leadership of a led but unrenewed leader slot. This is effectively the maximum duration that a leader can be stopped before it is replaced by another candidate. This is only applicable if leader election is enabled.
#   Defaults to '15s'
#
# [*leader_elect_renew_deadline*]
#   The interval between attempts by the acting master to renew a leadership slot before it stops leading. This must be less than or equal to the lease duration. This is only applicable if leader election is enabled.
#   Defaults to '10s'
#
# [*leader_elect_retry_period*]
#   The duration the clients should wait between attempting acquisition and renewal of a leadership. This is only applicable if leader election is enabled.
#   Defaults to '2s"
#
# [*scheduler_name*]
#   Name of the scheduler, used to select which pods will be processed by this scheduler, based on pod's annotation with key 'scheduler.alpha.kubernetes.io/name'
#   Defaults to undef
#
# [*minimum_version*]
#   Minimum supported Kubernetes version. Don't enable new features when
#   incompatbile with that version.
#   Default to 1.1.
#
class kubernetes::master::scheduler (
  $ensure                      = $kubernetes::master::params::kube_scheduler_service_ensure,
  $enable                      = $kubernetes::master::params::kube_scheduler_service_enable,
  $address                     = $kubernetes::master::params::kube_scheduler_address,
  $bind_pods_burst             = $kubernetes::master::params::kube_scheduler_bind_pods_burst,
  $bind_pods_qps               = $kubernetes::master::params::kube_scheduler_bind_pods_qps,
  $google_json_key             = $kubernetes::master::params::kube_scheduler_google_json_key,
  $kubeconfig                  = $kubernetes::master::params::kube_scheduler_kubeconfig,
  $log_flush_frequency         = $kubernetes::master::params::kube_scheduler_log_flush_frequency,
  $master                      = $kubernetes::master::params::kube_scheduler_master,
  $port                        = $kubernetes::master::params::kube_scheduler_port,
  $leader_elect                = $kubernetes::master::params::kube_scheduler_leader_elect,
  $leader_elect_lease_duration = $kubernetes::master::params::kube_scheduler_leader_elect_lease_duration,
  $leader_elect_renew_deadline = $kubernetes::master::params::kube_scheduler_leader_elect_renew_deadline,
  $leader_elect_retry_period   = $kubernetes::master::params::kube_scheduler_leader_elect_retry_period,
  $scheduler_name              = $kubernetes::master::params::kube_scheduler_scheduler_name,
  $extra_args                  = $kubernetes::master::params::kube_scheduler_args,
  $minimum_version             = $kubernetes::master::params::kube_scheduler_minimum_version,
) inherits kubernetes::master::params {
  validate_re($ensure, '^(running|stopped)$')
  validate_bool($enable)

  include ::kubernetes::master


  case $::osfamily {
    'Debian': {
      if ($::operatingsystem == 'ubuntu' and $::lsbdistcodename in ['lucid', 'precise', 'trusty'])
      or ($::operatingsystem == 'debian' and $::operatingsystemmajrelease in ['6', '7', '8']) {
        file { '/etc/kubernetes/scheduler':
          ensure  => 'file',
          force   => true,
          content => template("${module_name}/etc/kubernetes/scheduler.erb"),
        } ~> Service['kube-scheduler']
        file { '/etc/default/kube-scheduler':
          ensure  => 'file',
          force   => true,
          content => template("${module_name}/etc/default/scheduler.erb"),
        } ~> Service['kube-scheduler']

        service { 'kube-scheduler':
          ensure => $ensure,
          enable => $enable,
        }
      }
    }
    'RedHat': {
      if ($::operatingsystem in ['RedHat', 'CentOS'] and $::operatingsystemmajrelease in ['5', '6', '7']) {
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
    }
  }
}
