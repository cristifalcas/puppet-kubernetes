require 'spec_helper'

describe 'kubernetes', :type => :class do
  context 'with defaults for all parameters on RedHat' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({:puppetversion => Puppet.version})
        end

        it 'test default install' do
          is_expected.to compile.with_all_deps
          is_expected.to contain_class('kubernetes')
        end
      end
    end
  end
end
