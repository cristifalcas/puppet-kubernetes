# == Class: kubernetes::master::controller_manager
# http://kubernetes.io/docs/admin/kube-controller-manager/
#
#
# [*ensure*]
#   Whether you want the controller-manager daemon to start up
#   Defaults to running
#
# [*journald_forward_enable*]
#   Fix for SIGPIPE sent to registry daemon during journald restart
#   Defaults to false
#
# [*enable*]
#   Whether you want the controller-manager daemon to start up at boot
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
# [*allocate_node_cidrs*]
#   Should CIDRs for Pods be allocated and set on the cloud provider.
#   Defaults to false
#
# [*cloud_config*]
#   The path to the cloud provider configuration file.  Empty string for no configuration file.
#   Defaults to undef
#
# [*cloud_provider*]
#   The provider for cloud services.  Empty string for no provider.
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
# [*cluster_signing_cert_file*]
#   Filename containing a PEM-encoded X509 CA certificate used to issue cluster-scoped certificates
#   Defaults to undef. (default "/etc/kubernetes/ca/ca.pem")
#
# [*cluster_signing_key_file*]
#   Filename containing a PEM-encoded RSA or ECDSA private key used to sign cluster-scoped certificates
#   Defaults to undef. (default "/etc/kubernetes/ca/ca.key")
#
# [*concurrent_deployment_syncs*]
#   The number of deployment objects that are allowed to sync concurrently. Larger number = more responsive deployments,
#   but more CPU (and network) load
#   Default 5
#
# [*concurrent_endpoint_syncs*]
#   The number of endpoint syncing operations that will be done concurrently. Larger number =
#      faster endpoint updating, but more CPU (and network) load
#   Defaults to 5
#
# [*concurrent_gc_syncs*]
#   The number of garbage collector workers that are allowed to sync concurrently.
#   Default undef. (default 20)
#
# [*concurrent_namespace_syncs*]
#   The number of namespace objects that are allowed to sync concurrently. Larger number = more responsive namespace
#   termination, but more CPU (and network) load
#   Default 2
#
# [*concurrent_replicaset_syncs*]
#   The number of replica sets that are allowed to sync concurrently. Larger number = more responsive replica management,
#   but more CPU (and network) load
#   Default 5
#
# [*concurrent_resource_quota_syncs*]
#   The number of resource quotas that are allowed to sync concurrently. Larger number = more responsive quota management,
#   but more CPU (and network) load
#   Default 5
#
# [*concurrent_rc_syncs*]
#   The number of replication controllers that are allowed to sync concurrently. Larger number = more
#      reponsive replica management, but more CPU (and network) load
#   Defaults to 5
#
# [*concurrent_service_syncs*]
#   The number of services that are allowed to sync concurrently.
#   Larger number = more responsive service management, but more CPU (and network) load
#   Defaults to undef. (default 1)
#
# [*concurrent_serviceaccount_token_syncs*]
#   The number of service account token objects that are allowed to sync concurrently.
#   Larger number = more responsive token generation, but more CPU (and network) load
#   Defaults to undef. (default 5)
#
# [*controller_start_interval*]
#   Interval between starting controller managers.
#   Defaults to undef.
#
# [*daemonset_lookup_cache_size*]
#   The the size of lookup cache for daemonsets. Larger number = more responsive daemonsets, but more MEM load.
#   Default 1024
#
# [*deployment_controller_sync_period*]
#   Period for syncing the deployments.
#   Defaults to 30s
#
# [*enable_dynamic_provisioning*]
#   Enable dynamic provisioning for environments that support it.
#   Defaults to undef. (default true)
#
# [*enable_garbage_collector*]
#   Enables the generic garbage collector. MUST be synced with the corresponding flag of the kube-apiserver.
#   Defaults to undef. (default true)
#
# [*google_json_key*]
#   The Google Cloud Platform Service Account JSON Key to use for authentication.
#   Defaults to undef
#
# [*horizontal_pod_autoscaler_sync_period*]
#   The period for syncing the number of pods in horizontal pod autoscaler.
#   Defaults to 30s
#
# [*kube_api_burst*]
#   Burst to use while talking with kubernetes apiserver
#   Default 30
#
# [*kube_api_burst*]
#   Burst to use while talking with kubernetes apiserver
#   Default 30
#
# [*kube_api_content_type*]
#   Content type of requests sent to apiserver.
#   Default to undef. (default "application/vnd.kubernetes.protobuf")
#
# [*kubeconfig*]
#   Path to kubeconfig file with authorization and master location information.
#   Defaults to undef
#
# [*leader_elect*]
#   Start a leader election client and gain leadership before executing the main loop. Enable this when running replicated
#   components for high availability.
#   Default undef
#
# [*leader_elect_lease_duration*]
#   The duration that non-leader candidates will wait after observing a leadership renewal until attempting to acquire
#   leadership of a led but unrenewed leader slot. This is effectively the maximum duration that a leader can be stopped
#   before it is replaced by another candidate. This is only applicable if leader election is enabled.
#   Default '15s'
#
# [*leader_elect_renew_deadline*]
#   The interval between attempts by the acting master to renew a leadership slot before it stops leading. This must be less
#   than or equal to the lease duration. This is only applicable if leader election is enabled.
#   Default '10s'
#
# [*leader_elect_retry_period*]
#   The duration the clients should wait between attempting acquisition and renewal of a leadership. This is only applicable if
#   leader election is enabled.
#   Default '2s'
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
# [*node_cidr_mask_size*]
#   Mask size for node cidr in cluster.
#   Defaults to undef. (default 24)
#
# [*node_eviction_rate*]
#   Number of nodes per second on which pods are deleted in case of node failure when a zone is healthy (see --unhealthy-zone-threshold
#     for definition of healthy/unhealthy). Zone refers to entire cluster in non-multizone clusters.
#   Defaults to undef. (default 0.1)
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
# [*profiling*]
#   Enable profiling via web interface host:port/debug/pprof/
#   Defaults to true
#
# [*pv_recycler_increment_timeout_nfs*]
#   the increment of time added per Gi to ActiveDeadlineSeconds for an NFS scrubber pod
#    If not defined, defaults to 30
#   Defaults to undef
#
# [*pv_recycler_minimum_timeout_hostpath*]
#   The minimum ActiveDeadlineSeconds to use for a HostPath Recycler pod.
#    This is for development and testing only and will not work in a multi-node cluster.
#    If not defined, defaults to 60
#   Defaults to undef
#
# [*pv_recycler_minimum_timeout_nfs*]
#   The minimum ActiveDeadlineSeconds to use for an NFS Recycler pod
#    If not defined, defaults to 300
#   Defaults to undef
#
# [*pv_recycler_pod_template_filepath_hostpath*]
#   The file path to a pod definition used as a template for HostPath persistent volume recycling.
#    This is for development and testing only and will not work in a multi-node cluster.
#   Defaults to undef
#
# [*pv_recycler_pod_template_filepath_nfs*]
#   The file path to a pod definition used as a template for NFS persistent volume recycling
#   Defaults to undef
#
# [*pv_recycler_timeout_increment_hostpath*]
#   the increment of time added per Gi to ActiveDeadlineSeconds for a HostPath scrubber pod.
#    This is for development and testing only and will not work in a multi-node cluster.
#    If not defined, defaults to 30
#   Defaults to undef
#
# [*pvclaimbinder_sync_period*]
#   The period for syncing persistent volumes and persistent volume claims
#    If not defined, defaults to 10m0s
#   Defaults to undef
#
# [*replicaset_lookup_cache_size*]
#   The the size of lookup cache for replicatsets. Larger number = more responsive replica management, but more MEM load.
#   Default 4096
#
# [*replication_controller_lookup_cache_size*]
#   The the size of lookup cache for replication controllers. Larger number = more responsive replica management, but more MEM load.
#   Default 4096
#
# [*resource_quota_sync_period*]
#   The period for syncing quota usage status in the system
#   Default 5m0s
#
# [*root_ca_file*]
#   If set, this root certificate authority will be included in service account's token secret.
#    This must be a valid PEM-encoded CA bundle.
#   Defaults to undef
#
# [*secondary_node_eviction_rate*]
#   Number of nodes per second on which pods are deleted in case of node failure when a zone is unhealthy
#    (see --unhealthy-zone-threshold for definition of healthy/unhealthy). Zone refers to entire cluster
#    in non-multizone clusters. This value is implicitly overridden to 0 if the cluster size is smaller
#    than --large-cluster-size-threshold.
#   Defaults to undef. (default 0.01)
#
# [*service_account_private_key_file*]
#   Filename containing a PEM-encoded private RSA key used to sign service account tokens.
#   Defaults to undef
#
# [*service_cluster_ip_range*]
#   CIDR Range for Services in cluster.
#   Defaults to undef.
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
# [*unhealthy_zone_threshold*]
#   Fraction of Nodes in a zone which needs to be not Ready (minimum 3) for zone to be treated as unhealthy.
#   Defaults to undef. (default 0.55)
#
# [*kube_api_qps*]
#  QPS to use while talking with kubernetes apiserver
#   Defaults to 20
#
# [*verbosity*]
#   Set log verbosity
#   Defaults to 2
#
# [*extra_args*]
#   Add your own
#   Defaults to undef.
#
class kubernetes::master::controller_manager (
  $ensure                                     = $kubernetes::master::params::kube_controller_service_ensure,
  $journald_forward_enable                    = $kubernetes::master::params::kube_controller_journald_forward_enable,
  $enable                                     = $kubernetes::master::params::kube_controller_service_enable,
  $manage_as                                  = $kubernetes::master::params::kube_controller_manage_as,
  $container_image                            = $kubernetes::master::params::kube_controller_container_image,
  $pod_cpu                                    = $kubernetes::master::params::kube_controller_pod_cpu,
  $pod_memory                                 = $kubernetes::master::params::kube_controller_pod_memory,
  $address                                    = $kubernetes::master::params::kube_controller_address,
  $allocate_node_cidrs                        = $kubernetes::master::params::kube_controller_allocate_node_cidrs,
  $cloud_config                               = $kubernetes::master::params::kube_controller_cloud_config,
  $cloud_provider                             = $kubernetes::master::params::kube_controller_cloud_provider,
  $cluster_cidr                               = $kubernetes::master::params::kube_controller_cluster_cidr,
  $cluster_name                               = $kubernetes::master::params::kube_controller_cluster_name,
  $cluster_signing_cert_file                  = $kubernetes::master::params::kube_controller_cluster_signing_cert_file,
  $cluster_signing_key_file                   = $kubernetes::master::params::kube_controller_cluster_signing_key_file,
  $concurrent_deployment_syncs                = $kubernetes::master::params::kube_controller_concurrent_deployment_syncs,
  $concurrent_endpoint_syncs                  = $kubernetes::master::params::kube_controller_concurrent_endpoint_syncs,
  $concurrent_gc_syncs                        = $kubernetes::master::params::kube_controller_concurrent_gc_syncs,
  $concurrent_namespace_syncs                 = $kubernetes::master::params::kube_controller_concurrent_namespace_syncs,
  $concurrent_replicaset_syncs                = $kubernetes::master::params::kube_controller_concurrent_replicaset_syncs,
  $concurrent_resource_quota_syncs            = $kubernetes::master::params::kube_controller_concurrent_resource_quota_syncs,
  $concurrent_rc_syncs                        = $kubernetes::master::params::kube_controller_concurrent_rc_syncs,
  $concurrent_service_syncs                   = $kubernetes::master::params::kube_controller_concurrent_service_syncs,
  $concurrent_serviceaccount_token_syncs      = $kubernetes::master::params::kube_controller_concurrent_serviceaccount_token_syncs,
  $controller_start_interval                  = $kubernetes::master::params::kube_controller_controller_start_interval,
  $daemonset_lookup_cache_size                = $kubernetes::master::params::kube_controller_daemonset_lookup_cache_size,
  $deployment_controller_sync_period          = $kubernetes::master::params::kube_controller_deployment_controller_sync_period,
  $enable_dynamic_provisioning                = $kubernetes::master::params::kube_controller_enable_dynamic_provisioning,
  $enable_garbage_collector                   = $kubernetes::master::params::kube_controller_enable_garbage_collector,
  $google_json_key                            = $kubernetes::master::params::kube_controller_google_json_key,
  $horizontal_pod_autoscaler_sync_period      = $kubernetes::master::params::kube_controller_horizontal_pod_autoscaler_sync_period,
  $kube_api_burst                             = $kubernetes::master::params::kube_controller_kube_api_burst,
  $kube_api_content_type                      = $kubernetes::master::params::kube_controller_kube_api_content_type,
  $kube_api_qps                               = $kubernetes::master::params::kube_controller_kube_api_qps,
  $kubeconfig                                 = $kubernetes::master::params::kube_controller_kubeconfig,
  $leader_elect                               = $kubernetes::master::params::kube_controller_leader_elect,
  $leader_elect_lease_duration                = $kubernetes::master::params::kube_controller_leader_elect_lease_duration,
  $leader_elect_renew_deadline                = $kubernetes::master::params::kube_controller_leader_elect_renew_deadline,
  $leader_elect_retry_period                  = $kubernetes::master::params::kube_controller_leader_elect_retry_period,
  $master                                     = $kubernetes::master::params::kube_controller_master,
  $min_resync_period                          = $kubernetes::master::params::kube_controller_min_resync_period,
  $namespace_sync_period                      = $kubernetes::master::params::kube_controller_namespace_sync_period,
  $node_monitor_grace_period                  = $kubernetes::master::params::kube_controller_node_monitor_grace_period,
  $node_monitor_period                        = $kubernetes::master::params::kube_controller_node_monitor_period,
  $node_cidr_mask_size                        = $kubernetes::master::params::kube_controller_node_cidr_mask_size,
  $node_eviction_rate                         = $kubernetes::master::params::kube_controller_node_eviction_rate,
  $node_startup_grace_period                  = $kubernetes::master::params::kube_controller_node_startup_grace_period,
  $node_sync_period                           = $kubernetes::master::params::kube_controller_node_sync_period,
  $pod_eviction_timeout                       = $kubernetes::master::params::kube_controller_pod_eviction_timeout,
  $port                                       = $kubernetes::master::params::kube_controller_port,
  $profiling                                  = $kubernetes::master::params::kube_controller_profiling,
  $pv_recycler_increment_timeout_nfs          = $kubernetes::master::params::kube_controller_pv_recycler_increment_timeout_nfs,
  $pv_recycler_minimum_timeout_hostpath       = $kubernetes::master::params::kube_controller_pv_recycler_minimum_timeout_hostpath,
  $pv_recycler_minimum_timeout_nfs            = $kubernetes::master::params::kube_controller_pv_recycler_minimum_timeout_nfs,
  $pv_recycler_pod_template_filepath_hostpath = $kubernetes::master::params::kube_controller_pv_recycler_pod_template_filepath_hostpath,
  $pv_recycler_pod_template_filepath_nfs      = $kubernetes::master::params::kube_controller_pv_recycler_pod_template_filepath_nfs,
  $pv_recycler_timeout_increment_hostpath     = $kubernetes::master::params::kube_controller_pv_recycler_timeout_increment_hostpath,
  $pvclaimbinder_sync_period                  = $kubernetes::master::params::kube_controller_pvclaimbinder_sync_period,
  $replicaset_lookup_cache_size               = $kubernetes::master::params::kube_controller_replicaset_lookup_cache_size,
  $replication_controller_lookup_cache_size   = $kubernetes::master::params::kube_controller_replication_controller_lookup_cache_size,
  $resource_quota_sync_period                 = $kubernetes::master::params::kube_controller_resource_quota_sync_period,
  $root_ca_file                               = $kubernetes::master::params::kube_controller_root_ca_file,
  $secondary_node_eviction_rate               = $kubernetes::master::params::kube_controller_secondary_node_eviction_rate,
  $service_account_private_key_file           = $kubernetes::master::params::kube_controller_service_account_private_key_file,
  $service_cluster_ip_range                   = $kubernetes::master::params::kube_controller_service_cluster_ip_range,
  $service_sync_period                        = $kubernetes::master::params::kube_controller_service_sync_period,
  $terminated_pod_gc_threshold                = $kubernetes::master::params::kube_controller_terminated_pod_gc_threshold,
  $unhealthy_zone_threshold                   = $kubernetes::master::params::kube_controller_unhealthy_zone_threshold,
  $verbosity                                  = $kubernetes::master::params::kube_controller_verbosity,
  $extra_args                                 = $kubernetes::master::params::kube_controller_extra_args,
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
          file { '/etc/default/kube-controller-manager':
            ensure  => 'file',
            force   => true,
            content => template("${module_name}/etc/default/controller-manager.erb"),
            notify  => Service['kube-controller-manager'],
          }
        }
        default  : {
          fail("Unsupport OS: ${::osfamily}")
        }
      }

      file { '/etc/kubernetes/controller-manager':
        ensure  => 'file',
        force   => true,
        content => template("${module_name}/etc/kubernetes/controller-manager.erb"),
        notify  => Service['kube-controller-manager'],
      }

      service { 'kube-controller-manager':
        ensure => $ensure,
        enable => $enable,
      }

      if $journald_forward_enable and $::operatingsystemmajrelease == '7' {
        file { '/etc/systemd/system/kube-controller-manager.service.d':
          ensure => 'directory',
          owner  => 'root',
          group  => 'root',
          mode   => '0755',
        } ->
        file { '/etc/systemd/system/kube-controller-manager.service.d/journald.conf':
          ensure  => file,
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          content => template("${module_name}/systemd/controller_manager_journald.conf.erb"),
        } ~>
        exec { 'reload systemctl daemon for kube-controller-manager':
          command     => '/bin/systemctl daemon-reload',
          refreshonly => true,
        } ~> Service['kube-controller-manager']
      }
    }
    'pod'       : {
      if $enable {
        $ensure_file = 'file'
      } else {
        $ensure_file = 'absent'
      }

      file { '/etc/kubernetes/manifests/pod_kube-controller-manager.yml':
        ensure  => $ensure_file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template("${module_name}/pods/pod_kube-controller-manager.yml.erb"),
      }
    }
    'container' : {
      if $enable {
        $ensure_container = 'present'
      } else {
        $ensure_container = 'absent'
      }
      $args = inline_template("<%= scope.function_template(['kubernetes/_controller-manager.erb']) %>")

      docker::run { 'kube-controller-manager':
        ensure           => $ensure_container,
        image            => $container_image,
        command          => '/hyperkube controller-manager ${args}',
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
