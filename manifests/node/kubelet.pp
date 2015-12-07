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
# [*hostname_override*]
#   If non-empty, will use this string as identification instead of the actual hostname.
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
# [*args*]
#   Add your own!

class kubernetes::node::kubelet (
  $ensure                                = $kubernetes::node::params::kubelet_service_ensure,
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
  $hostname_override                     = $kubernetes::node::params::kubelet_hostname_override,
  $http_check_frequency                  = $kubernetes::node::params::kubelet_http_check_frequency,
  $manifest_url                          = $kubernetes::node::params::kubelet_manifest_url,
  $master_service_namespace              = $kubernetes::node::params::kubelet_master_service_namespace,
  $pod_infra_container_image             = $kubernetes::node::params::kubelet_pod_infra_container_image,
  $read_only_port                        = $kubernetes::node::params::kubelet_read_only_port,
  $root_dir                              = $kubernetes::node::params::kubelet_root_dir,
  $streaming_connection_idle_timeout     = $kubernetes::node::params::kubelet_streaming_connection_idle_timeout,
  $sync_frequency                        = $kubernetes::node::params::kubelet_sync_frequency,
  $args                                  = $kubernetes::node::params::kubelet_args,
) inherits kubernetes::node::params {
  include kubernetes
  include kubernetes::node
  
  if $kubelet_cert_dir and ($kubelet_tls_cert_file or $kubelet_tls_private_key_file) {
    fail("You can't use both of kubelet_cert_dir and kubelet_tls_*.")
  }

  #  /var/lib/kubelet/kubeconfig
  #  /var/lib/kubelet/kubernetes_auth
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

  File['/etc/kubernetes/config'] ~> Service['kubelet']
  file { '/etc/kubernetes/kubelet':
    ensure  => 'file',
    content => template("${module_name}/etc/kubernetes/kubelet.erb"),
  } ~>
  service { 'kubelet':
    ensure => $ensure,
    enable => $enable,
  }
}
