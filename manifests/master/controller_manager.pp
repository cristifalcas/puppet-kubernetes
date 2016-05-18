# == Class: kubernetes::master::controller_manager
#
#
# [*ensure*]
#   Whether you want the controller-manager daemon to start up
#   Defaults to running
#
# [*enable*]
#   Whether you want the controller-manager daemon to start up at boot
#   Defaults to true
#
# [*address*]
#   The IP address to serve on (set to 0.0.0.0 for all interfaces)
#   Defaults to 127.0.0.1
#
# [*allocate_node_cidrs*]
#   Should CIDRs for Pods be allocated and set on the cloud provider.
#   Defaults to false
#
# [*cloud_config*]
#   The path to the cloud provider configuration file.  Empty string for no configuration file.
#   Defaults to undef
#
# [*cluster_cidr*]
#   CIDR Range for Pods in cluster.
#   Defaults to undef
#
# [*cluster_name*]
#   The instance prefix for the cluster
#   Defaults to kubernetes
#
# [*concurrent_endpoint_syncs*]
#   The number of endpoint syncing operations that will be done concurrently. Larger number =
#      faster endpoint updating, but more CPU (and network) load
#   Defaults to 5
#
# [*concurrent_rc_syncs*]
#   The number of replication controllers that are allowed to sync concurrently. Larger number = more
#      reponsive replica management, but more CPU (and network) load
#   Defaults to 5
#
# [*deleting_pods_burst*]
#   Number of nodes on which pods are bursty deleted in case of node failure. For more details look
#      into RateLimiter.
#   Defaults to 10
#
# [*deleting_pods_burst*]
#   Number of nodes per second on which pods are deleted in case of node failure.
#   Defaults to 0.1
#
# [*deployment_controller_sync_period*]
#   Period for syncing the deployments.
#   Defaults to 30s
#
# [*google_json_key*]
#   The Google Cloud Platform Service Account JSON Key to use for authentication.
#   Defaults to undef
#
# [*horizontal_pod_autoscaler_sync_period*]
#   The period for syncing the number of pods in horizontal pod autoscaler.
#   Defaults to 30s
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
#   Defaults to http://127.0.0.1:8080
#
# [*min_resync_period*]
#   The resync period in reflectors will be random between MinResyncPeriod and 2*MinResyncPeriod
#   Defaults to undef
#
# [*namespace_sync_period*]
#   The period for syncing namespace life-cycle updates
#   Defaults to 5m0s
#
# [*node_monitor_grace_period*]
#   Amount of time which we allow running Node to be unresponsive before marking it unhealty.
#      Must be N times more than kubelet's nodeStatusUpdateFrequency, where N means number
#      of retries allowed for kubelet to post node status.
#   Defaults to 40s
#
# [*node_monitor_period*]
#   The period for syncing NodeStatus in NodeController.
#   Defaults to 5s
#
# [*node_startup_grace_period*]
#   Amount of time which we allow starting Node to be unresponsive before marking it unhealty.
#   Defaults to 1m0s
#
# [*node_sync_period*]
#   The period for syncing nodes from cloudprovider. Longer periods will result in fewer calls to cloud
#      provider, but may delay addition of new nodes to cluster.
#   Defaults to 10s
#
# [*pod_eviction_timeout*]
#   The grace period for deleting pods on failed nodes.
#   Defaults to 5m0s
#
# [*port*]
#   The port that the controller-manager's http service runs on
#   Defaults to 10252
#
# [*root_ca_file*]
#   If set, this root certificate authority will be included in service account's token secret. This must be a
#      valid PEM-encoded CA bundle.
#   Defaults to undef
#
# [*service_account_private_key_file*]
#   Filename containing a PEM-encoded private RSA key used to sign service account tokens.
#   Defaults to undef
#
# [*service_sync_period*]
#   The period for syncing services with their external load balancers
#   Defaults to 5m0s
#
# [*terminated_pod_gc_threshold*]
#   Number of terminated pods that can exist before the terminated pod garbage collector starts
#      deleting terminated pods. If <= 0, the terminated pod garbage collector is disabled.
#   Defaults to 0
#
# [*concurrent_deployment_syncs*]
#   The number of deployment objects that are allowed to sync concurrently. Larger number = more responsive deployments, but more CPU (and network) load
#   Default 5
#
# [*concurrent_namespace_syncs*]
#   The number of namespace objects that are allowed to sync concurrently. Larger number = more responsive namespace termination, but more CPU (and network) load
#   Default 2
#
# [*concurrent_replicaset_syncs*]
#   The number of replica sets that are allowed to sync concurrently. Larger number = more responsive replica management, but more CPU (and network) load
#   Default 5
#
# [*concurrent_resource_quota_syncs*]
#   The number of resource quotas that are allowed to sync concurrently. Larger number = more responsive quota management, but more CPU (and network) load
#   Default 5
#
# [*daemonset_lookup_cache_size*]
#   The the size of lookup cache for daemonsets. Larger number = more responsive daemonsets, but more MEM load.
#   Default 1024
#
# [*kube_api_burst*]
#   Burst to use while talking with kubernetes apiserver
#   Default 30
#
# [*kube_api_qps*]
#   QPS to use while talking with kubernetes apiserver
#   Default 20
#
# [*leader_elect*]
#   Start a leader election client and gain leadership before executing the main loop. Enable this when running replicated components for high availability.
#   Default undef
#
# [*leader_elect_lease_duration*]
#   The duration that non-leader candidates will wait after observing a leadership renewal until attempting to acquire leadership of a led but unrenewed leader slot. This is effectively the maximum duration that a leader can be stopped before it is replaced by another candidate. This is only applicable if leader election is enabled.
#   Default '15s'
#
# [*leader_elect_renew_deadline*]
#   The interval between attempts by the acting master to renew a leadership slot before it stops leading. This must be less than or equal to the lease duration. This is only applicable if leader election is enabled.
#   Default '10s'
#
# [*leader_elect_retry_period*]
#   The duration the clients should wait between attempting acquisition and renewal of a leadership. This is only applicable if leader election is enabled.
#   Default '2s'
#
# [*replicaset_lookup_cache_size*]
#   The the size of lookup cache for replicatsets. Larger number = more responsive replica management, but more MEM load.
#   Default 4096
#
# [*minimum_version*]
#   Minimum supported Kubernetes version. Don't enable new features when
#   incompatbile with that version.
#   Default to 1.1.
#
class kubernetes::master::controller_manager (
  $ensure                                = $kubernetes::master::params::kube_controller_service_ensure,
  $enable                                = $kubernetes::master::params::kube_controller_service_enable,
  $address                               = $kubernetes::master::params::kube_controller_address,
  $allocate_node_cidrs                   = $kubernetes::master::params::kube_controller_allocate_node_cidrs,
  $cloud_config                          = $kubernetes::master::params::kube_controller_cloud_config,
  $cluster_cidr                          = $kubernetes::master::params::kube_controller_cluster_cidr,
  $cluster_name                          = $kubernetes::master::params::kube_controller_cluster_name,
  $concurrent_endpoint_syncs             = $kubernetes::master::params::kube_controller_concurrent_endpoint_syncs,
  $concurrent_rc_syncs                   = $kubernetes::master::params::kube_controller_concurrent_rc_syncs,
  $deleting_pods_burst                   = $kubernetes::master::params::kube_controller_deleting_pods_burst,
  $deleting_pods_qps                     = $kubernetes::master::params::kube_controller_deleting_pods_qps,
  $deployment_controller_sync_period     = $kubernetes::master::params::kube_controller_deployment_controller_sync_period,
  $google_json_key                       = $kubernetes::master::params::kube_controller_google_json_key,
  $horizontal_pod_autoscaler_sync_period = $kubernetes::master::params::kube_controller_horizontal_pod_autoscaler_sync_period,
  $kubeconfig                            = $kubernetes::master::params::kube_controller_kubeconfig,
  $log_flush_frequency                   = $kubernetes::master::params::kube_controller_log_flush_frequency,
  $master                                = $kubernetes::master::params::kube_controller_master,
  $min_resync_period                     = $kubernetes::master::params::kube_controller_min_resync_period,
  $namespace_sync_period                 = $kubernetes::master::params::kube_controller_namespace_sync_period,
  $node_monitor_grace_period             = $kubernetes::master::params::kube_controller_node_monitor_grace_period,
  $node_monitor_period                   = $kubernetes::master::params::kube_controller_node_monitor_period,
  $node_startup_grace_period             = $kubernetes::master::params::kube_controller_node_startup_grace_period,
  $node_sync_period                      = $kubernetes::master::params::kube_controller_node_sync_period,
  $pod_eviction_timeout                  = $kubernetes::master::params::kube_controller_pod_eviction_timeout,
  $port                                  = $kubernetes::master::params::kube_controller_port,
  $root_ca_file                          = $kubernetes::master::params::kube_controller_root_ca_file,
  $service_account_private_key_file      = $kubernetes::master::params::kube_controller_service_account_private_key_file,
  $service_sync_period                   = $kubernetes::master::params::kube_controller_service_sync_period,
  $terminated_pod_gc_threshold           = $kubernetes::master::params::kube_controller_terminated_pod_gc_threshold,
  $concurrent_deployment_syncs           = $kubernetes::master::params::kube_controller_concurrent_deployment_syncs,
  $concurrent_namespace_syncs            = $kubernetes::master::params::kube_controller_concurrent_namespace_syncs,
  $concurrent_replicaset_syncs           = $kubernetes::master::params::kube_controller_concurrent_replicaset_syncs,
  $concurrent_resource_quota_syncs       = $kubernetes::master::params::kube_controller_concurrent_resource_quota_syncs,
  $daemonset_lookup_cache_size           = $kubernetes::master::params::kube_controller_daemonset_lookup_cache_size,
  $kube_api_burst                        = $kubernetes::master::params::kube_controller_kube_api_burst,
  $kube_api_qps                          = $kubernetes::master::params::kube_controller_kube_api_qps,
  $leader_elect                          = $kubernetes::master::params::kube_controller_leader_elect,
  $leader_elect_lease_duration           = $kubernetes::master::params::kube_controller_leader_elect_lease_duration,
  $leader_elect_renew_deadline           = $kubernetes::master::params::kube_controller_leader_elect_renew_deadline,
  $leader_elect_retry_period             = $kubernetes::master::params::kube_controller_leader_elect_retry_period,
  $replicaset_lookup_cache_size          = $kubernetes::master::params::kube_controller_replicaset_lookup_cache_size,
  $extra_args                            = $kubernetes::master::params::kube_controller_args,
  $minimum_version                       = $kubernetes::master::params::kube_controller_minimum_version,
) inherits kubernetes::master::params {
  validate_re($ensure, '^(running|stopped)$')
  validate_bool($enable)

  include ::kubernetes::master

  validate_bool($allocate_node_cidrs)

  case $::osfamily {
    'Debian': {
      if ($::operatingsystem == 'ubuntu' and $::lsbdistcodename in ['lucid', 'precise', 'trusty'])
      or ($::operatingsystem == 'debian' and $::operatingsystemmajrelease in ['6', '7', '8']) {
        file { '/etc/kubernetes/controller-manager':
          ensure  => 'file',
          force   => true,
          content => template("${module_name}/etc/kubernetes/controller-manager.erb"),
        } ~> Service['kube-controller-manager']
        file { '/etc/default/kube-controller-manager':
          ensure  => 'file',
          force   => true,
          content => template("${module_name}/etc/default/controller-manager.erb"),
        } ~> Service['kube-apiserver']
        service { 'kube-controller-manager':
          ensure => $ensure,
          enable => $enable,
        }
      }
    }
    'RedHat': {
      if ($::operatingsystem in ['RedHat', 'CentOS'] and $::operatingsystemmajrelease in ['5', '6', '7']) {
        file { '/etc/kubernetes/controller-manager':
          ensure  => 'file',
          force   => true,
          content => template("${module_name}/etc/kubernetes/controller-manager.erb"),
        } ~> Service['kube-controller-manager']
        service { 'kube-controller-manager':
          ensure => $ensure,
          enable => $enable,
        }
      }
    }
  }
}
