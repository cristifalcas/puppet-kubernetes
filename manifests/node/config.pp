# == Class: kubernetes::node::config
#
class kubernetes::node::config {
  #  /var/lib/kubelet/kubeconfig
  #  /var/lib/kubelet/kubernetes_auth
  file { '/etc/kubernetes/kubelet':
    ensure  => present,
    content => template("${module_name}/etc/kubernetes/kubelet.erb"),
  }

  file { '/etc/kubernetes/proxy':
    ensure  => present,
    content => template("${module_name}/etc/kubernetes/proxy.erb"),
  }

  file { '/etc/kubernetes/manifests/': ensure => directory, }

  if $kubernetes::node::kubelet_register_node and $kubernetes::node::kubelet_configure_cbr0 {
    file { '/etc/kubernetes/node_initial.yaml':
      ensure  => present,
      content => template("${module_name}/node.yaml.erb"),
    } ->
    exec { 'register node':
      command => "/bin/kubectl create --server=${kubernetes::node::kubelet_api_server} -f /etc/kubernetes/node_initial.yaml",
      unless  => "/bin/kubectl describe nodes --server=${kubernetes::node::kubelet_api_server} ${::fqdn}",
    }
    # if we configure cbr0, most probably docker will have to wait for this first to be configured,
    exec { 'force kubelet to create cbr0':
      command => "/bin/kubelet --runonce=true --api_servers=${kubernetes::node::kubelet_api_server} --configure-cbr0=true --enable-server=false",
      creates => '/sys/class/net/cbr0/',
      returns => 1,
    } ~> Service['docker']
  }
}
