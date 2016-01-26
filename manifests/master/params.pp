# == Class: kubernetes::master::params
#
class kubernetes::master::params {
  # api server config
  # http://kubernetes.io/v1.1/docs/admin/kube-apiserver.html
  $kube_api_service_ensure = running
  $kube_api_service_enable = true
  $kube_api_admission_control = [
    'NamespaceLifecycle',
    'NamespaceExists',
    'LimitRanger',
    'SecurityContextDeny',
    'ServiceAccount',
    'ResourceQuota',
    ]
  $kube_api_advertise_address = undef
  $kube_api_allow_privileged = false
  $kube_api_authorization_mode = 'AlwaysAllow'
  $kube_api_bind_address = '0.0.0.0'
  $kube_api_cert_dir = '/var/run/kubernetes'
  $kube_api_client_ca_file = undef
  $kube_api_cluster_name = 'kubernetes'
  $kube_api_etcd_prefix = '/registry'
  $kube_api_etcd_servers = ['http://127.0.0.1:2379']
  $kube_api_etcd_certfile = undef
  $kube_api_etcd_keyfile = undef
  $kube_api_etcd_cacertfiles = []
  $kube_api_event_ttl = '1h0m0s'
  $kube_api_google_json_key = undef
  $kube_api_insecure_bind_address = '127.0.0.1'
  $kube_api_insecure_port = 8080
  $kube_api_kubelet_certificate_authority = undef
  $kube_api_kubelet_client_certificate = undef
  $kube_api_kubelet_client_key = undef
  $kube_api_kubelet_https = true
  $kube_api_kubelet_port = 10250
  $kube_api_kubelet_timeout = '5s'
  $kube_api_log_flush_frequency = '5s'
  $kube_api_long_running_request_regexp = undef
  $kube_api_master_service_namespace = 'default'
  $kube_api_max_connection_bytes_per_sec = 0
  $kube_api_max_requests_inflight = 400
  $kube_api_min_request_timeout = 1800
  $kube_api_runtime_config = undef
  $kube_api_secure_port = 6443
  $kube_api_service_account_key_file = undef
  $kube_api_service_account_lookup = false
  $kube_api_service_node_port_range = undef
  $kube_api_ssh_keyfile = undef
  $kube_api_ssh_user = undef
  $kube_api_tls_cert_file = undef
  $kube_api_tls_private_key_file = undef
  $kube_api_token_auth_file = undef
  $kube_api_watch_cache = true
  $kube_api_extra_args = ''
  $kube_api_minimum_version = 1.1

  # controller manager config
  # http://kubernetes.io/v1.1/docs/admin/kube-controller-manager.html
  $kube_controller_service_ensure = running
  $kube_controller_service_enable = true
  $kube_controller_address = '127.0.0.1'
  $kube_controller_allocate_node_cidrs = false
  $kube_controller_cloud_config = undef
  $kube_controller_cluster_cidr = undef
  $kube_controller_cluster_name = 'kubernetes'
  $kube_controller_concurrent_endpoint_syncs = 5
  $kube_controller_concurrent_rc_syncs = 5
  $kube_controller_deleting_pods_burst = 10
  $kube_controller_deleting_pods_qps = 0.1
  $kube_controller_deployment_controller_sync_period = '30s'
  $kube_controller_google_json_key = undef
  $kube_controller_horizontal_pod_autoscaler_sync_period = '30s'
  $kube_controller_kubeconfig = undef
  $kube_controller_log_flush_frequency = '5s'
  $kube_controller_master = 'http://127.0.0.1:8080'
  $kube_controller_min_resync_period = undef
  $kube_controller_namespace_sync_period = '5m0s'
  $kube_controller_node_monitor_grace_period = '40s'
  $kube_controller_node_monitor_period = '5s'
  $kube_controller_node_startup_grace_period = '1m0s'
  $kube_controller_node_sync_period = '10s'
  $kube_controller_pod_eviction_timeout = '5m0s'
  $kube_controller_port = 10252
  $kube_controller_root_ca_file = undef
  $kube_controller_service_account_private_key_file = undef
  $kube_controller_service_sync_period = '5m0s'
  $kube_controller_terminated_pod_gc_threshold = 0
  $kube_controller_args = ''
  $kube_controller_minimum_version = 1.1

  # scheduler config
  # http://kubernetes.io/v1.1/docs/admin/kube-scheduler.html
  $kube_scheduler_service_ensure = running
  $kube_scheduler_service_enable = true
  $kube_scheduler_address = '127.0.0.1'
  $kube_scheduler_bind_pods_burst = 100
  $kube_scheduler_bind_pods_qps = 50
  $kube_scheduler_google_json_key = undef
  $kube_scheduler_kubeconfig = undef
  $kube_scheduler_log_flush_frequency = '5s'
  $kube_scheduler_master = 'http://127.0.0.1:8080'
  $kube_scheduler_port = 10251
  $kube_scheduler_args = ''
  $kube_scheduler_minimum_version = 1.1
}
