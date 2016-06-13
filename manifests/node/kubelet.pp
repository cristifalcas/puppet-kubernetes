# == Class: kubernetes::node::kubelet
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
# [*api_servers*]
#   List of Kubernetes API servers for publishing events, and reading pods and services. (ip:port), comma separated.
#   Type: Array or String
#   Defaults to 'http://127.0.0.1:8080'
#
# [*address*]
#   The address for the info server to serve on (set to 0.0.0.0 or "" for all interfaces)
#   Defaults to '127.0.0.1'
#
# [*port*]
#   The port for the info server to serve on
#   Defaults to 10250
#
# [*hostname*]
#   You may leave this blank to use the actual hostname
#   Defaults to $::fqdn
#
# [*configure_cbr0*]
#   If true, kubelet will configure cbr0 based on Node.Spec.PodCIDR.
#   Defaults to undef
#
# [*pod_cidr*]
#   Node.Spec.PodCIDR with which we will register the node
#   Defaults to undef
#
# [*register_node*]
#   Register the node with the apiserver (defaults to true if --api-server is set)
#   Defaults to true
#
# [*allow_privileged*]
#   If true, allow containers to request privileged mode.
#   Defaults to false
#
# [*cadvisor_port*]
#   The port of the localhost cAdvisor endpoint
#   Defaults to undef
#
# [*file_check_frequency*]
#   Duration between checking config files for new data
#   Default=undef
#
# [*healthz_bind_address*]
#   The IP address for the healthz server to serve on, defaulting to 127.0.0.1 (set to 0.0.0.0 for all interfaces)
#   Default=undef
#
# [*healthz_port*]
#   The port of the localhost healthz endpoint
#   Default=undef
#
# [*image_gc_high_threshold*]
#   The percent of disk usage after which image garbage collection is always run.
#   Default=90%
#
# [*image_gc_low_threshold*]
#   The percent of disk usage before which image garbage collection is never run. Lowest disk usage to garbage collect to.
#   Default=80%
#
# [*max_pods*]
#   Number of Pods that can run on this Kubelet.
#   Default=40
#
# [*maximum_dead_containers*]
#   Maximum number of old instances of a containers to retain globally.  Each container takes up some disk space.
#   Default=100
#
# [*maximum_dead_containers_per_container*]
#   Maximum number of old instances of a container to retain per container.
#   Each container takes up some disk space.
#   Default=2
#
# [*minimum_container_ttl_duration*]
#   Minimum age for a finished container before it is garbage collected.  Examples: '300ms', '10s' or '2h45m'
#   Default=1m
#
# [*low_diskspace_threshold_mb*]
#   The absolute free disk space, in MB, to maintain. When disk space falls below this threshold, new pods would be rejected.
#   Default=256
#
# [*cert_dir*]
#   The directory where the TLS certs are located (by default /var/run/kubernetes).
#   If --tls_cert_file and --tls_private_key_file are provided, this flag will be ignored.
#   Default=/var/run/kubernetes
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
# [*cluster_dns*]
#   IP address for a cluster DNS server.  If set, kubelet will configure all containers to use this for
#   DNS resolution in addition to the host's DNS servers
#   Default=undef
#
# [*cluster_domain*]
#   Domain for this cluster.  If set, kubelet will configure all containers to search this domain in addition to the host's search domains
#   Default=undef
#
# [*http_check_frequency*]
#   Duration between checking http for new data
#   Default=undef
#
# [*manifest_url*]
#   URL for accessing the container manifest
#   Default=undef
#
# [*master_service_namespace*]
#   The namespace from which the Kubernetes master services should be injected into pods
#   Default=undef
#
# [*pod_infra_container_image*]
#   The image whose network/ipc namespaces containers in each pod will use.
#   Default=undef
#
# [*read_only_port*]
#   The read-only port for the Kubelet to serve on (set to 0 to disable)
#   Default=undef
#
# [*root_dir*]
#   Directory path for managing kubelet files (volume mounts,etc).
#   Default=undef
#
# [*streaming_connection_idle_timeout*]
#   Maximum time a streaming connection can be idle before the connection is automatically closed.  Example: '5m'
#   Default=undef
#
# [*sync_frequency*]
#   Max period between synchronizing running containers and config
#   Default=undef
#
# [*application_metrics_count_limit*]
#   Max number of application metrics to store (per container)
#   Default 100
#
# [*docker_env_metadata_whitelist*]
#   A comma-separated list of environment variable keys that needs to be collected for docker containers
#   Default undef
#
# [*enable_custom_metrics[*]
#   Support for gathering custom metrics.
#   Default undef
#
# [*experimental_flannel_overlay[*]
#   Experimental support for starting the kubelet with the default overlay network (flannel). Assumes flanneld is already running in client mode.
#   Default undef
#
# [*hairpin_mode*]
#   How should the kubelet setup hairpin NAT. This allows endpoints of a Service to loadbalance back to themselves if they should
#   try to access their own Service. Valid values are "promiscuous-bridge", "hairpin-veth" and "none".
#   Default undef
#
# [*housekeeping_interval*]
#   Interval between container housekeepings
#   Default '10s'
#
# [*kube_api_burst*]
#   Burst to use while talking with kubernetes apiserver
#   Default undef
#
# [*kube_api_qps*]
#   QPS to use while talking with kubernetes apiserver
#   Default undef
#
# [*kube_reserved*]
#   A set of ResourceName=ResourceQuantity (e.g. cpu=200m,memory=150G) pairs that describe resources reserved for
#   kubernetes system components. Currently only cpu and memory are supported.
#   Default undef
#
# [*kubelet_cgroups*]
#   Optional absolute name of cgroups to create and run the Kubelet in.
#   Default undef
#
# [*lock_file*]
#   Warning: Alpha feature. The path to file for kubelet to use as a lock file.
#   Default undef
#
# [*minimum_image_ttl_duration*]
#   Minimum age for a unused image before it is garbage collected.  Examples: '300ms', '10s' or '2h45m'.
#   Default undef
#
# [*node_ip*]
#   IP address of the node. If set, kubelet will use this IP address for the node
#   Default undef
#
# [*node_labels*]
#   Warning: Alpha feature. Labels to add when registering the node in the cluster.  Labels must be key=value pairs separated by ','.
#   Default undef
#
# [*reconcile_cidr*]
#   Reconcile node CIDR with the CIDR specified by the API server. No-op if register-node or configure-cbr0 is false.
#   Default undef
#
# [*register_schedulable[*]
#   Register the node as schedulable. No-op if register-node is false.
#   Default undef
#
# [*runtime_cgroups*]
#   Optional absolute name of cgroups to create and run the runtime in.
#   Default undef
#
# [*system_cgroups*]
#   Optional absolute name of cgroups in which to place all non-kernel processes that are not already inside a
#   cgroup under `/`. Empty for no container. Rolling back the flag requires a reboot.
#   Default undef
#
# [*system_reserved*]
#   A set of ResourceName=ResourceQuantity (e.g. cpu=200m,memory=150G) pairs that describe resources reserved for non-kubernetes
#   components. Currently only cpu and memory are supported.
#   Default undef
#
# [*non_masquerade_cidr*]
#   Traffic to IPs outside this range will use IP masquerade.
#   Default undef
#
# [*minimum_version*]
#   Minimum supported Kubernetes version. Don't enable new features when
#   incompatbile with that version.
#   Default to 1.1.
#
# [*args*]
#   Add your own!
#
class kubernetes::node::kubelet (
  $ensure                                = $kubernetes::node::params::kubelet_service_ensure,
  $journald_forward_enable               = $kubernetes::node::params::kubelet_journald_forward_enable,
  $enable                                = $kubernetes::node::params::kubelet_service_enable,
  $api_servers                           = $kubernetes::node::params::kubelet_api_servers,
  $address                               = $kubernetes::node::params::kubelet_address,
  $port                                  = $kubernetes::node::params::kubelet_port,
  $hostname                              = $kubernetes::node::params::kubelet_hostname,
  $configure_cbr0                        = $kubernetes::node::params::kubelet_configure_cbr0,
  $pod_cidr                              = $kubernetes::node::params::kubelet_pod_cidr,
  $register_node                         = $kubernetes::node::params::kubelet_register_node,
  $allow_privileged                      = $kubernetes::node::params::kubelet_allow_privileged,
  $cadvisor_port                         = $kubernetes::node::params::kubelet_cadvisor_port,
  $file_check_frequency                  = $kubernetes::node::params::kubelet_file_check_frequency,
  $healthz_bind_address                  = $kubernetes::node::params::kubelet_healthz_bind_address,
  $healthz_port                          = $kubernetes::node::params::kubelet_healthz_port,
  $image_gc_high_threshold               = $kubernetes::node::params::kubelet_image_gc_high_threshold,
  $image_gc_low_threshold                = $kubernetes::node::params::kubelet_image_gc_low_threshold,
  $max_pods                              = $kubernetes::node::params::kubelet_max_pods,
  $maximum_dead_containers               = $kubernetes::node::params::kubelet_maximum_dead_containers,
  $maximum_dead_containers_per_container = $kubernetes::node::params::kubelet_maximum_dead_containers_per_container,
  $minimum_container_ttl_duration        = $kubernetes::node::params::kubelet_minimum_container_ttl_duration,
  $low_diskspace_threshold_mb            = $kubernetes::node::params::kubelet_low_diskspace_threshold_mb,
  $cert_dir                              = $kubernetes::node::params::kubelet_cert_dir,
  $tls_cert_file                         = $kubernetes::node::params::kubelet_tls_cert_file,
  $tls_private_key_file                  = $kubernetes::node::params::kubelet_tls_private_key_file,
  $cluster_dns                           = $kubernetes::node::params::kubelet_cluster_dns,
  $cluster_domain                        = $kubernetes::node::params::kubelet_cluster_domain,
  $http_check_frequency                  = $kubernetes::node::params::kubelet_http_check_frequency,
  $manifest_url                          = $kubernetes::node::params::kubelet_manifest_url,
  $master_service_namespace              = $kubernetes::node::params::kubelet_master_service_namespace,
  $pod_infra_container_image             = $kubernetes::node::params::kubelet_pod_infra_container_image,
  $read_only_port                        = $kubernetes::node::params::kubelet_read_only_port,
  $root_dir                              = $kubernetes::node::params::kubelet_root_dir,
  $streaming_connection_idle_timeout     = $kubernetes::node::params::kubelet_streaming_connection_idle_timeout,
  $sync_frequency                        = $kubernetes::node::params::kubelet_sync_frequency,
  $application_metrics_count_limit       = $kubernetes::node::params::kubelet_application_metrics_count_limit,
  $docker_env_metadata_whitelist         = $kubernetes::node::params::kubelet_docker_env_metadata_whitelist,
  $enable_custom_metrics                 = $kubernetes::node::params::kubelet_enable_custom_metrics,
  $experimental_flannel_overlay          = $kubernetes::node::params::kubelet_experimental_flannel_overlay,
  $hairpin_mode                          = $kubernetes::node::params::kubelet_hairpin_mode,
  $housekeeping_interval                 = $kubernetes::node::params::kubelet_housekeeping_interval,
  $kube_api_burst                        = $kubernetes::node::params::kubelet_kube_api_burst,
  $kube_api_qps                          = $kubernetes::node::params::kubelet_kube_api_qps,
  $kube_reserved                         = $kubernetes::node::params::kubelet_kube_reserved,
  $kubelet_cgroups                       = $kubernetes::node::params::kubelet_kubelet_cgroups,
  $lock_file                             = $kubernetes::node::params::kubelet_lock_file,
  $minimum_image_ttl_duration            = $kubernetes::node::params::kubelet_minimum_image_ttl_duration,
  $node_ip                               = $kubernetes::node::params::kubelet_node_ip,
  $node_labels                           = $kubernetes::node::params::kubelet_node_labels,
  $reconcile_cidr                        = $kubernetes::node::params::kubelet_reconcile_cidr,
  $register_schedulable                  = $kubernetes::node::params::kubelet_register_schedulable,
  $runtime_cgroups                       = $kubernetes::node::params::kubelet_runtime_cgroups,
  $system_cgroups                        = $kubernetes::node::params::kubelet_system_cgroups,
  $system_reserved                       = $kubernetes::node::params::kubelet_system_reserved,
  $minimum_version                       = $kubernetes::node::params::kubelet_minimum_version,
  $args                                  = $kubernetes::node::params::kubelet_args,
) inherits kubernetes::node::params {
  validate_re($ensure, '^(running|stopped)$')
  validate_bool($enable)

  include ::kubernetes::node
  
  if $cert_dir and ($tls_cert_file or $tls_private_key_file) {
    fail('You can\'t use both of cert_dir and tls_*.')
  }

  # Autoregister and create docker bridge
  if $register_node and $configure_cbr0 {
    package { ['bridge-utils']: ensure => 'present', } ->
    file { '/etc/kubernetes/node_initial.yaml':
      ensure  => 'file',
      content => template("${module_name}/node.yaml.erb"),
    } ->
    exec { 'register node':
      command => "/bin/kubectl create --server=${api_servers} -f /etc/kubernetes/node_initial.yaml",
      unless  => "/bin/kubectl describe nodes --server=${api_servers} ${::fqdn}",
    } ->
    # if we configure cbr0, most probably docker will have to wait for this first to be configured,
    exec { 'force kubelet to create cbr0':
      command => "/bin/kubelet --runonce=true --api_servers=${api_servers} --configure-cbr0=true --enable-server=false",
      creates => '/sys/class/net/cbr0/',
      returns => 1,
    } ~> Service['docker']
  }

  if $journald_forward_enable {
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

  service { 'kubelet':
    ensure => $ensure,
    enable => $enable,
  }
}
