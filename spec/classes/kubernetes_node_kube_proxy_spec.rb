require 'spec_helper'

describe 'kubernetes::node::kube_proxy', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts.merge({:puppetversion => Puppet.version})
      end

      it 'test default install' do
        is_expected.to compile.with_all_deps
        is_expected.to contain_class('kubernetes::node')
        is_expected.to contain_class('kubernetes::node::kube_proxy')
        is_expected.to contain_class('kubernetes::node::params')

        is_expected.to contain_file('/etc/kubernetes/proxy').with({ 'ensure'  => 'file',  })
        is_expected.to contain_file('/etc/kubernetes/proxy').with_content(/### file managed by puppet/)
        is_expected.to contain_service('kube-proxy')
      end
    end
  end
end
