class kubernetes::addons::updater {

  case $::osfamily {
    'RedHat' : {
      $pyyaml_package = 'PyYAML'
    }
    'Debian' : {
      $pyyaml_package = 'python-yaml'
    }
    default  : {
      fail('Unsupported OS.')
    }
  }
  package{ $pyyaml_package:
    ensure => installed,
  }

  file{ '/etc/kubernetes/addons':
    ensure => directory,
  }

  file{ '/usr/local/bin/kubectl':
    ensure => 'link',
    target => '/bin/kubectl',
  }

  file{ '/etc/kubernetes/kube-addon-update.sh':
    content => template("${module_name}/etc/kubernetes/kube-addon-update.sh"),
    mode    => '0755',
    require => Package[$pyyaml_package],
  }

  file{ '/etc/kubernetes/kube-addons.sh':
    content => template("${module_name}/etc/kubernetes/kube-addons.sh"),
    mode    => '0755',
  }

  file{ '/usr/lib/systemd/system/kube-addons.service':
    content => template("${module_name}/systemd/kube-addons.service.erb"),
  }

  service { 'kube-addons':
    ensure  => running,
    enable  => true,
    require => File['/usr/lib/systemd/system/kube-addons.service'],
  }
}
