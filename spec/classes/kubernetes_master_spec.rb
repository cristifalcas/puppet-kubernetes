require 'spec_helper'

describe 'kubernetes::master', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
        facts.merge({:puppetversion => Puppet.version})
      end

      it 'test default install' do
        is_expected.to compile.with_all_deps
        is_expected.to contain_class('kubernetes::client')
        is_expected.to contain_class('kubernetes::master')

        is_expected.to contain_package('kubernetes-master').with_ensure('present')
        is_expected.to contain_file('/etc/kubernetes/').with({ 'ensure'  => 'directory',  })
      end
    end
  end
end
