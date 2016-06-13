require 'spec_helper'

describe 'kubernetes::master::controller_manager', :type => :class  do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts.merge({:puppetversion => Puppet.version})
      end

      it 'test default install' do
        is_expected.to compile.with_all_deps
        is_expected.to contain_class('kubernetes::master')
        is_expected.to contain_class('kubernetes::master::controller_manager')
        is_expected.to contain_class('kubernetes::master::params')

        is_expected.to contain_file('/etc/kubernetes/controller-manager').with({  'ensure'  => 'file',  })
        is_expected.to contain_file('/etc/kubernetes/controller-manager').with_content(/### file managed by puppet/)
        is_expected.to contain_service('kube-controller-manager')
      end
    end
  end
end
