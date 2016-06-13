# kubernetes #
[![Build Status](https://travis-ci.org/cristifalcas/puppet-kubernetes.png?branch=master)](https://travis-ci.org/cristifalcas/puppet-kubernetes)


This module installs and configures a kubernetes clutser.

The main class kubernetes doesn't do anything and is kept for historical reasons.

The class kubernetes::client only populates the /etc/kubernetes/config file: it empties all variables.

The class kubernetes::node only manages the kubernetes-node package.

The class kubernetes::master only manages the kubernetes-master packages.

Because of this, it needs to be forced to execute after the master or node has installed
any programs (the file is created by both master or node). This is accomplished by forcing
this in the node and master class.

The class kubernetes::client doesn't do anything now.

## Journald forward:

The class support a parameter called journald_forward_enable.

This was added because of the PIPE signal that is sent to go programs when systemd-journald dies.

For more information read here: https://github.com/projectatomic/forward-journald

### Usage:

	  include ::forward_journald
	  Class['forward_journald'] -> Class['kubernetes::master']


## Usage:

	  include kubernetes::client
	  include kubernetes::master
	  include kubernetes::node
	  include kubernetes::node::kubelet
	  include kubernetes::node::kube_proxy

	  class { 'kubernetes::master::apiserver':
	    admission_control => [
	      'NamespaceLifecycle',
	      'NamespaceExists',
	      'LimitRanger',
	      'SecurityContextDeny',
	      'ResourceQuota',
	      ],
	  }

If you want to use you existing network infrastructure, then you will have to allocate
to nodes a subnet from the same ip class. You can self register a node with this information
by giving  kubelet_register_node = > true and the desired subnet in kubelet_pod_cidr:

		class { 'kubernetes::node::kubelet':
		  ensure         => 'latest',
		  address        => '0.0.0.0',
		  api_servers    => 'http://k-api.company.net:8080',
		  configure_cbr0 => true,
		  register_node  => true,
		  pod_cidr       => '10.100.5.0/24',
		}
