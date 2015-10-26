# == Class: kubernetes::node::params
#
# Default parameter values for the kubernetes::node module
#
class kubernetes::node::params {
  $ensure = 'present'
  $service_state = running
  $service_enable = true
  $api_server = undef

  # kubelet options
  $kubelet_address = '127.0.0.1'
  $kubelet_port = 10250
  $kubelet_hostname = $::fqdn
  $kubelet_configure_cbr0 = undef
  $kubelet_pod_cidr = undef
  $kubelet_register_node = true
  $kubelet_allow_privileged = false
  $kubelet_cadvisor_port = undef
  $kubelet_file_check_frequency = undef
  $kubelet_healthz_bind_address = undef
  $kubelet_healthz_port = undef
  $kubelet_image_gc_high_threshold = 90
  $kubelet_image_gc_low_threshold = 80
  $kubelet_max_pods = 40
  $kubelet_maximum_dead_containers = 100
  $kubelet_maximum_dead_containers_per_container = 2
  $kubelet_minimum_container_ttl_duration = '1m'
  $kubelet_low_diskspace_threshold_mb = 256
  $kubelet_cert_dir = '/var/run/kubernetes'
  $kubelet_tls_cert_file = undef
  $kubelet_tls_private_key_file = undef
  $kubelet_cluster_dns = undef
  $kubelet_cluster_domain = undef
  $kubelet_hostname_override = undef
  $kubelet_http_check_frequency = undef
  $kubelet_manifest_url = undef
  $kubelet_master_service_namespace = undef
  $kubelet_pod_infra_container_image = undef
  $kubelet_read_only_port = undef
  $kubelet_root_dir = undef
  $kubelet_streaming_connection_idle_timeout = undef
  $kubelet_sync_frequency = undef
  $kubelet_args = ''

  # proxy options
  $kube_proxy_bind_address = '127.0.0.1'
  $kube_proxy_healthz_bind_address = '127.0.0.1'
  $kube_proxy_healthz_port = 0
  $kube_proxy_kubeconfig = undef
  $kube_proxy_oom_score_adj = 0
  $kube_proxy_proxy_port_range = '0-0'
  $kube_proxy_resource_container = undef
  $kube_proxy_args = ''
}
