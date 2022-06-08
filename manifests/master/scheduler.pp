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
# [*manage_as*]
#   How to manage the apiserver service. Valid values are: service, pod, container
#   Defaults to service
#
# [*container_image*]
#   From where to pull the image.
#   Defaults to gcr.io/google_containers/hyperkube-amd64:v1.3.5
#
# [*pod_cpu*]
#   CPU limits for this pod.
#   Defaults to 100mi
#
# [*pod_memory*]
#   Memory limits for this pod.
#   Defaults to 400Mi
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
# [*failure_domains*]
#   Indicate the "all topologies" set for an empty topologyKey when it's used for PreferredDuringScheduling pod anti-affinity.
#   (default "kubernetes.io/hostname,failure-domain.beta.kubernetes.io/zone,failure-domain.beta.kubernetes.io/region")
#   Defaults to undef
#
# [*google_json_key*]
#   The Google Cloud Platform Service Account JSON Key to use for authentication.
#   Defaults to undef
#
# [*hard_pod_affinity_symmetric_weight*]
#   RequiredDuringScheduling affinity is not symmetric, but there is an implicit PreferredDuringScheduling affinity
#    rule corresponding to every RequiredDuringScheduling affinity rule. --hard-pod-affinity-symmetric-weight represents
#    the weight of implicit PreferredDuringScheduling affinity rule.
#   Defaults to undef. (default 1)
#
# [*kube_api_burst*]
#   Burst to use while talking with kubernetes apiserver
#   Default 100
#
# [*kube_api_content_type*]
#   Content type of requests sent to apiserver.
#   Default to undef. (default "application/vnd.kubernetes.protobuf")
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
# [*log_dir*]
#   If non-empty, write log files in this directory
#
# [*log_file*]
#   If non-empty, use this log file
# 
# [*log_file_max_size*]
#   Defines the maximum size a log file can grow to. Unit is megabytes. If the value is 0, the maximum file size is unlimited. (default 1800)
#
# [*logtostderr*]
#   Log to standard error instead of files (default true)
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
#   Defaults to false
#
# [*scheduler_name*]
#   Name of the scheduler, used to select which pods will be processed by this scheduler,
#    based on pod's annotation with key 'scheduler.alpha.kubernetes.io/name'
#    If not defined, defaults to default-scheduler
#   Defaults to undef
#
# [*authorization_kubeconfig*]
#   Kubeconfig file pointing at the 'core' kubernetes server with enough rights to create 
#    subjectaccessreviews.authorization.k8s.io.
#    This is optional. If empty, all requests not skipped by authorization are forbidden.
#   Defaults to undef
# [*authentication_kubeconfig*]
#   Kubeconfig file pointing at the 'core' kubernetes server with enough rights to create 
#    tokenreviews.authentication.k8s.io. This is optional. If empty, all token requests are 
#    considered to be anonymous and no client CA is looked up in the cluster.
#
# [*authorization_always_allow_paths*]
#   A list of HTTP paths to skip during authorization, i.e. these are authorized without contacting the 'core' kubernetes server.
#   Default '/healthz'
#
# [*verbosity*]
#   Set logger verbosity
#   Defaults to 2
#
# [*extra_args*]
#   Add your own
#   Defaults to undef
#
class kubernetes::master::scheduler (
  $ensure                             = $kubernetes::master::params::kube_scheduler_service_ensure,
  $journald_forward_enable            = $kubernetes::master::params::kube_scheduler_journald_forward_enable,
  $enable                             = $kubernetes::master::params::kube_scheduler_service_enable,
  $manage_as                          = $kubernetes::master::params::kube_scheduler_manage_as,
  $container_image                    = $kubernetes::master::params::kube_scheduler_container_image,
  $pod_cpu                            = $kubernetes::master::params::kube_scheduler_pod_cpu,
  $pod_memory                         = $kubernetes::master::params::kube_scheduler_pod_memory,
  $address                            = $kubernetes::master::params::kube_scheduler_address,
  $algorithm_provider                 = $kubernetes::master::params::kube_scheduler_algorithm_provider,
  $failure_domains                    = $kubernetes::master::params::kube_scheduler_failure_domains,
  $google_json_key                    = $kubernetes::master::params::kube_scheduler_google_json_key,
  $hard_pod_affinity_symmetric_weight = $kubernetes::master::params::kube_scheduler_hard_pod_affinity_symmetric_weight,
  $kube_api_burst                     = $kubernetes::master::params::kube_scheduler_kube_api_burst,
  $kube_api_content_type              = $kubernetes::master::params::kube_scheduler_kube_api_content_type,
  $kube_api_qps                       = $kubernetes::master::params::kube_scheduler_kube_api_qps,
  $kubeconfig                         = $kubernetes::master::params::kube_scheduler_kubeconfig,
  $leader_elect                       = $kubernetes::master::params::kube_scheduler_leader_elect,
  $leader_elect_lease_duration        = $kubernetes::master::params::kube_scheduler_leader_elect_lease_duration,
  $leader_elect_renew_deadline        = $kubernetes::master::params::kube_scheduler_leader_elect_renew_deadline,
  $leader_elect_retry_period          = $kubernetes::master::params::kube_scheduler_leader_elect_retry_period,
  $log_dir			      = $kubernetes::master::params::kube_scheduler_log_dir,
  $log_file                           = $kubernetes::master::params::kube_scheduler_log_file,
  $log_file_max_size                  = $kubernetes::master::params::kube_scheduler_log_file_max_size,
  $logtostderr                        = $kubernetes::master::params::kube_scheduler_logtostderr,
  $log_flush_frequency                = $kubernetes::master::params::kube_scheduler_log_flush_frequency,
  $master                             = $kubernetes::master::params::kube_scheduler_master,
  $policy_config_file                 = $kubernetes::master::params::kube_scheduler_policy_config_file,
  $port                               = $kubernetes::master::params::kube_scheduler_port,
  $profiling                          = $kubernetes::master::params::kube_scheduler_profiling,
  $scheduler_name                     = $kubernetes::master::params::kube_scheduler_scheduler_name,
  $authentication_kubeconfig          = $kubernetes::master::params::kube_scheduler_authentication_kubeconfig,
  $authorization_kubeconfig           = $kubernetes::master::params::kube_scheduler_authorization_kubeconfig,
  $authorization_always_allow_paths   = $kubernetes::master::params::kube_scheduler_authorization_always_allow_paths,
  $verbosity                          = $kubernetes::master::params::kube_scheduler_verbosity,
  $extra_args                         = $kubernetes::master::params::kube_scheduler_extra_args,
) inherits kubernetes::master::params {
  validate_re($ensure, '^(running|stopped)$')
  validate_bool($enable)
  validate_re($manage_as, '^(service|pod|container)$')

  case $manage_as {
    'service'   : {
      include ::kubernetes::master

      case $::osfamily {
        'redhat' : {
        }
        'debian' : {
          file { '/etc/default/kube-scheduler':
            ensure  => 'file',
            force   => true,
            content => template("${module_name}/etc/default/scheduler.erb"),
            notify  => Service['kube-scheduler'],
          }
        }
        default  : {
          fail("Unsupport OS: ${::osfamily}")
        }
      }

      file { '/etc/kubernetes/scheduler':
        ensure  => 'file',
        force   => true,
        owner   => 'root',
        group   => 'root',
        content => template("${module_name}/etc/kubernetes/scheduler.erb"),
        notify  => Service['kube-scheduler'],
      }

      service { 'kube-scheduler':
        ensure => $ensure,
        enable => $enable,
      }

      if $log_dir {
        file {"$log_dir":
          ensure => 'directory',
        }
      }

      if $journald_forward_enable and $::operatingsystemmajrelease == '7' {
        file { '/etc/systemd/system/kube-scheduler.service.d':
          ensure => 'directory',
          owner  => 'root',
          group  => 'root',
          mode   => '0755',
        } ->
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
    }
    'pod'       : {
      if $enable {
        $ensure_file = 'file'
      } else {
        $ensure_file = 'absent'
      }

      file { '/etc/kubernetes/manifests/pod_kube-scheduler.yml':
        ensure  => $ensure_file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template("${module_name}/pods/pod_kube-scheduler.yml.erb"),
      }
    }
    'container' : {
      if $enable {
        $ensure_container = 'present'
      } else {
        $ensure_container = 'absent'
      }
      $args = inline_template("<%= scope.function_template(['kubernetes/_scheduler.erb']) %>")

      docker::run { 'kube-scheduler':
        ensure           => $ensure_container,
        image            => $container_image,
        command          => "/hyperkube scheduler ${args}",
        volumes          => ['/etc/pki:/etc/pki', '/etc/ssl:/etc/ssl', '/etc/kubernetes:/etc/kubernetes',],
        restart_service  => true,
        net              => 'host',
        privileged       => true,
        detach           => false,
        extra_parameters => ['--restart=always'],
      }
    }
    default     : {
    }
  }
}
