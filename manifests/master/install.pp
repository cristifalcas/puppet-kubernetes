# == Class: kubernetes::master::install
#
class kubernetes::master::install {
  package { 'kubernetes-master': ensure => $kubernetes::master::ensure, }
}
