require 'spec_helper'

describe 'kubernetes::master::scheduler' do
  context 'with defaults for all parameters on RedHat' do
    let :facts do
      {
        :kernel   => 'Linux',
        :osfamily => 'RedHat',
      }
    end
    it { is_expected.to compile.with_all_deps }
    it { should contain_class('kubernetes::master') }
    it { should contain_package('kubernetes-master').with_ensure('present') }
    it { should contain_service('kube-scheduler') }
  end
end
