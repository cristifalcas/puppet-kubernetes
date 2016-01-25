# == Class: kubernetes::node::kube_proxy
#
# Module to install an up-to-date version of kubernetes::node::kube_proxy from package.
#
# === Parameters
#
# [*ensure*]
#   Whether you want to kube_proxy daemon to start up
#   Defaults to running
#
# [*enable*]
#   Whether you want to kube_proxy daemon to start up at boot
#   Defaults to true
#
# [*api_server*]
#   location of the api-server
#   Type: Array or String
#   Defaults to 'http://127.0.0.1:8080'
#
# [*bind_address*]
#   The IP address for the proxy server to serve on (set to 0.0.0.0 for all interfaces)
#   Defaults to '0.0.0.0'
#
# [*cleanup_iptables*]
#   If true cleanup iptables rules and exit.
#   Defaults to false
#
# [*healthz_bind_address*]
#   The IP address for the health check server to serve on, defaulting to 127.0.0.1 (set to 0.0.0.0 for all interfaces)
#   Defaults to '127.0.0.1'
#
# [*healthz_port*]
#   The port to bind the health check server. Use 0 to disable.
#   Defaults to 0
#
# [*hostname_override*]
#   If non-empty, will use this string as identification instead of the actual hostname.
#   Defaults to undef
#
# [*iptables_sync_period*]
#   How often iptables rules are refreshed (e.g. '5s', '1m', '2h22m').  Must be greater than 0.
#   Defaults to 30s
#
# [*kubeconfig*]
#   Path to kubeconfig file with authorization information (the master location is set by the master flag).
#   Defaults to undef
#
# [*log_flush_frequency*]
#   Maximum number of seconds between log flushes
#   Defaults to 5s
#
# [*masquerade_all*]
#   If using the pure iptables proxy, SNAT everything
#   Defaults to false
#
# [*master*]
#   The address of the Kubernetes API server (overrides any value in kubeconfig)
#   Defaults to 'http://127.0.0.1:8080'
#
# [*oom_score_adj*]
#   The oom_score_adj value for kube-proxy process. Values must be within the range [-1000, 1000]
#   Defaults to 0
#
# [*proxy_mode*]
#   Which proxy mode to use: 'userspace' (older, stable) or 'iptables' (experimental).
#    If blank, look at the Node object on the Kubernetes API and respect the 'net.experimental.kubernetes.io/proxy-mode'
#    annotation if provided.  Otherwise use the best-available proxy (currently userspace, but may change in future versions).
#    If the iptables proxy is selected, regardless of how, but the system's kernel or iptables versions are insufficient,
#    this always falls back to the userspace proxy.
#   Defaults to undef
#
# [*proxy_port_range*]
#   Range of host ports (beginPort-endPort, inclusive) that may be consumed in order to proxy service traffic. If unspecified
#   (0-0) then ports will be randomly chosen.
#   Defaults to '0-0'
#
# [*resource_container*]
#   Absolute name of the resource-only container to create and run the Kube-proxy in (Default: /kube-proxy).
#   Defaults to undef
#
# [*udp_timeout*]
#   How long an idle UDP connection will be kept open (e.g. '250ms', '2s').  Must be greater than 0.
#   Only applicable for proxy-mode=userspace
#   Defaults to 250ms
#
# [*minimum_version*]
#   Minimum supported Kubernetes version. Don't enable new features when
#   incompatbile with that version.
#   Default to 1.1.
#
# [*args*]
#   Add your own!
#
class kubernetes::node::kube_proxy (
  $ensure               = $kubernetes::node::params::kube_proxy_service_ensure,
  $enable               = $kubernetes::node::params::kube_proxy_service_enable,
  $bind_address         = $kubernetes::node::params::kube_proxy_bind_address,
  $cleanup_iptables     = $kubernetes::node::params::kube_proxy_cleanup_iptables,
  $healthz_bind_address = $kubernetes::node::params::kube_proxy_healthz_bind_address,
  $healthz_port         = $kubernetes::node::params::kube_proxy_healthz_port,
  $hostname_override    = $kubernetes::node::params::kube_proxy_hostname_override,
  $iptables_sync_period = $kubernetes::node::params::kube_proxy_iptables_sync_period,
  $kubeconfig           = $kubernetes::node::params::kube_proxy_kubeconfig,
  $log_flush_frequency  = $kubernetes::node::params::kube_proxy_log_flush_frequency,
  $masquerade_all       = $kubernetes::node::params::kube_proxy_masquerade_all,
  $master               = $kubernetes::node::params::kube_proxy_master,
  $oom_score_adj        = $kubernetes::node::params::kube_proxy_oom_score_adj,
  $proxy_mode           = $kubernetes::node::params::kube_proxy_proxy_mode,
  $proxy_port_range     = $kubernetes::node::params::kube_proxy_proxy_port_range,
  $resource_container   = $kubernetes::node::params::kube_proxy_resource_container,
  $udp_timeout          = $kubernetes::node::params::kube_proxy_udp_timeout,
  $minimum_version      = $kubernetes::node::params::kube_proxy_minimum_version,
  $args                 = $kubernetes::node::params::kube_proxy_args,
) inherits kubernetes::node::params {
  include ::kubernetes
  include ::kubernetes::node

  validate_bool($cleanup_iptables, $masquerade_all)
  validate_integer([$healthz_port, $oom_score_adj,])

  File['/etc/kubernetes/config'] ~> Service['kube-proxy']
  file { '/etc/kubernetes/proxy':
    ensure  => 'file',
    content => template("${module_name}/etc/kubernetes/proxy.erb"),
  } ~>
  service { 'kube-proxy':
    ensure => $ensure,
    enable => $enable,
  }
}
