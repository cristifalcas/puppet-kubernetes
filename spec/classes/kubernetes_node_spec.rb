require 'spec_helper'

describe 'kubernetes::node' do
  context 'with defaults for all parameters on RedHat' do
    let :facts do
      {
        :kernel   => 'Linux',
        :osfamily => 'RedHat',
      }
    end
    it { is_expected.to compile.with_all_deps }
    it { should contain_class('kubernetes::node') }
    it { should contain_package('kubernetes-node').with_ensure('present') }
  end
end
