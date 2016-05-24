require 'spec_helper'
describe 'os_hardening::pam' do

  context 'with defaults' do
    it { is_expected.to contain_class('os_hardening::pam') }
    it { is_expected.to have_class_count(1) }
    it { is_expected.to have_resource_count(1) }

    it { is_expected.to contain_package('pam-ccreds').with(
      :ensure => 'absent',
      :name   => 'pam_ccreds',
    )}
  end
end
