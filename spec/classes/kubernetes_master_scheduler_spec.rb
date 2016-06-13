require 'spec_helper'

describe 'kubernetes::master::scheduler', :type => :class  do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts.merge({:puppetversion => Puppet.version})
      end

      it 'test default install' do
        is_expected.to compile.with_all_deps
        is_expected.to contain_class('kubernetes::master')
        is_expected.to contain_class('kubernetes::master::scheduler')
        is_expected.to contain_class('kubernetes::master::params')

        is_expected.to contain_file('/etc/kubernetes/scheduler').with({  'ensure'  => 'file',  })
        is_expected.to contain_file('/etc/kubernetes/scheduler').with_content(/### file managed by puppet/)
        is_expected.to contain_service('kube-scheduler')
      end
    end
  end
end
