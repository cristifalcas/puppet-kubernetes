# == Class: kubernetes::node::config
#
class kubernetes::node::config {
  #  /var/lib/kubelet/kubeconfig
  #  /var/lib/kubelet/kubernetes_auth
  file { '/etc/kubernetes/kubelet':
    ensure  => present,
    content => template("${module_name}/etc/kubernetes/kubelet.erb"),
  } ~>
  Service['kubelet']

  file { '/etc/kubernetes/proxy':
    ensure  => present,
    content => template("${module_name}/etc/kubernetes/proxy.erb"),
  } ~>
  Service['kube-proxy']

  file { '/etc/kubernetes/manifests/': ensure => directory, }

  file { '/var/run/kubernetes/':
    ensure => directory,
    owner  => 'kube'
  }

  if $kubernetes::node::kubelet_register_node and $kubernetes::node::kubelet_configure_cbr0 {
    file { '/etc/kubernetes/node_initial.yaml':
      ensure  => present,
      content => template("${module_name}/node.yaml.erb"),
    } ->
    exec { 'register node':
      command => "/bin/kubectl create --server=${kubernetes::node::api_server} -f /etc/kubernetes/node_initial.yaml",
      unless  => "/bin/kubectl describe nodes --server=${kubernetes::node::api_server} ${::fqdn}",
    } ->
    # if we configure cbr0, most probably docker will have to wait for this first to be configured,
    exec { 'force kubelet to create cbr0':
      command => "/bin/kubelet --runonce=true --api_servers=${kubernetes::node::api_server} --configure-cbr0=true --enable-server=false",
      creates => '/sys/class/net/cbr0/',
      returns => 1,
    } ~> Service['docker']
  }
}
