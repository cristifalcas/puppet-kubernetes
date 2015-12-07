# kubernetes #
[![Build Status](https://travis-ci.org/cristifalcas/puppet-kubernetes.png?branch=master)](https://travis-ci.org/cristifalcas/puppet-kubernetes)


This module installs and configures a kubernetes clutser.

The main class kubernetes it only populates the /etc/kubernetes/config file.

Because of this, it needs to be forced to execute after the master or node has installed
any programs (the file is created by both master or node). This is accomplished by forcing
this in the node and master class.

The class kubernetes::client doesn't do anything now.


Usage:

	  include kubernetes
	  include kubernetes::master
	  include kubernetes::node
	  include kubernetes::node::kubelet
	  include kubernetes::node::kube_proxy

	  class { 'kubernetes::master::apiserver':
	    admission_control             => [
	      'NamespaceLifecycle',
	      'NamespaceExists',
	      'LimitRanger',
	      'SecurityContextDeny',
	      'ResourceQuota',
	      ],
	  }

If you want to use you existing network infrastructure, then wou will have to allocate
to nodes a subnet from the same ip class. You can self register a node with this information
by giving  kubelet_register_node = > true and the desired subnet in kubelet_pod_cidr:

		class { 'kubernetes::node::kubelet':
		  ensure                  => 'latest',
		  address                 => '0.0.0.0',
		  api_servers             => 'http://k-api.company.net:8080',
		  configure_cbr0          => true,
		  register_node           => true,
		  pod_cidr                => '10.100.5.0/24',
		}
