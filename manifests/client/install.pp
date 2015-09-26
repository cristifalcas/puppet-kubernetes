# == Class: kubernetes::client::install
#
# Module to install an up-to-date version of Docker from a package repository.
# This module currently works only on Debian, Red Hat
# and Archlinux based distributions.
#
class kubernetes::client::install {
  package { 'kubernetes-client': ensure => $kubernetes::client::ensure, }
}
