require 'spec_helper'
describe 'os_hardening::limits' do

  context 'with defaults' do
    it { is_expected.to contain_class('os_hardening::limits') }
  end
end
