# == Class: kubernetes::addons::dns
#
# [*dns_replicas*]
#   The number of replicas, that should be run.
#   default: 1
#
# [*dns_domain*]
#   The domain to use a base for all hostnames.
#   default: cluster.local
#
# [*dns_server*]
#   The IP address that should be assigned to the DNS server.
#   default: 10.0.0.10
#
class kubernetes::addons::dns (
  $dns_replicas = $kubernetes::master::params::dns_replicas,
  $dns_domain   = $kubernetes::master::params::dns_domain,
  $dns_server   = $kubernetes::master::params::dns_server
) {
  include ::kubernetes::addons::base

  file{ '/etc/kubernetes/addons/dns':
    ensure  => directory,
    require => File['/etc/kubernetes/addons'],
  }

  file{ '/etc/kubernetes/addons/dns/skydns-rc.yaml':
    content => template("${module_name}/etc/kubernetes/addons/dns/skydns-rc.yaml.erb"),
    require => File['/etc/kubernetes/addons/dns'],
  }

  file{ '/etc/kubernetes/addons/dns/skydns-svc.yaml':
    content => template("${module_name}/etc/kubernetes/addons/dns/skydns-svc.yaml.erb"),
    require => File['/etc/kubernetes/addons/dns'],
  }
}
