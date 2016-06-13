require 'spec_helper'

describe 'kubernetes::client', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
          facts.merge({:puppetversion => Puppet.version})
      end
      it 'test default install' do
        is_expected.to compile.with_all_deps

        is_expected.to contain_class('kubernetes::client')
        is_expected.to contain_package('kubernetes-client').with_ensure('present')

        is_expected.to contain_file('/etc/kubernetes/').with({  'ensure'  => 'directory',  })
        is_expected.to contain_file('/etc/kubernetes/config').with({  'ensure'  => 'file',  })
        is_expected.to contain_file('/etc/kubernetes/config').with_content(/### file managed by puppet/)
      end
    end
  end
end
