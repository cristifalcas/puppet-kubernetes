# == Class: kubernetes::master::params
#
class kubernetes::master::params {
  $ensure = 'present'
  $service_state_apiserver = running
  $service_enable_apiserver = true
  $service_state_controller = running
  $service_enable_controller = true
  $service_state_scheduler = running
  $service_enable_scheduler = true

  # api server config
  $kube_api_address = '127.0.0.1'
  $kube_api_port = 8080
  $kube_api_args = ''
  $kubelet_port = 10250
  $kube_etcd_servers = ['http://127.0.0.1:2379']
  $kube_service_addresses = '10.254.0.0/16'
  $kube_admission_control = [
    'NamespaceLifecycle',
    'NamespaceExists',
    'LimitRanger',
    'SecurityContextDeny',
    'ServiceAccount',
    'ResourceQuota',
    ]
  $kube_api_allow_privileged = false
  $kube_api_bind_address = '0.0.0.0'
  $kube_api_secure_port = 6443
  $kube_api_cluster_name = 'kubernetes'
  $kube_api_etcd_prefix = '/registry'
  $kube_api_external_hostname = undef
  $kube_api_advertise_address = undef

  # controller manager config
  $kube_controller_manager_args = ''

  # scheduler config
  $kube_scheduler_args = ''
}
