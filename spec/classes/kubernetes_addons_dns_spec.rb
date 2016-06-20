require 'spec_helper'

describe 'kubernetes::addons::dns', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
          facts.merge({:puppetversion => Puppet.version})
      end
      it 'test default install' do
        is_expected.to compile.with_all_deps

        is_expected.to contain_class('kubernetes::addons::base')

        is_expected.to contain_file('/etc/kubernetes/addons/dns').with({  'ensure'  => 'directory',  })
        is_expected.to contain_file('/etc/kubernetes/addons/dns/skydns-rc.yaml')
        is_expected.to contain_file('/etc/kubernetes/addons/dns/skydns-svc.yaml')
      end
    end
  end
end
