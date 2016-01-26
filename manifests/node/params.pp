# == Class: kubernetes::node::params
#
# Default parameter values for the kubernetes::node module
#
class kubernetes::node::params {
  # kubelet options
  # http://kubernetes.io/v1.1/docs/admin/kubelet.html
  $kubelet_service_ensure = 'running'
  $kubelet_service_enable = true
  $kubelet_address = '0.0.0.0'
  $kubelet_api_servers = ['http://127.0.0.1:8080']
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
  $kubelet_cert_dir = undef
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
  # http://kubernetes.io/v1.1/docs/admin/kube-proxy.html
  $kube_proxy_service_ensure = 'running'
  $kube_proxy_service_enable = true
  $kube_proxy_bind_address = '127.0.0.1'
  $kube_proxy_cleanup_iptables = false
  $kube_proxy_healthz_bind_address = '127.0.0.1'
  $kube_proxy_healthz_port = 0
  $kube_proxy_hostname_override = undef
  $kube_proxy_iptables_sync_period = '30s'
  $kube_proxy_kubeconfig = undef
  $kube_proxy_log_flush_frequency = '5s'
  $kube_proxy_masquerade_all = false
  $kube_proxy_master = 'http://127.0.0.1:8080'
  $kube_proxy_oom_score_adj = -999
  $kube_proxy_proxy_mode = undef
  $kube_proxy_proxy_port_range = '0-0'
  $kube_proxy_resource_container = undef
  $kube_proxy_udp_timeout = '250ms'
  $kube_proxy_minimum_version = 1.1
  $kube_proxy_args = ''
}
