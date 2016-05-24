require 'spec_helper'
describe 'os_hardening::profile' do

  context 'with defaults' do
    it { is_expected.to contain_class('os_hardening::profile') }
    it { is_expected.to have_class_count(1) }
    it { is_expected.to have_resource_count(1) }

    it { is_expected.to contain_file('/etc/profile.d/pinerolo_profile.sh').with(
      :ensure => 'file',
      :source => 'puppet:///modules/os_hardening/profile.conf',
      :owner  => 'root',
      :group  => 'root',
      :mode   => '0400',
    )}
  end

  context 'allow_core_dumps => true' do
    let(:params) {{ :allow_core_dumps => true, }}
    it { is_expected.to have_resource_count(0) }
  end
end
