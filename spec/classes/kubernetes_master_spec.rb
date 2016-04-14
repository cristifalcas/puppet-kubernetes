require 'spec_helper'

describe 'kubernetes::master', :type => :class do
  context 'with defaults for all parameters on RedHat' do
    let :facts do
      {
        :kernel   => 'Linux',
        :osfamily => 'RedHat',
      }
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
