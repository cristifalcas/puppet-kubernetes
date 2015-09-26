# == Class: kubernetes::node::params
#
# Default parameter values for the kubernetes::node module
#
class kubernetes::node::params {
  $ensure = 'present'
  $service_state = running
  $service_enable = true

  # kubelet options
  $kubelet_address = '127.0.0.1'
  $kubelet_port = 10250
  $kubelet_hostname = $::fqdn
  $kubelet_api_server = 'http://127.0.0.1:8080'
  $kubelet_configure_cbr0 = undef
  $kubelet_pod_cidr = undef
  $kubelet_register_node = undef
  $kubelet_args = ''

  # proxy options
  $kube_proxy_bind_address = undef
  $kube_proxy_healthz_bind_address = undef
  $kube_proxy_healthz_port = 0
  $kube_proxy_kubeconfig = undef
  $kube_proxy_master = undef
  $kube_proxy_oom_score_adj = 0
  $kube_proxy_proxy_port_range = '0-0'
  $kube_proxy_resource_container = undef
  $kube_proxy_args = ''
}
