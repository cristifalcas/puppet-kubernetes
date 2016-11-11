# kubernetes #
[![Build Status](https://travis-ci.org/cristifalcas/puppet-kubernetes.png?branch=master)](https://travis-ci.org/cristifalcas/puppet-kubernetes)

This module installs and configures a kubernetes clutser.

The main class kubernetes doesn't do anything and is kept for historical reasons.

The class kubernetes::client installs kubernetes-client package and empties all variables from /etc/kubernetes/config file.
This is done because all variables should be managed by the specific class (apiserver, proxy, etc)

The class kubernetes::node only manages the kubernetes-node package.

The class kubernetes::master only manages the kubernetes-master package.

The software can be installed/started from packages, containers or pod specs.
You can install all services from pods/containers except kubelet.

If you install services as pods, you will also need to install kubelet and docker there also.

If you install services as containers, you will also need to install docker there also.

## Versioning:

Due to rapid change of the arguments for various kubernetes components,
on master we will only keep the latest stable version with the respective arguments.

For older versions there will be a branch where updates will be commited.

For each new major kubernetes version (1.1, 1.2, etc.) the puppet modules version will
have the major number increased. This is mostly because on each version they have
new parameters, or some parameters are removed.

* Kubernetes 1.0, 1.1, 1.2: module version should be latest 1.x
* Kubernetes 1.3: module version should be latest 2.x
* Kubernetes 1.4: module version should be latest 3.x

## Usage:

Currently, the kubectl and kubelet binaries can only be installed from packages.

Install the kube client (this will force the latest version):

	  include kubernetes::client

or with a specific version:

      class {'kubernetes::client': ensure => '1.3.5-1.el7'}

Install the node or master from packages with the latest version:

	  class { 'kubernetes::master::apiserver':
	    allow_privileged => true,
	  }

	  class { 'kubernetes::master::scheduler':
	    master => 'http://127.0.0.1:8080',
	  }

	  class { 'kubernetes::node::kube_proxy':
	    master => 'http://127.0.0.1:8080',
	  }

Install the node or master from packages with the a specific version:

      class {'kubernetes::master': ensure => '1.3.5-1.el7'}
	  class { 'kubernetes::master::apiserver':
	    allow_privileged => true,
	  }
	  class { 'kubernetes::master::scheduler':
	    master => 'http://127.0.0.1:8080',
	  }

      class {'kubernetes::node': ensure => '1.3.5-1.el7'}
	  class { 'kubernetes::node::kube_proxy':
	    master => 'http://127.0.0.1:8080',
	  }

## By default, the cluster is installed from packages:

	  include kubernetes::client
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

If you want to use your existing networking infrastructure, then you will have to allocate
to each node a subnet from the same ip class. You can self register a node with this information
by setting the parameter register_node => true and the desired subnet in pod_cidr parameter:

		class { 'kubernetes::node::kubelet':
		  ensure         => 'latest',
		  address        => '0.0.0.0',
		  api_servers    => 'http://k-api.company.net:8080',
		  configure_cbr0 => true,
		  register_node  => true,
		  pod_cidr       => '10.100.5.0/24',
		}

### Start the proxy from a container instead of package:

	  class { '::kubernetes::node::kube_proxy':
	    manage_as         => 'container',
	    bind_address      => '0.0.0.0',
	    kubeconfig        => '/etc/kubernetes/kubeconfig.yaml',
	    hostname_override => $::hostname,
	    proxy_mode        => 'iptables',
	  }

### Start the apiserver from a pod instead of package:

This needs to have the kubelet running on the machine.

	  class { '::kubernetes::master::apiserver':
	    allow_privileged              => true,
	    manage_as                     => 'pod',
	    admission_control             => ['NamespaceLifecycle', 'LimitRanger', 'ServiceAccount', 'ResourceQuota',],
	    service_account_lookup        => true,
	  }

## Journald forward:

The class support a parameter called journald_forward_enable.

This was added because of the PIPE signal that is sent to go programs when systemd-journald dies.

For more information read here: https://github.com/projectatomic/forward-journald

### Usage:

	  include ::forward_journald
	  Class['forward_journald'] -> Class['kubernetes::master']

## How are we using this module

In our company we can have any number of kubernetes clusters. Because of this,
we don't use special machines for "master" nodes (mostly because we don't have
enough resources to start 3 extra machines for each cluster).

To achive HA, we start a kubelet service and an apiserver pod and a proxy pod on each node.
We also have a dns ReplicationController and a "server" ReplicationController with a 
controller_manager and scheduler (each with a replica of 2).

Using this setup we can lose any machine and still have the cluster unaffected.

### More details

We have only one etcd cluster for each location. Each kubernetes cluster has a specific path where
it writes the data in etcd (set by etcd_prefix from kubernetes::master::apiserver class). We do the
same with flannel:

		class { '::kubernetes::master::apiserver':
		  etcd_prefix => "/company/kubernetes/${::organization}",
		}
		class { '::flannel':
		  etcd_prefix => "/company/network/${::organization}",
		}

We use a "bootstrap" role that installs the classes from this module like this:

  class { '::kubernetes::node::kubelet':
    allow_privileged => true,
    config           => '/etc/kubernetes/manifests',
    config_purge     => true,
  }

  # apiserver as pod
  class { '::kubernetes::master::apiserver':
    allow_privileged       => true,
    manage_as              => 'pod',
    service_account_lookup => true,
    etcd_prefix            => "/company/kubernetes/${::organization}",
  }

  # kube_proxy as pod
  class { '::kubernetes::node::kube_proxy':
    manage_as         => 'pod',
    bind_address      => '0.0.0.0',
    kubeconfig        => '/etc/kubernetes/kubeconfig.yaml',
    hostname_override => $::hostname,
    proxy_mode        => 'iptables',
  }

  # controller_manager as pod
  class { '::kubernetes::master::controller_manager':
    manage_as                        => 'pod',
    container_image                  => "external/hyperkube-amd64:${::conf_kubernetes::hyperkube_version}",
    root_ca_file                     => $::conf_kubernetes::ca_file,
    service_account_private_key_file => $::conf_kubernetes::service_key_file,
  }

  # scheduler as pod
  class { '::kubernetes::master::scheduler':
    manage_as       => 'pod',
    container_image => "external/hyperkube-amd64:${::conf_kubernetes::hyperkube_version}",
  }

At this point we have a working kubernetes cluster. Using a couple of execs we create a rc for dns and
a special rc with 2 containers: controller_manager and scheduler.

After this we can change the role to the more generic one, where we don't have the '::kubernetes::master::controller_manager' and
'::kubernetes::master::scheduler' classes present. This will force puppet to delete the specific pod files and leave the controller_manager
and scheduler running only inside kubernetes as a ReplicationController with 2 replicas.

Each new node in the cluster is installed using the generic role.
