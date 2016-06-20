require 'spec_helper'

describe 'kubernetes::addons::dashboard', :type => :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let :facts do
          facts.merge({:puppetversion => Puppet.version})
      end
      it 'test default install' do
        is_expected.to compile.with_all_deps

        is_expected.to contain_class('kubernetes::addons::base')

        is_expected.to contain_file('/etc/kubernetes/addons/dashboard').with({  'ensure'  => 'directory',  })
      end
    end
  end
end
