require 'spec_helper'
describe 'os_hardening::securetty' do

  describe 'with defaults' do
    it { is_expected.to contain_class('os_hardening::securetty') }
    it { is_expected.to have_class_count(1) }
    it { is_expected.to have_resource_count(1) }

    it { is_expected.to contain_file('/etc/securetty').with(
      :ensure => 'file',
      :owner  => 'root',
      :group  => 'root',
      :mode   => '0400',
    )}
    it 'should not be empty /etc/securetty' do
      content = catalogue.resource('file', '/etc/securetty').send(:parameters)[:content]
      expect(content).to_not be_empty
    end
  end
end
