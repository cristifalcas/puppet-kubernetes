# == Class: kubernetes::master
#
# Module to install an up-to-date version of Docker from package.
#
# === Parameters
#
# [*ensure*]
#   Passed to the docker package.
#   Defaults to present
#
# [*service_state*]
#   Whether you want to kube daemons to start up
#   Defaults to running
#
# [*service_enable*]
#   Whether you want to kube daemons to start up at boot
#   Defaults to true
#
# [*kube_api_address*]
#   The address on the local server to listen to.
#
# [*kube_api_port*]
#   The port on the local server to listen on.
#
# [*kubelet_port*]
#   Port minions listen on
#
# [*kube_etcd_servers*]
#   Comma separated list of nodes in the etcd cluster
#
# [*kube_service_addresses*]
#   Address range to use for services
#
# [*kube_admission_control*]
#   default admission control policies
#
# [*kube_api_args*]
#
# [*kube_controller_manager_args*]
#
# [*kube_scheduler_args*]
#

class kubernetes::master (
  $ensure                       = $kubernetes::master::params::ensure,
  $service_state                = $kubernetes::master::params::service_state,
  $service_enable               = $kubernetes::master::params::service_enable,
  $kube_api_address             = $kubernetes::master::params::kube_api_address,
  $kube_api_port                = $kubernetes::master::params::kube_api_port,
  $kubelet_port                 = $kubernetes::master::params::kubelet_port,
  $kube_etcd_servers            = $kubernetes::master::params::kube_etcd_servers,
  $kube_service_addresses       = $kubernetes::master::params::kube_service_addresses,
  $kube_admission_control       = $kubernetes::master::params::kube_admission_control,
  $kube_api_args                = $kubernetes::master::params::kube_api_args,
  $kube_controller_manager_args = $kubernetes::master::params::kube_controller_manager_args,
  $kube_scheduler_args          = $kubernetes::master::params::kube_scheduler_args,
) inherits kubernetes::master::params {
  include kubernetes

  class { 'kubernetes::master::install': } ->
  Class['kubernetes'] ->
  class { 'kubernetes::master::config': } ~>
  class { 'kubernetes::master::service': }

  contain 'kubernetes::master::install'
  contain 'kubernetes::master::config'
  contain 'kubernetes::master::service'
}
