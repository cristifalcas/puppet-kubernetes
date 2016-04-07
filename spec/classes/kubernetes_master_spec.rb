require 'spec_helper'

describe 'kubernetes::master' do
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
  end
end
