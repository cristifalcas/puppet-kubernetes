# == Class: kubernetes::node::kubelet
# http://kubernetes.io/docs/admin/kubelet/
#
# Module to install an up-to-date version of kubelet from package.
#
# === Parameters
#
# [*ensure*]
#   Whether you want to kubelet daemon to start up
#   Defaults to running
#
# [*journald_forward_enable*]
#   Fix for SIGPIPE sent to registry daemon during journald restart
#   Defaults to false
#
# [*enable*]
#   Whether you want to kubelet daemon to start up at boot
#   Defaults to true
#
# [*pod_manifest_path_purge*]
#   Whether to purge to pods dir
#   Defaults to false
#
## Parameters ##
#
# [*address*]
#   The address for the info server to serve on (set to 0.0.0.0 or "" for all interfaces)
#   Defaults to '127.0.0.1'
#
# [*allow_privileged*]
#   If true, allow containers to request privileged mode.
#   Defaults to false
#
# [*api_servers*]
#   List of Kubernetes API servers for publishing events, and reading pods and services. (ip:port), comma separated.
#   Type: Array or String
#   Defaults to 'http://127.0.0.1:8080'
#
# [*cadvisor_port*]
#   The port of the localhost cAdvisor endpoint
#   Defaults to undef
#
# [*cert_dir*]
#   The directory where the TLS certs are located (by default /var/run/kubernetes).
#   If --tls_cert_file and --tls_private_key_file are provided, this flag will be ignored.
#   Defaults to /var/run/kubernetes
#
# [*cgroup_root*]
#   Optional root cgroup to use for pods. This is handled by the container runtime on a best effort basis.
#    Default: '', which means use the container runtime default.
#   Defaults to undef
#
# [*chaos_chance*]
#   If > 0.0, introduce random client errors and latency. Intended for testing. [default=0.0]
#   Defaults to undef
#
# [*cloud_config*]
#   The path to the cloud provider configuration file.  Empty string for no configuration file.
#   Default undef
#
# [*cloud_provider*]
#   The provider for cloud services. By default, kubelet will attempt to auto-detect the cloud provider.
#   Specify empty string for running with no cloud provider. [default=auto-detect]
#   Default undef. (default "auto-detect")
#
# [*cluster_dns*]
#   IP address for a cluster DNS server.  This value is used for containers' DNS server in case of Pods with "dnsPolicy=ClusterFirst"
#   Defaults to undef
#
# [*cluster_domain*]
#   Domain for this cluster.  If set, kubelet will configure all containers to search this domain in addition to the host's search domains
#   Defaults to undef
#
# [*configure_cbr0*]
#   If true, kubelet will configure cbr0 based on Node.Spec.PodCIDR.
#   Defaults to undef
#
# [*container_runtime*]
#   The container runtime to use. Possible values: 'docker', 'rkt'. Default: 'docker'.
#   Defaults to undef
#
# [*container_runtime_endpoint*]
#   The unix socket endpoint of remote runtime service. If not empty, this option will
#   override --container-runtime. This is an experimental feature. Intended for testing only.
#   Defaults to undef.
#
# [*containerized*]
#   Experimental support for running kubelet in a container.  Intended for testing. [default=false]
#   Defaults to undef
#
# [*cpu_cfs_quota*]
#   Enable CPU CFS quota enforcement for containers that specify CPU limits
#    If undefined, defaults to true
#   Defaults to undef
#
# [*docker_endpoint*]
#   If non-empty, use this for the docker endpoint to communicate with
#   Defaults to undef
#
# [*docker_exec_handler*]
#   Handler to use when executing a command in a container.
#    Valid values are 'native' and 'nsenter'. Defaults to 'native'.
#   Defaults to undef
#
# [*enable_controller_attach_detach*]
#   Enables the Attach/Detach controller to manage attachment/detachment of volumes scheduled to this node,
#   and disables kubelet from executing any attach/detach operations
#   Defaults to undef. (default true)
#
# [*enable_custom_metrics*]
#   Support for gathering custom metrics.
#    If undefined, defaults to false
#   Defaults to undef
#
# [*enable_debugging_handlers*]
#   Enables server endpoints for log collection and local running of containers and commands
#    If undefined, defaults to true
#   Defaults to undef
#
# [*enable_server*]
#   Enable the Kubelet's server
#    If undefined, defaults to true
#   Defaults to undef
#
# [*event_burst*]
#   Maximum size of a bursty event records, temporarily allows event records to burst to this number,
#    while still not exceeding event-qps. Only used if --event-qps > 0
#    If undefined, defaults to 10
#   Defaults to undef
#
# [*event_qps*]
#   If > 0, limit event creations per second to this value. If 0, unlimited.
#    If undefined, defaults to 5
#   Defaults to undef
#
# [*eviction_hard*]
#   A set of eviction thresholds (e.g. memory.available<1Gi) that if met would trigger a pod eviction.
#   Defaults to undef. (default "memory.available<100Mi")
#
# [*eviction_max_pod_grace_period*]
#   Maximum allowed grace period (in seconds) to use when terminating pods in response to a soft eviction
#   threshold being met.  If negative, defer to pod specified value.
#   Defaults to undef.
#
# [*eviction_minimum_reclaim*]
#   A set of minimum reclaims (e.g. imagefs.available=2Gi) that describes the minimum amount of resource
#   the kubelet will reclaim when performing a pod eviction if that resource is under pressure.
#   Defaults to undef
#
# [*eviction_pressure_transition_period*]
#   Duration for which the kubelet has to wait before transitioning out of an eviction pressure condition.
#   Defaults to undef. (default 5m0s)
#
# [*eviction_soft*]
#   A set of eviction thresholds (e.g. memory.available<1.5Gi) that if met over a corresponding grace period would trigger a pod eviction.
#   Defaults to undef
#
# [*eviction_soft_grace_period*]
#   A set of eviction grace periods (e.g. memory.available=1m30s) that correspond to how long a soft eviction threshold must
#   hold before triggering a pod eviction.
#   Defaults to undef
#
# [*exit_on_lock_contention*]
#   Whether kubelet should exit upon lock-file contention.
#   Defaults to undef
#
# [*file_check_frequency*]
#   Duration between checking config files for new data
#   Defaults to undef
#
# [*google_json_key*]
#   The Google Cloud Platform Service Account JSON Key to use for authentication.
#   Default undef
#
# [*hairpin_mode*]
#   How should the kubelet setup hairpin NAT. This allows endpoints of a Service to loadbalance back
#   to themselves if they should try to access their own Service. Valid values are "promiscuous-bridge",
#   "hairpin-veth" and "none".
#   Defaults to undef. (default "promiscuous-bridge")
#
# [*healthz_bind_address*]
#   The IP address for the healthz server to serve on, defaulting to 127.0.0.1 (set to 0.0.0.0 for all interfaces)
#   Defaults to undef
#
# [*healthz_port*]
#   The port of the localhost healthz endpoint
#   Defaults to undef
#
# [*host_ipc_sources*]
#   Comma-separated list of sources from which the Kubelet allows pods to use the host ipc namespace. [default="*"]
#   Defaults to undef. (default [*])
#
# [*host_network_sources*]
#   Comma-separated list of sources from which the Kubelet allows pods to use of host network. [default="*"]
#   Defaults to undef. (default [*])
#
# [*host_pid_sources*]
#   Comma-separated list of sources from which the Kubelet allows pods to use the host pid namespace. [default="*"]
#   Defaults to undef. (default [*])
#
# [*hostname_override*]
#   If non-empty, will use this string as identification instead of the actual hostname.
#   Defaults to $::fqdn
#
# [*http_check_frequency*]
#   Duration between checking http for new data
#    If undefined, defaults to 20s
#   Defaults to undef
#
# [*image_gc_high_threshold*]
#   The percent of disk usage after which image garbage collection is always run.
#   Default=90%
#
# [*image_gc_low_threshold*]
#   The percent of disk usage before which image garbage collection is never run. Lowest disk usage to garbage collect to.
#   Default=80%
#
# [*image_service_endpoint*]
#   The unix socket endpoint of remote image service. If not specified, it will be the same with container-runtime-endpoint by default.
#   This is an experimental feature. Intended for testing only.
#   Defaults to undef.
#
# [*iptables_drop_bit*]
#   The bit of the fwmark space to mark packets for dropping. Must be within the range [0, 31].
#   Defaults to undef. (default 15)
#
# [*iptables_masquerade_bit*]
#   The bit of the fwmark space to mark packets for SNAT. Must be within the range [0, 31]. Please match this parameter
#   with corresponding parameter in kube-proxy.
#   Defaults to undef. (default 14)
#
# [*kube_api_burst*]
#   Burst to use while talking with kubernetes apiserver
#   Defaults to undef. (default 10)
#
# [*kube_api_content_type*]
#   Content type of requests sent to apiserver.
#   Defaults to undef. (default "application/vnd.kubernetes.protobuf")
#
# [*kube_api_qps*]
#   QPS to use while talking with kubernetes apiserver
#   Defaults to undef. (default 5)
#
# [*kube_reserved*]
#   A set of ResourceName=ResourceQuantity (e.g. cpu=200m,memory=150G) pairs that describe resources reserved for
#   kubernetes system components. Currently only cpu and memory are supported.
#   Defaults to undef
#
# [*kubeconfig*]
#   Path to a kubeconfig file, specifying how to authenticate to API server (the master location is set by the api-servers flag).
#    If undefined, defaults to /var/lib/kubelet/kubeconfig
#   Defaults to undef
#
# [*kubelet_cgroups*]
#   Optional absolute name of cgroups to create and run the Kubelet in.
#   Defaults to undef
#
# [*lock_file*]
#   Warning: Alpha feature. The path to file for kubelet to use as a lock file.
#   Defaults to undef
#
# [*low_diskspace_threshold_mb*]
#   The absolute free disk space, in MB, to maintain. When disk space falls below this threshold, new pods would be rejected.
#   Default=256
#
# [*make_iptables_util_chains*]
#   If true, kubelet will ensure iptables utility rules are present on host.
#   Defaults to undef. (default true)
#
# [*manifest_url*]
#   URL for accessing the container manifest
#   Defaults to undef
#
# [*manifest_url_header*]
#   HTTP header to use when accessing the manifest URL, with the key separated from the value with a ':', as in 'key:value'
#   Defaults to undef
#
# [*master_service_namespace*]
#   The namespace from which the Kubernetes master services should be injected into pods
#   Defaults to undef
#
# [*max_open_files*]
#   Number of files that can be opened by Kubelet process. [default=1000000]
#   Defaults to 1000000
#
# [*max_pods*]
#   Number of Pods that can run on this Kubelet.
#   Defaults to 110
#
# [*minimum_image_ttl_duration*]
#   Minimum age for a unused image before it is garbage collected.  Examples: '300ms', '10s' or '2h45m'.
#   Defaults to 2m0s
#
# [*node_ip*]
#   IP address of the node. If set, kubelet will use this IP address for the node
#   Defaults to undef
#
# [*node_labels*]
#   Warning: Alpha feature. Labels to add when registering the node in the cluster.  Labels must be key=value pairs separated by ','.
#   Defaults to undef
#
# [*node_status_update_frequency*]
#   Specifies how often kubelet posts node status to master. Note: be cautious when changing the constant,
#    it must work with nodeMonitorGracePeriod in nodecontroller. Default: 10s
#   Defaults to 10s
#
# [*non_masquerade_cidr*]
#   Traffic to IPs outside this range will use IP masquerade.
#   Defaults to undef
#
# [*oom_score_adj*]
#   The oom-score-adj value for kubelet process. Values must be within the range [-1000, 1000]
#   Defaults to undef
#
# [*outofdisk_transition_frequency*]
#   Duration for which the kubelet has to wait before transitioning out of out-of-disk node condition status. Default: 5m0s
#   Defaults to '5m0s'
#
# [*pod_cidr*]
#   The CIDR to use for pod IP addresses, only used in standalone mode.
#    In cluster mode, this is obtained from the master.
#   Defaults to undef
#
# [*pod_infra_container_image*]
#   The image whose network/ipc namespaces containers in each pod will use.
#   Defaults to undef
#
# [*pod_manifest_path*]
#   Path to to the directory containing pod manifest files to run, or the path to a single pod manifest file.
#   Defaults to undef.
#
# [*pods_per_core*]
#   Number of Pods per core that can run on this Kubelet. The total number of Pods on this Kubelet cannot exceed max-pods,
#   so max-pods will be used if this calculation results in a larger number of Pods allowed on the Kubelet.
#   A value of 0 disables this limit.
#   Defaults to undef.
#
# [*port*]
#   The port for the info server to serve on
#   Defaults to 10250
#
# [*protect_kernel_defaults*]
#   Default kubelet behaviour for kernel tuning. If set, kubelet errors if any of kernel tunables is different than kubelet defaults.
#   Defaults to undef.
#
# [*read_only_port*]
#   The read-only port for the Kubelet to serve on (set to 0 to disable)
#   Defaults to undef
#
# [*reconcile_cidr*]
#   Reconcile node CIDR with the CIDR specified by the API server. No-op if register-node or configure-cbr0 is false.
#   Defaults to undef
#
# [*register_node*]
#   Register the node with the apiserver (defaults to true if --api-server is set)
#   Defaults to true
#
# [*register_schedulable*]
#   Register the node as schedulable. No-op if register-node is false.
#   Defaults to undef
#
# [*registry_burst*]
#   Maximum size of a bursty pulls, temporarily allows pulls to burst to this number,
#    while still not exceeding registry-qps. Only used if --registry-qps > 0
#    If undefined, defaults to 10
#   Defaults to undef
#
# [*registry_qps*]
#   If > 0, limit registry pull QPS to this value.  If 0, unlimited. [default=5.0]
#    If undefined, defaults to 5
#   Defaults to undef
#
# [*require_kubeconfig*]
#   If true the Kubelet will exit if there are configuration errors, and will ignore the value
#   of --api-servers in favor of the server defined in the kubeconfig file.
#   Defaults to undef
#
# [*resolv_conf*]
#   Resolver configuration file used as the basis for the container DNS resolution configuration.
#    If undefined, defaults to /etc/resolv.conf
#   Defaults to undef
#
# [*rkt_api_endpoint*]
#   The endpoint of the rkt API service to communicate with. Only used if --container-runtime='rkt'.
#   Defaults to undef. (default "localhost:15441")
#
# [*rkt_path*]
#   Path of rkt binary. Leave empty to use the first rkt in $PATH.  Only used if --container-runtime='rkt'
#   Defaults to undef
#
# [*root_dir*]
#   Directory path for managing kubelet files (volume mounts,etc).
#   Defaults to undef
#
# [*runonce*]
#   If true, exit after spawning pods from local manifests or remote urls. Exclusive with --api-servers, and --enable-server
#   Defaults to undef
#
# [*runtime_cgroups*]
#   Optional absolute name of cgroups to create and run the runtime in.
#   Defaults to undef
#
# [*runtime_request_timeout*]
#   Timeout of all runtime requests except long running request - pull, logs, exec and attach. When timeout exceeded,
#   kubelet will cancel the request, throw out an error and retry later.
#   Defaults to undef. (default 2m0s)
#
# [*serialize_image_pulls*]
#   Pull images one at a time. We recommend *not* changing the default value on nodes that run
#    docker daemon with version < 1.9 or an Aufs storage backend. Issue #10959 has more details. [default=true]
#   Defaults to true
#
# [*streaming_connection_idle_timeout*]
#   Maximum time a streaming connection can be idle before the connection is automatically closed. 0 indicates no timeout. Example: '5m'
#    If undefined, defaults to 4h0m0s
#   Defaults to undef
#
# [*sync_frequency*]
#   Max period between synchronizing running containers and config
#   Defaults to undef
#
# [*system_cgroups*]
#   Optional absolute name of cgroups in which to place all non-kernel processes that are not already inside a
#   cgroup under `/`. Empty for no container. Rolling back the flag requires a reboot.
#   Defaults to undef
#
# [*system_reserved*]
#   A set of ResourceName=ResourceQuantity (e.g. cpu=200m,memory=150G) pairs that describe resources reserved for non-kubernetes
#   components. Currently only cpu and memory are supported.
#   Default undef
#
# [*tls_cert_file*]
#   File containing x509 Certificate for HTTPS.  (CA cert, if any, concatenated after server cert).
#   If --tls_cert_file and --tls_private_key_file are not provided, a self-signed certificate and key
#   are generated for the public address and saved to the directory passed to --cert_dir.
#   Default=undef
#
# [*tls_private_key_file*]
#   File containing x509 private key matching --tls_cert_file.
#   Default=undef
#
# [*volume_stats_agg_period*]
#   Specifies interval for kubelet to calculate and cache the volume disk usage for all pods and volumes.
#     To disable volume calculations, set to 0.  Default: '1m'
#   Default to '1m0s'
#
# [*verbosity*]
#   Set logger verbosity
#   Defaults to 2
#
# [*extra_args*]
#   Add your own!
#
class kubernetes::node::kubelet (
  $ensure                                = $kubernetes::node::params::kubelet_service_ensure,
  $journald_forward_enable               = $kubernetes::node::params::kubelet_journald_forward_enable,
  $enable                                = $kubernetes::node::params::kubelet_service_enable,
  $pod_manifest_path_purge               = $kubernetes::node::params::kubelet_pod_manifest_path_purge,
  $address                               = $kubernetes::node::params::kubelet_address,
  $allow_privileged                      = $kubernetes::node::params::kubelet_allow_privileged,
  $api_servers                           = $kubernetes::node::params::kubelet_api_servers,
  $cadvisor_port                         = $kubernetes::node::params::kubelet_cadvisor_port,
  $cert_dir                              = $kubernetes::node::params::kubelet_cert_dir,
  $cgroup_root                           = $kubernetes::node::params::kubelet_cgroup_root,
  $chaos_chance                          = $kubernetes::node::params::kubelet_chaos_chance,
  $cloud_config                          = $kubernetes::node::params::kubelet_cloud_config,
  $cloud_provider                        = $kubernetes::node::params::kubelet_cloud_provider,
  $cluster_dns                           = $kubernetes::node::params::kubelet_cluster_dns,
  $cluster_domain                        = $kubernetes::node::params::kubelet_cluster_domain,
  $configure_cbr0                        = $kubernetes::node::params::kubelet_container_runtime,
  $container_runtime                     = $kubernetes::node::params::kubelet_container_runtime,
  $container_runtime_endpoint            = $kubernetes::node::params::kubelet_container_runtime_endpoint,
  $containerized                         = $kubernetes::node::params::kubelet_config,
  $cpu_cfs_quota                         = $kubernetes::node::params::kubelet_cpu_cfs_quota,
  $docker_endpoint                       = $kubernetes::node::params::kubelet_docker_endpoint,
  $docker_exec_handler                   = $kubernetes::node::params::kubelet_docker_exec_handler,
  $enable_controller_attach_detach       = $kubernetes::node::params::kubelet_enable_controller_attach_detach,
  $enable_custom_metrics                 = $kubernetes::node::params::kubelet_enable_custom_metrics,
  $enable_debugging_handlers             = $kubernetes::node::params::kubelet_enable_debugging_handlers,
  $enable_server                         = $kubernetes::node::params::kubelet_enable_server,
  $event_burst                           = $kubernetes::node::params::kubelet_event_burst,
  $event_qps                             = $kubernetes::node::params::kubelet_event_qps,
  $eviction_hard                         = $kubernetes::node::params::kubelet_eviction_hard,
  $eviction_max_pod_grace_period         = $kubernetes::node::params::kubelet_eviction_max_pod_grace_period,
  $eviction_minimum_reclaim              = $kubernetes::node::params::kubelet_eviction_minimum_reclaim,
  $eviction_pressure_transition_period   = $kubernetes::node::params::kubelet_eviction_pressure_transition_period,
  $eviction_soft                         = $kubernetes::node::params::kubelet_eviction_soft,
  $eviction_soft_grace_period            = $kubernetes::node::params::kubelet_eviction_soft_grace_period,
  $exit_on_lock_contention               = $kubernetes::node::params::kubelet_exit_on_lock_contention,
  $file_check_frequency                  = $kubernetes::node::params::kubelet_file_check_frequency,
  $google_json_key                       = $kubernetes::node::params::kubelet_google_json_key,
  $hairpin_mode                          = $kubernetes::node::params::kubelet_hairpin_mode,
  $healthz_bind_address                  = $kubernetes::node::params::kubelet_healthz_bind_address,
  $healthz_port                          = $kubernetes::node::params::kubelet_healthz_port,
  $host_ipc_sources                      = $kubernetes::node::params::kubelet_host_ipc_sources,
  $host_network_sources                  = $kubernetes::node::params::kubelet_host_network_sources,
  $host_pid_sources                      = $kubernetes::node::params::kubelet_host_pid_sources,
  $hostname_override                     = $kubernetes::node::params::kubelet_hostname_override,
  $http_check_frequency                  = $kubernetes::node::params::kubelet_http_check_frequency,
  $image_gc_high_threshold               = $kubernetes::node::params::kubelet_image_gc_high_threshold,
  $image_gc_low_threshold                = $kubernetes::node::params::kubelet_image_gc_low_threshold,
  $image_service_endpoint                = $kubernetes::node::params::kubelet_image_service_endpoint,
  $iptables_drop_bit                     = $kubernetes::node::params::kubelet_iptables_drop_bit,
  $iptables_masquerade_bit               = $kubernetes::node::params::kubelet_iptables_masquerade_bit,
  $kube_api_burst                        = $kubernetes::node::params::kubelet_kube_api_burst,
  $kube_api_content_type                 = $kubernetes::node::params::kubelet_kube_api_content_type,
  $kube_api_qps                          = $kubernetes::node::params::kubelet_kube_api_qps,
  $kube_reserved                         = $kubernetes::node::params::kubelet_kube_reserved,
  $kubeconfig                            = $kubernetes::node::params::kubelet_kubeconfig,
  $kubelet_cgroups                       = $kubernetes::node::params::kubelet_kubelet_cgroups,
  $lock_file                             = $kubernetes::node::params::kubelet_lock_file,
  $low_diskspace_threshold_mb            = $kubernetes::node::params::kubelet_low_diskspace_threshold_mb,
  $make_iptables_util_chains             = $kubernetes::node::params::kubelet_make_iptables_util_chains,
  $manifest_url                          = $kubernetes::node::params::kubelet_manifest_url,
  $manifest_url_header                   = $kubernetes::node::params::kubelet_manifest_url_header,
  $master_service_namespace              = $kubernetes::node::params::kubelet_master_service_namespace,
  $max_open_files                        = $kubernetes::node::params::kubelet_max_open_files,
  $max_pods                              = $kubernetes::node::params::kubelet_max_pods,
  $minimum_image_ttl_duration            = $kubernetes::node::params::kubelet_minimum_image_ttl_duration,
  $node_ip                               = $kubernetes::node::params::kubelet_node_ip,
  $node_labels                           = $kubernetes::node::params::kubelet_node_labels,
  $node_status_update_frequency          = $kubernetes::node::params::kubelet_node_status_update_frequency,
  $non_masquerade_cidr                   = $kubernetes::node::params::kubelet_non_masquerade_cidr,
  $oom_score_adj                         = $kubernetes::node::params::kubelet_oom_score_adj,
  $outofdisk_transition_frequency        = $kubernetes::node::params::kubelet_outofdisk_transition_frequency,
  $pod_cidr                              = $kubernetes::node::params::kubelet_pod_cidr,
  $pod_infra_container_image             = $kubernetes::node::params::kubelet_pod_infra_container_image,
  $pod_manifest_path                     = $kubernetes::node::params::kubelet_pod_manifest_path,
  $pods_per_core                         = $kubernetes::node::params::kubelet_pods_per_core,
  $port                                  = $kubernetes::node::params::kubelet_port,
  $protect_kernel_defaults               = $kubernetes::node::params::kubelet_protect_kernel_defaults,
  $read_only_port                        = $kubernetes::node::params::kubelet_read_only_port,
  $reconcile_cidr                        = $kubernetes::node::params::kubelet_reconcile_cidr,
  $register_node                         = $kubernetes::node::params::kubelet_register_node,
  $register_schedulable                  = $kubernetes::node::params::kubelet_register_schedulable,
  $registry_burst                        = $kubernetes::node::params::kubelet_registry_burst,
  $registry_qps                          = $kubernetes::node::params::kubelet_registry_qps,
  $require_kubeconfig                    = $kubernetes::node::params::kubelet_require_kubeconfig,
  $resolv_conf                           = $kubernetes::node::params::kubelet_resolv_conf,
  $rkt_api_endpoint                      = $kubernetes::node::params::kubelet_rkt_api_endpoint,
  $rkt_path                              = $kubernetes::node::params::kubelet_rkt_path,
  $root_dir                              = $kubernetes::node::params::kubelet_root_dir,
  $runonce                               = $kubernetes::node::params::kubelet_runonce,
  $runtime_cgroups                       = $kubernetes::node::params::kubelet_runtime_cgroups,
  $runtime_request_timeout               = $kubernetes::node::params::kubelet_runtime_request_timeout,
  $serialize_image_pulls                 = $kubernetes::node::params::kubelet_serialize_image_pulls,
  $streaming_connection_idle_timeout     = $kubernetes::node::params::kubelet_streaming_connection_idle_timeout,
  $sync_frequency                        = $kubernetes::node::params::kubelet_sync_frequency,
  $system_cgroups                        = $kubernetes::node::params::kubelet_system_cgroups,
  $system_reserved                       = $kubernetes::node::params::kubelet_system_reserved,
  $tls_cert_file                         = $kubernetes::node::params::kubelet_tls_cert_file,
  $tls_private_key_file                  = $kubernetes::node::params::kubelet_tls_private_key_file,
  $volume_stats_agg_period               = $kubernetes::node::params::kubelet_volume_stats_agg_period,
  $verbosity                             = $kubernetes::node::params::kubelet_verbosity,
  $extra_args                            = $kubernetes::node::params::kubelet_extra_args,
) inherits kubernetes::node::params {
  validate_re($ensure, '^(running|stopped)$')
  validate_bool($enable)

  include ::kubernetes::node

  if $cert_dir and ($tls_cert_file or $tls_private_key_file) {
    fail('You can\'t use both of cert_dir and tls_*.')
  }

  if $journald_forward_enable and $::operatingsystemmajrelease == '7' {
    file { '/etc/systemd/system/kubelet.service.d':
      ensure => 'directory',
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
    }
    file { '/etc/systemd/system/kubelet.service.d/journald.conf':
      ensure  => file,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template("${module_name}/systemd/kubelet_journald.conf.erb"),
    } ~>
    exec { 'reload systemctl daemon for kubelet':
      command     => '/bin/systemctl daemon-reload',
      refreshonly => true,
    } ~> Service['kubelet']
  }

  case $::osfamily {
    'redhat' : {
    }
    'debian' : {
      file { '/etc/default/kubelet':
        ensure  => 'file',
        force   => true,
        content => template("${module_name}/etc/default/kubelet.erb"),
      } ~> Service['kubelet']
    }
    default  : {
      fail("Unsupport OS: ${::osfamily}")
    }
  }

  file { '/etc/kubernetes/kubelet':
    ensure  => 'file',
    content => template("${module_name}/etc/kubernetes/kubelet.erb"),
  } ~> Service['kubelet']

  if $pod_manifest_path {
    file { $pod_manifest_path:
      ensure  => directory,
      recurse => true,
      purge   => $pod_manifest_path_purge,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
    }
  }

  service { 'kubelet':
    ensure => $ensure,
    enable => $enable,
  }
}
