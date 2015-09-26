# == Class: kubernetes::master::params
#
class kubernetes::master::params {
  $ensure = 'present'
  $service_state = running
  $service_enable = true

  # api server config
  $kube_api_address = '127.0.0.1'
  $kube_api_port = 8080
  $kubelet_port = 10250
  $kube_etcd_servers = ['http://127.0.0.1:2379']
  $kube_service_addresses = '10.254.0.0/16'
  $kube_admission_control = '--admission_control=NamespaceLifecycle,NamespaceExists,LimitRanger,SecurityContextDeny,ServiceAccount,ResourceQuota'
  $kube_api_args = ''

  # controller manager config
  $kube_controller_manager_args = ''

  # scheduler config
  $kube_scheduler_args = ''
}
