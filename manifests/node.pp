# == Class: kubernetes::node
#
# Module to install an up-to-date version of kubernetes::node from package.
#
# === Parameters
#
# [*ensure*]
#   Passed to the kubernetes::node package.
#   Defaults to present
#
# [*service_state*]
#   Whether you want to kubernetes::node daemon to start up
#   Defaults to running
#
# [*service_enable*]
#   Whether you want to kubernetes::node daemon to start up at boot
#   Defaults to true
#
# [*api_server*]
#   location of the api-server
#   Type: Array or String
#
# kubelet parameters:
#
# [*kubelet_address*]
#   The address for the info server to serve on (set to 0.0.0.0 or "" for all interfaces)
#
# [*kubelet_port*]
#   The port for the info server to serve on
#
# [*kubelet_hostname*]
#   You may leave this blank to use the actual hostname
#
# [*kubelet_configure_cbr0*]
#   If true, kubelet will configure cbr0 based on Node.Spec.PodCIDR.
#
# [*kubelet_pod_cidr*]
#   Node.Spec.PodCIDR with which we will register the node
#
# [*kubelet_register_node*]
#   Register the node with the apiserver (defaults to true if --api-server is set)
#
# [*kubelet_allow_privileged*]
#   If true, allow containers to request privileged mode.
#   Default=false
#
# [*kubelet_cadvisor_port*]
#   The port of the localhost cAdvisor endpoint
#   Default=undef
#
# [*kubelet_file_check_frequency*]
#   Duration between checking config files for new data
#   Default=undef
#
# [*kubelet_healthz_bind_address*]
#   The IP address for the healthz server to serve on, defaulting to 127.0.0.1 (set to 0.0.0.0 for all interfaces)
#   Default=undef
#
# [*kubelet_healthz_port*]
#   The port of the localhost healthz endpoint
#   Default=undef
#
# [*kubelet_image_gc_high_threshold*]
#   The percent of disk usage after which image garbage collection is always run.
#   Default=90%
#
# [*kubelet_image_gc_low_threshold*]
#   The percent of disk usage before which image garbage collection is never run. Lowest disk usage to garbage collect to.
#   Default=80%
#
# [*kubelet_max_pods*]
#   Number of Pods that can run on this Kubelet.
#   Default=40
#
# [*kubelet_maximum_dead_containers*]
#   Maximum number of old instances of a containers to retain globally.  Each container takes up some disk space.
#   Default=100
#
# [*kubelet_maximum_dead_containers_per_container*]
#   Maximum number of old instances of a container to retain per container.
#   Each container takes up some disk space.
#   Default=2
#
# [*kubelet_minimum_container_ttl_duration*]
#   Minimum age for a finished container before it is garbage collected.  Examples: '300ms', '10s' or '2h45m'
#   Default=1m
#
# [*kubelet_low_diskspace_threshold_mb*]
#   The absolute free disk space, in MB, to maintain. When disk space falls below this threshold, new pods would be rejected.
#   Default=256
#
# [*kubelet_cert_dir*]
#   The directory where the TLS certs are located (by default /var/run/kubernetes).
#   If --tls_cert_file and --tls_private_key_file are provided, this flag will be ignored.
#   Default=/var/run/kubernetes
#
# [*kubelet_tls_cert_file*]
#   File containing x509 Certificate for HTTPS.  (CA cert, if any, concatenated after server cert).
#   If --tls_cert_file and --tls_private_key_file are not provided, a self-signed certificate and key
#   are generated for the public address and saved to the directory passed to --cert_dir.
#   Default=undef
#
# [*kubelet_tls_private_key_file*]
#   File containing x509 private key matching --tls_cert_file.
#   Default=undef
#
# [*kubelet_cluster_dns*]
#   IP address for a cluster DNS server.  If set, kubelet will configure all containers to use this for
#   DNS resolution in addition to the host's DNS servers
#   Default=undef
#
# [*kubelet_cluster_domain*]
#   Domain for this cluster.  If set, kubelet will configure all containers to search this domain in addition to the host's search domains
#   Default=undef
#
# [*kubelet_hostname_override*]
#   If non-empty, will use this string as identification instead of the actual hostname.
#   Default=undef
#
# [*kubelet_http_check_frequency*]
#   Duration between checking http for new data
#   Default=undef
#
# [*kubelet_manifest_url*]
#   URL for accessing the container manifest
#   Default=undef
#
# [*kubelet_master_service_namespace*]
#   The namespace from which the Kubernetes master services should be injected into pods
#   Default=undef
#
# [*kubelet_pod_infra_container_image*]
#   The image whose network/ipc namespaces containers in each pod will use.
#   Default=undef
#
# [*kubelet_read_only_port*]
#   The read-only port for the Kubelet to serve on (set to 0 to disable)
#   Default=undef
#
# [*kubelet_root_dir*]
#   Directory path for managing kubelet files (volume mounts,etc).
#   Default=undef
#
# [*kubelet_streaming_connection_idle_timeout*]
#   Maximum time a streaming connection can be idle before the connection is automatically closed.  Example: '5m'
#   Default=undef
#
# [*kubelet_sync_frequency*]
#   Max period between synchronizing running containers and config
#   Default=undef
#
# [*kubelet_args*]
#   Add your own!
#
# kube-proxy parameters:
#
# [*kube_proxy_bind_address*]
#   The IP address for the proxy server to serve on (set to 0.0.0.0 for all interfaces)
#
# [*kube_proxy_healthz_bind_address*]
#   The IP address for the health check server to serve on, defaulting to 127.0.0.1 (set to 0.0.0.0 for all interfaces)
#
# [*kube_proxy_healthz_port*]
#   The port to bind the health check server. Use 0 to disable.
#
# [*kube_proxy_kubeconfig*]
#   Path to kubeconfig file with authorization information (the master location is set by the master flag).
#
# [*kube_proxy_oom_score_adj*]
#   The oom_score_adj value for kube-proxy process. Values must be within the range [-1000, 1000]
#
# [*kube_proxy_proxy_port_range*]
#   Range of host ports (beginPort-endPort, inclusive) that may be consumed in order to proxy service traffic. If unspecified
#   (0-0) then ports will be randomly chosen.
#
# [*kube_proxy_resource_container*]
#   Absolute name of the resource-only container to create and run the Kube-proxy in (Default: /kube-proxy).
#
# [*kube_proxy_args*]
#   Add your own!
#
class kubernetes::node (
  $ensure                          = $kubernetes::node::params::ensure,
  $service_state                   = $kubernetes::node::params::service_state,
  $service_enable                  = $kubernetes::node::params::service_enable,
  $api_server                      = $kubernetes::node::params::api_server,
  # kubelet
  $kubelet_address                               = $kubernetes::node::params::kubelet_address,
  $kubelet_port                                  = $kubernetes::node::params::kubelet_port,
  $kubelet_hostname                              = $kubernetes::node::params::kubelet_hostname,
  $kubelet_configure_cbr0                        = $kubernetes::node::params::kubelet_configure_cbr0,
  $kubelet_pod_cidr                              = $kubernetes::node::params::kubelet_pod_cidr,
  $kubelet_register_node                         = $kubernetes::node::params::kubelet_register_node,
  $kubelet_allow_privileged                      = $kubernetes::node::params::kubelet_allow_privileged,
  $kubelet_cadvisor_port                         = $kubernetes::node::params::kubelet_cadvisor_port,
  $kubelet_file_check_frequency                  = $kubernetes::node::params::kubelet_file_check_frequency,
  $kubelet_healthz_bind_address                  = $kubernetes::node::params::kubelet_healthz_bind_address,
  $kubelet_healthz_port                          = $kubernetes::node::params::kubelet_healthz_port,
  $kubelet_image_gc_high_threshold               = $kubernetes::node::params::kubelet_image_gc_high_threshold,
  $kubelet_image_gc_low_threshold                = $kubernetes::node::params::kubelet_image_gc_low_threshold,
  $kubelet_max_pods                              = $kubernetes::node::params::kubelet_max_pods,
  $kubelet_maximum_dead_containers               = $kubernetes::node::params::kubelet_maximum_dead_containers,
  $kubelet_maximum_dead_containers_per_container = $kubernetes::node::params::kubelet_maximum_dead_containers_per_container,
  $kubelet_minimum_container_ttl_duration        = $kubernetes::node::params::kubelet_minimum_container_ttl_duration,
  $kubelet_low_diskspace_threshold_mb            = $kubernetes::node::params::kubelet_low_diskspace_threshold_mb,
  $kubelet_cert_dir                              = $kubernetes::node::params::kubelet_cert_dir,
  $kubelet_tls_cert_file                         = $kubernetes::node::params::kubelet_tls_cert_file,
  $kubelet_tls_private_key_file                  = $kubernetes::node::params::kubelet_tls_private_key_file,
  $kubelet_cluster_dns                           = $kubernetes::node::params::kubelet_cluster_dns,
  $kubelet_cluster_domain                        = $kubernetes::node::params::kubelet_cluster_domain,
  $kubelet_hostname_override                     = $kubernetes::node::params::kubelet_hostname_override,
  $kubelet_http_check_frequency                  = $kubernetes::node::params::kubelet_http_check_frequency,
  $kubelet_manifest_url                          = $kubernetes::node::params::kubelet_manifest_url,
  $kubelet_master_service_namespace              = $kubernetes::node::params::kubelet_master_service_namespace,
  $kubelet_pod_infra_container_image             = $kubernetes::node::params::kubelet_pod_infra_container_image,
  $kubelet_read_only_port                        = $kubernetes::node::params::kubelet_read_only_port,
  $kubelet_root_dir                              = $kubernetes::node::params::kubelet_root_dir,
  $kubelet_streaming_connection_idle_timeout     = $kubernetes::node::params::kubelet_streaming_connection_idle_timeout,
  $kubelet_sync_frequency                        = $kubernetes::node::params::kubelet_sync_frequency,
  $kubelet_args                                  = $kubernetes::node::params::kubelet_args,
  # proxy
  $kube_proxy_bind_address                       = $kubernetes::node::params::kube_proxy_bind_address,
  $kube_proxy_healthz_bind_address               = $kubernetes::node::params::kube_proxy_healthz_bind_address,
  $kube_proxy_healthz_port                       = $kubernetes::node::params::kube_proxy_healthz_port,
  $kube_proxy_kubeconfig                         = $kubernetes::node::params::kube_proxy_kubeconfig,
  $kube_proxy_oom_score_adj                      = $kubernetes::node::params::kube_proxy_oom_score_adj,
  $kube_proxy_proxy_port_range                   = $kubernetes::node::params::kube_proxy_proxy_port_range,
  $kube_proxy_resource_container                 = $kubernetes::node::params::kube_proxy_resource_container,
  $kube_proxy_args                               = $kubernetes::node::params::kube_proxy_args,
) inherits kubernetes::node::params {
  include kubernetes

  class { 'kubernetes::node::install': } ->
  Class['kubernetes'] ->
  class { 'kubernetes::node::config': } ->
  # we notify servicea about restarts from config files
  class { 'kubernetes::node::service': }

  contain 'kubernetes::node::install'
  contain 'kubernetes::node::config'
  contain 'kubernetes::node::service'
}
