require 'spec_helper'
describe 'os_hardening::minimize_access' do

  context 'with defaults' do
    let(:facts) {{ :retrieve_system_users => 'root', }}
    it { is_expected.to contain_class('os_hardening::minimize_access') }

    ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', ].each { |f|
      it { is_expected.to contain_file(f).with(
        :ensure  => 'directory',
        :mode    => 'go-w',
        :recurse => true,
      )}
    }

    it { is_expected.to contain_file('/etc/shadow').with(
      :ensure => 'file',
      :owner  => 'root',
      :group  => 'root',
      :mode   => '0600',
    )}
  end

  context 'allow_change_user => true' do
    let(:facts) {{ :retrieve_system_users => 'root', }}
    let(:params) {{ :allow_change_user => true, }}
    it { is_expected.to contain_file('/bin/su').with(
      :ensure => 'file',
      :owner  => 'root',
      :group  => 'root',
      :mode   => '0750',
    )}
  end
end
