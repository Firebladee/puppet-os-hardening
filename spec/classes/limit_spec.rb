require 'spec_helper'
describe 'os_hardening::limits' do

  context 'with defaults' do
    it { is_expected.to contain_class('os_hardening::limits') }
    it { is_expected.to have_class_count(1) }
    it { is_expected.to have_resource_count(1) }

    it { is_expected.to contain_file('/etc/security/limits.d/10.hardcore.conf').with(
      :ensure => 'file',
      :source => 'puppet:///modules/os_hardening/limits.conf',
      :owner  => 'root',
      :group  => 'root',
      :mode   => '0400',
    )}
  end
end
