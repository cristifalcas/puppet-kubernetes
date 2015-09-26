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
# [*kubelet_address*]
#   The address for the info server to serve on (set to 0.0.0.0 or "" for all interfaces)
#
# [*kubelet_port*]
#   The port for the info server to serve on
#
# [*kubelet_hostname*]
#   You may leave this blank to use the actual hostname
#
# [*kubelet_api_server*]
#   location of the api-server
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
# [*kube_proxy_master*]
#   The address of the Kubernetes API server (overrides any value in kubeconfig)
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
  $kubelet_address                 = $kubernetes::node::params::kubelet_address,
  $kubelet_port                    = $kubernetes::node::params::kubelet_port,
  $kubelet_hostname                = $kubernetes::node::params::kubelet_hostname,
  $kubelet_api_server              = $kubernetes::node::params::kubelet_api_server,
  $kubelet_configure_cbr0          = $kubernetes::node::params::kubelet_configure_cbr0,
  $kubelet_pod_cidr                = $kubernetes::node::params::kubelet_pod_cidr,
  $kubelet_register_node           = $kubernetes::node::params::kubelet_register_node,
  $kubelet_args                    = $kubernetes::node::params::kubelet_args,
  # proxy
  $kube_proxy_bind_address         = $kubernetes::node::params::kube_proxy_bind_address,
  $kube_proxy_healthz_bind_address = $kubernetes::node::params::kube_proxy_healthz_bind_address,
  $kube_proxy_healthz_port         = $kubernetes::node::params::kube_proxy_healthz_port,
  $kube_proxy_kubeconfig           = $kubernetes::node::params::kube_proxy_kubeconfig,
  $kube_proxy_master               = $kubernetes::node::params::kube_proxy_master,
  $kube_proxy_oom_score_adj        = $kubernetes::node::params::kube_proxy_oom_score_adj,
  $kube_proxy_proxy_port_range     = $kubernetes::node::params::kube_proxy_proxy_port_range,
  $kube_proxy_resource_container   = $kubernetes::node::params::kube_proxy_resource_container,
  $kube_proxy_args                = $kubernetes::node::params::kube_proxy_args,
) inherits kubernetes::node::params {
  include docker
  include kubernetes

  class { 'kubernetes::node::install': } ->
  Class['kubernetes'] ->
  class { 'kubernetes::node::config': } ~>
  class { 'kubernetes::node::service': }

  contain 'kubernetes::node::install'
  contain 'kubernetes::node::config'
  contain 'kubernetes::node::service'
}
