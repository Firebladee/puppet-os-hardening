require 'spec_helper'
describe 'os_hardening::login_defs' do

  context 'with defaults' do
    it { is_expected.to contain_class('os_hardening::login_defs') }
    it { is_expected.to have_class_count(1) }
    it { is_expected.to have_resource_count(1) }

    it { is_expected.to contain_file('/etc/login.defs').with(
      :ensure  => 'file',
      :owner   => 'root',
      :group   => 'root',
      :mode    => '0400',
    )}
    it 'sould not be empty /etc/login.defs' do
      content = catalogue.resource('file', '/etc/login.defs').send(:parameters)[:content]
      expect(content).not_to be_empty
    end
  end
end
