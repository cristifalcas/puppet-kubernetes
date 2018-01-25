# == Class: kubernetes::master::params
#
class kubernetes::master::params {
  # api server config
  $kube_api_manage_as = 'service'
  $kube_api_container_image = 'gcr.io/google_containers/hyperkube-amd64:v1.4.0'
  $kube_api_pod_cpu = '300m'
  $kube_api_pod_memory = '700Mi'
  $kube_api_service_ensure = running
  $kube_api_journald_forward_enable = false
  $kube_api_service_enable = true
  $kube_api_admission_control = [
    'NamespaceLifecycle',
    'NamespaceExists',
    'LimitRanger',
    'SecurityContextDeny',
    'ServiceAccount',
    'ResourceQuota',
  ]
  $kube_api_admission_control_config_file = undef
  $kube_api_advertise_address = undef
  $kube_api_allow_privileged = false
  $kube_api_anonymous_auth = undef
  $kube_api_server_count = 1
  $kube_api_audit_log_maxage = undef
  $kube_api_audit_log_maxbackup = undef
  $kube_api_audit_log_maxsize = undef
  $kube_api_audit_log_path = undef
  $kube_api_authentication_token_webhook_cache_ttl = undef
  $kube_api_authentication_token_webhook_config_file = undef
  $kube_api_authorization_mode = 'AlwaysAllow'
  $kube_api_authorization_policy_file = undef
  $kube_api_authorization_rbac_super_user = undef
  $kube_api_authorization_webhook_cache_authorized_ttl = undef
  $kube_api_authorization_webhook_cache_unauthorized_ttl = undef
  $kube_api_authorization_webhook_config_file = undef
  $kube_api_basic_auth_file = undef
  $kube_api_bind_address = '0.0.0.0'
  $kube_api_cert_dir = '/var/run/kubernetes'
  $kube_api_client_ca_file = undef
  $kube_api_cloud_config = undef
  $kube_api_cloud_provider = undef
  $kube_api_cors_allowed_origins = undef
  $kube_api_delete_collection_workers = undef
  $kube_api_deserialization_cache_size = undef
  $kube_api_enable_garbage_collector = undef
  $kube_api_enable_swagger_ui = undef
  $kube_api_etcd_cafile = undef
  $kube_api_etcd_certfile = undef
  $kube_api_etcd_keyfile = undef
  $kube_api_etcd_prefix = '/registry'
  $kube_api_etcd_quorum_read = undef
  $kube_api_etcd_servers = ['http://127.0.0.1:2379']
  $kube_api_etcd_servers_overrides = []
  $kube_api_event_ttl = '1h0m0s'
  $kube_api_experimental_keystone_ca_file = undef
  $kube_api_experimental_keystone_url = undef
  $kube_api_external_hostname = undef
  $kube_api_google_json_key = undef
  $kube_api_insecure_allow_any_token = undef
  $kube_api_insecure_bind_address = '127.0.0.1'
  $kube_api_insecure_port = 8080
  $kube_api_kubelet_certificate_authority = undef
  $kube_api_kubelet_client_certificate = undef
  $kube_api_kubelet_client_key = undef
  $kube_api_kubelet_https = true
  $kube_api_kubelet_preferred_address_types = undef
  $kube_api_kubelet_timeout = '5s'
  $kube_api_long_running_request_regexp = undef
  $kube_api_master_service_namespace = 'default'
  $kube_api_max_connection_bytes_per_sec = 0
  $kube_api_max_requests_inflight = 400
  $kube_api_min_request_timeout = 1800
  $kube_api_profiling = true
  $kube_api_repair_malformed_updates = undef
  $kube_api_requestheader_allowed_names = undef
  $kube_api_requestheader_client_ca_file = undef
  $kube_api_requestheader_username_headers = undef
  $kube_api_runtime_config = undef
  $kube_api_secure_port = 6443
  $kube_api_service_account_key_file = undef
  $kube_api_service_account_lookup = undef
  $kube_api_service_node_port_range = undef
  $kube_api_ssh_keyfile = undef
  $kube_api_ssh_user = undef
  $kube_api_storage_backend = undef
  $kube_api_storage_media_type = undef
  $kube_api_storage_versions = undef
  $kube_api_target_ram_mb = undef
  $kube_api_tls_ca_file = undef
  $kube_api_tls_cert_file = undef
  $kube_api_tls_private_key_file = undef
  $kube_api_tls_sni_cert_key = undef
  $kube_api_token_auth_file = undef
  $kube_api_watch_cache = undef
  $kube_api_watch_cache_sizes = undef
  $kube_api_kubernetes_service_node_port = 0
  $kube_api_verbosity = 2
  $kube_api_extra_args = ''

