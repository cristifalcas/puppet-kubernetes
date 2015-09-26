# kubernetes #

This module installs and configures a kubernetes clutser.

The main class kubernetes it only populates the /etc/kubernetes/config file.

Because of this, it needs to be forced to execute after the master or node has installed
any programs (the file is created by both master or node). This is accomplished by forcing
this in the node and master class.

The class kubernetes::client doesn't do anything now.


Usage:

    include etcd
    include docker
    include kubernetes::master
    include kubernetes::node

Or:

	include kubernetes::client
	class { 'kubernetes': kube_master => 'http://k-api.company.net:8080', }

	class { 'kubernetes::master':
	  ensure            => 'latest',
	  kube_etcd_servers => 'http://k-api.company.net:2379',
	  kube_api_address  => '0.0.0.0',
	}

If you want to use you existing netwrok infrastructure, then wou will have to allocate
to nodes a subnet from the same ip class. You can self register a node with this information
by giving  kubelet_register_node = > true and the desired subnet in kubelet_pod_cidr:

	class { 'kubernetes::node':
	  ensure                  => 'latest',
	  kubelet_address         => '0.0.0.0',
	  kubelet_api_server      => 'http://k-api.company.net:8080',
	  kubelet_configure_cbr0  => true,
	  kubelet_register_node   => true,
	  kubelet_pod_cidr        => '10.100.5.0/24',
	  kube_proxy_bind_address => '0.0.0.0',
	  kube_proxy_master       => 'http://k-api.company.net:8080',
	}
