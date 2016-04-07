require 'spec_helper'

describe 'kubernetes::master::apiserver' do
  context 'with defaults for all parameters on RedHat' do
    let :facts do
      {
        :kernel   => 'Linux',
        :osfamily => 'RedHat',
      }
    end

    let :params do
      {
        :service_cluster_ip_range      => '1.1.1.1',
      }
    end

    it { is_expected.to compile.with_all_deps }
    it { should contain_class('kubernetes::master::apiserver') }
    it { should contain_package('kubernetes-master').with_ensure('present') }
    it { should contain_service('kube-apiserver') }
  end
end