  # controller manager config
  $kube_controller_service_ensure = running
  $kube_controller_journald_forward_enable = false
  $kube_controller_manage_as = 'service'
  $kube_controller_container_image = 'gcr.io/google_containers/hyperkube-amd64:v1.4.0'
  $kube_controller_pod_cpu = '100m'
  $kube_controller_pod_memory = '200Mi'
  $kube_controller_service_enable = true
  $kube_controller_address = '127.0.0.1'
  $kube_controller_allocate_node_cidrs = false
  $kube_controller_cloud_config = undef
  $kube_controller_cloud_provider = undef
  $kube_controller_cluster_cidr = undef
  $kube_controller_cluster_name = 'kubernetes'
  $kube_controller_cluster_signing_cert_file = undef
  $kube_controller_cluster_signing_key_file = undef
  $kube_controller_concurrent_deployment_syncs = 5
  $kube_controller_concurrent_endpoint_syncs = 5
  $kube_controller_concurrent_gc_syncs = undef
  $kube_controller_concurrent_namespace_syncs = 2
  $kube_controller_concurrent_replicaset_syncs = 5
  $kube_controller_concurrent_resource_quota_syncs = 5
  $kube_controller_concurrent_rc_syncs = 5
  $kube_controller_concurrent_service_syncs = undef
  $kube_controller_concurrent_serviceaccount_token_syncs = undef
  $kube_controller_controller_start_interval = undef
  #  $kube_controller_daemonset_lookup_cache_size = 1024
  $kube_controller_deployment_controller_sync_period = '30s'
  $kube_controller_enable_dynamic_provisioning = undef
  $kube_controller_enable_garbage_collector = undef
  $kube_controller_flex_volume_plugin_dir = undef
  $kube_controller_google_json_key = undef
  $kube_controller_horizontal_pod_autoscaler_sync_period = '30s'
  $kube_controller_kube_api_burst = 30
  $kube_controller_kube_api_content_type = undef
  $kube_controller_kube_api_qps = 20
  $kube_controller_kubeconfig = undef
  $kube_controller_large_cluster_size_threshold = undef
  $kube_controller_leader_elect = undef
  $kube_controller_leader_elect_lease_duration = '15s'
  $kube_controller_leader_elect_renew_deadline = '10s'
  $kube_controller_leader_elect_retry_period = '2s'
  $kube_controller_master = 'http://127.0.0.1:8080'
  $kube_controller_min_resync_period = undef
  $kube_controller_namespace_sync_period = '5m0s'
  $kube_controller_node_cidr_mask_size = undef
  $kube_controller_node_eviction_rate = undef
  $kube_controller_node_monitor_grace_period = '40s'
  $kube_controller_node_monitor_period = '5s'
  $kube_controller_node_startup_grace_period = '1m0s'
  $kube_controller_pod_eviction_timeout = '5m0s'
  $kube_controller_port = 10252
  $kube_controller_profiling = true
  $kube_controller_pv_recycler_increment_timeout_nfs = undef
  $kube_controller_pv_recycler_minimum_timeout_hostpath = undef
  $kube_controller_pv_recycler_minimum_timeout_nfs = undef
  $kube_controller_pv_recycler_pod_template_filepath_hostpath = undef
  $kube_controller_pv_recycler_pod_template_filepath_nfs = undef
  $kube_controller_pv_recycler_timeout_increment_hostpath = undef
  $kube_controller_pvclaimbinder_sync_period = undef
  #  $kube_controller_replicaset_lookup_cache_size = 4096
  #  $kube_controller_replication_controller_lookup_cache_size = 4096
  $kube_controller_resource_quota_sync_period = '5m0s'
  $kube_controller_route_reconciliation_period = undef
  $kube_controller_root_ca_file = undef
  $kube_controller_secondary_node_eviction_rate = undef
  $kube_controller_service_account_private_key_file = undef
  $kube_controller_service_cluster_ip_range = undef
  $kube_controller_service_sync_period = '5m0s'
  $kube_controller_terminated_pod_gc_threshold = 0
  $kube_controller_unhealthy_zone_threshold = undef
  $kube_controller_use_service_account_credentials = undef
  $kube_controller_verbosity = 2
  $kube_controller_extra_args = ''

  # scheduler config
  $kube_scheduler_service_ensure = running
  $kube_scheduler_journald_forward_enable = false
  $kube_scheduler_service_enable = true
  $kube_scheduler_manage_as = 'service'
  $kube_scheduler_container_image = 'gcr.io/google_containers/hyperkube-amd64:v1.4.0'
  $kube_scheduler_pod_cpu = '100m'
  $kube_scheduler_pod_memory = '200Mi'
  $kube_scheduler_address = '127.0.0.1'
  $kube_scheduler_algorithm_provider = 'DefaultProvider'
  $kube_scheduler_failure_domains = undef
  $kube_scheduler_google_json_key = undef
  $kube_scheduler_hard_pod_affinity_symmetric_weight = undef
  $kube_scheduler_kube_api_burst = 10
  $kube_scheduler_kube_api_content_type = undef
  $kube_scheduler_kube_api_qps = 50
  $kube_scheduler_kubeconfig = undef
  $kube_scheduler_leader_elect = undef
  $kube_scheduler_leader_elect_lease_duration = '15s'
  $kube_scheduler_leader_elect_renew_deadline = '10s'
  $kube_scheduler_leader_elect_retry_period = '2s'
  $kube_scheduler_log_flush_frequency = '5s'
  $kube_scheduler_master = 'http://127.0.0.1:8080'
  $kube_scheduler_policy_config_file = undef
  $kube_scheduler_port = 10251
  $kube_scheduler_profiling = true
  $kube_scheduler_scheduler_name = undef
  $kube_scheduler_verbosity = 2
  $kube_scheduler_extra_args = ''
}
