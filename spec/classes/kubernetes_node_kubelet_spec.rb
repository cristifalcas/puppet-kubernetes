require 'spec_helper'

describe 'kubernetes::node::kubelet', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts.merge({:puppetversion => Puppet.version})
      end

      it 'test default install' do
        is_expected.to compile.with_all_deps
        is_expected.to contain_class('kubernetes::node')
        is_expected.to contain_class('kubernetes::node::kubelet')
        is_expected.to contain_class('kubernetes::node::params')

        is_expected.to contain_file('/etc/kubernetes/kubelet').with({ 'ensure'  => 'file', })
        is_expected.to contain_file('/etc/kubernetes/kubelet').with_content(/### file managed by puppet/)
        is_expected.to contain_service('kubelet')
      end
    end
  end
end
