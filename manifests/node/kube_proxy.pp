# == Class: kubernetes::node::kube_proxy
# http://kubernetes.io/docs/admin/kube-proxy/
#
# Module to install an up-to-date version of kubernetes::node::kube_proxy from package.
#
# === Parameters
#
# [*ensure*]
#   Whether you want to kube_proxy daemon to start up
#   Defaults to running
#
# [*journald_forward_enable*]
#   Fix for SIGPIPE sent to registry daemon during journald restart
#   Defaults to false
#
# [*enable*]
#   Whether you want to kube_proxy daemon to start up at boot
#   Defaults to true
#
# [*manage_as*]
#   How to manage the proxy service. Valid values are: service, pod, container
#   Defaults to service
#
# [*container_image*]
#   From where to pull the image.
#   Defaults to gcr.io/google_containers/hyperkube-amd64:v1.3.5
#
# [*pod_cpu*]
#   CPU limits for this pod.
#   Defaults to 100mi
#
# [*pod_memory*]
#   Memory limits for this pod.
#   Defaults to 400Mi
#
## Parameters ##
#
# [*bind_address*]
#   The IP address for the proxy server to serve on (set to 0.0.0.0 for all interfaces)
#   Defaults to '0.0.0.0'
#
# [*cleanup_iptables*]
#   If true cleanup iptables rules and exit.
#   Defaults to false
#
# [*cluster_cidr*]
#   The CIDR range of pods in the cluster. It is used to bridge traffic coming from outside of the cluster.
#   If not provided, no off-cluster bridging will be performed.
#   Defaults to undef.
#
# [*config_sync_period*]
#   How often configuration from the apiserver is refreshed.
#    If undefined, defaults to 15m0s
#   Defaults to undef
#
# [*conntrack_max*]
#   Maximum number of NAT connections to track (0 to leave as-is)
#    If undefined, defaults to 262144
#   Defaults to undef
#
# [*conntrack_max_per_core*]
#   Maximum number of NAT connections to track per CPU core (0 to leave as-is). This is only considered if conntrack-max is 0.
#   Defaults to undef. (default 32768)
#
# [*conntrack_tcp_timeout_established*]
#   Idle timeout for established TCP connections (0 to leave as-is)
#    If undefined, defaults to 24h0m0s
#   Defaults to undef
#
# [*google_json_key*]
#   The Google Cloud Platform Service Account JSON Key to use for authentication.
#   Defaults to undef
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
# [*iptables_masquerade_bit*]
#   If using the pure iptables proxy, the bit of the fwmark space to mark packets requiring SNAT with.  Must be within the range [0, 31].
#    If undefined, defaults to 14
#   Defaults to undef
#
# [*iptables_sync_period*]
#   How often iptables rules are refreshed (e.g. '5s', '1m', '2h22m').  Must be greater than 0.
#    If undefined, defaults to 30s
#   Defaults to undef
#
# [*kube_api_burst*]
#   Burst to use while talking with kubernetes apiserver
#   Defaults to undef
#
# [*kube_api_content_type*]
#   Content type of requests sent to apiserver.
#   Defaults to undef. (default "application/vnd.kubernetes.protobuf")
#
# [*kube_api_qps*]
#   QPS to use while talking with kubernetes apiserver
#   Defaults to undef
#
# [*kubeconfig*]
#   Path to kubeconfig file with authorization information (the master location is set by the master flag).
#   Defaults to undef
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
#   Defaults to undef
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
#   Defaults to undef
#
# [*udp_timeout*]
#   How long an idle UDP connection will be kept open (e.g. '250ms', '2s').  Must be greater than 0.
#   Only applicable for proxy-mode=userspace
#   Defaults to undef
#
# [*verbosity*]
#   Set logger verbosity
#   Defaults to 2
#
# [*extra_args*]
#   Add your own
#   Defaults to undef
#
class kubernetes::node::kube_proxy (
  $ensure                            = $kubernetes::node::params::kube_proxy_service_ensure,
  $journald_forward_enable           = $kubernetes::node::params::kube_proxy_journald_forward_enable,
  $enable                            = $kubernetes::node::params::kube_proxy_service_enable,
  $manage_as                         = $kubernetes::node::params::kube_proxy_manage_as,
  $container_image                   = $kubernetes::node::params::kube_proxy_container_image,
  $pod_cpu                           = $kubernetes::node::params::kube_proxy_pod_cpu,
  $pod_memory                        = $kubernetes::node::params::kube_proxy_pod_memory,
  $bind_address                      = $kubernetes::node::params::kube_proxy_bind_address,
  $cleanup_iptables                  = $kubernetes::node::params::kube_proxy_cleanup_iptables,
  $config_sync_period                = $kubernetes::node::params::kube_proxy_config_sync_period,
  $conntrack_max                     = $kubernetes::node::params::kube_proxy_conntrack_max,
  $conntrack_max_per_core            = $kubernetes::node::params::kube_proxy_conntrack_max_per_core,
  $conntrack_tcp_timeout_established = $kubernetes::node::params::kube_proxy_conntrack_tcp_timeout_established,
  $google_json_key                   = $kubernetes::node::params::kube_proxy_google_json_key,
  $healthz_bind_address              = $kubernetes::node::params::kube_proxy_healthz_bind_address,
  $healthz_port                      = $kubernetes::node::params::kube_proxy_healthz_port,
  $hostname_override                 = $kubernetes::node::params::kube_proxy_hostname_override,
  $iptables_masquerade_bit           = $kubernetes::node::params::kube_proxy_iptables_masquerade_bit,
  $iptables_sync_period              = $kubernetes::node::params::kube_proxy_iptables_sync_period,
  $kube_api_burst                    = $kubernetes::node::params::kube_proxy_kube_api_burst,
  $kube_api_content_type             = $kubernetes::node::params::kube_proxy_kube_api_content_type,
  $kube_api_qps                      = $kubernetes::node::params::kube_proxy_kube_api_qps,
  $kubeconfig                        = $kubernetes::node::params::kube_proxy_kubeconfig,
  $masquerade_all                    = $kubernetes::node::params::kube_proxy_masquerade_all,
  $master                            = $kubernetes::node::params::kube_proxy_master,
  $oom_score_adj                     = $kubernetes::node::params::kube_proxy_oom_score_adj,
  $proxy_mode                        = $kubernetes::node::params::kube_proxy_proxy_mode,
  $proxy_port_range                  = $kubernetes::node::params::kube_proxy_proxy_port_range,
  $udp_timeout                       = $kubernetes::node::params::kube_proxy_udp_timeout,
  $verbosity                         = $kubernetes::node::params::kube_proxy_verbosity,
  $extra_args                        = $kubernetes::node::params::kube_proxy_extra_args,
) inherits kubernetes::node::params {
  validate_re($ensure, '^(running|stopped)$')
  validate_bool($enable)
  validate_re($manage_as, '^(service|pod|container)$')

  case $manage_as {
    'service'   : {
      include ::kubernetes::node

      case $::osfamily {
        'redhat' : {
        }
        'debian' : {
          file { '/etc/default/kube-proxy':
            ensure  => 'file',
            force   => true,
            content => template("${module_name}/etc/default/proxy.erb"),
            notify  => Service['kube-proxy'],
          }
        }
        default  : {
          fail("Unsupport OS: ${::osfamily}")
        }
      }

      file { '/etc/kubernetes/proxy':
        ensure  => 'file',
        content => template("${module_name}/etc/kubernetes/proxy.erb"),
        notify  => Service['kube-proxy'],
      }

      service { 'kube-proxy':
        ensure => $ensure,
        enable => $enable,
      }

      if $journald_forward_enable and $::operatingsystemmajrelease == '7' {
        file { '/etc/systemd/system/kube-proxy.service.d':
          ensure => 'directory',
          owner  => 'root',
          group  => 'root',
          mode   => '0755',
        } ->
        file { '/etc/systemd/system/kube-proxy.service.d/journald.conf':
          ensure  => file,
          owner   => 'root',
          group   => 'root',
          mode    => '0644',
          content => template("${module_name}/systemd/kubeproxy_journald.conf.erb"),
        } ~>
        exec { 'reload systemctl daemon for kube-proxy':
          command     => '/bin/systemctl daemon-reload',
          refreshonly => true,
        } ~> Service['kube-proxy']
      }
    }
    'pod'       : {
      if $enable {
        $ensure_file = 'file'
      } else {
        $ensure_file = 'absent'
      }

      file { '/etc/kubernetes/manifests/pod_kube-proxy.yml':
        ensure  => $ensure_file,
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => template("${module_name}/pods/pod_kube-proxy.yml.erb"),
      }
    }
    'container' : {
      if $enable {
        $ensure_container = 'present'
      } else {
        $ensure_container = 'absent'
      }
      $args = inline_template("<%= scope.function_template(['kubernetes/_proxy.erb']) %>")

      docker::run { 'kube-proxy':
        ensure           => $ensure_container,
        image            => $container_image,
        command          => '/hyperkube proxy ${args}',
        volumes          => ['/etc/pki:/etc/pki', '/etc/ssl:/etc/ssl', '/etc/kubernetes:/etc/kubernetes',],
        restart_service  => true,
        net              => 'host',
        privileged       => true,
        detach           => false,
        extra_parameters => ['--restart=always'],
      }
    }
    default     : {
    }
  }
}
