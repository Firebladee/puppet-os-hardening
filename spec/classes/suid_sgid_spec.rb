require 'spec_helper'
describe 'os_hardening::suid_sgid' do

  context 'with defaults' do
    it { is_expected.to contain_class('os_hardening::suid_sgid') }
    it { is_expected.to have_class_count(1) }
    it { is_expected.to have_resource_count(42) }

    [
      '/sbin/netreport',
      '/usr/bin/arping',
      '/usr/bin/dotlockfile',
      '/usr/bin/lockfile',
      '/usr/bin/mail-lock',
      '/usr/bin/mail-touchlock',
      '/usr/bin/mail-unlock',
      '/usr/bin/mtr',
      '/usr/bin/rcp',
      '/usr/bin/rlogin',
      '/usr/bin/rsh',
      '/usr/lib/eject/dmcrypt-get-device',
      '/usr/lib/evolution/camel-lock-helper-1.2',
      '/usr/lib/mc/cons.saver',
      '/usr/lib/openssh/ssh-keysign',
      '/usr/lib/pt_chown',
      '/usr/libexec/openssh/ssh-keysign',
      '/usr/sbin/pppd',
      '/usr/sbin/userisdnctl',
      '/usr/sbin/usernetctl',
      '/usr/sbin/uuidd',
    ].each { |f|
      it { is_expected.to contain_os_hardening__blacklist_files(f) }
    }
  end

  context 'remove_from_unknown => true' do
    let(:params) {{ :remove_from_unknown => true, }}
    it { is_expected.to have_resource_count(44) }

    it { is_expected.to contain_file('/usr/local/sbin/remove_suids').with(
      :ensure => 'file',
      :owner  => 'root',
      :group  => 'root',
      :mode   => '0500',
    )}
    it 'should not be empty /usr/local/sbin/remove_suids' do
      content = catalogue.resource('file', '/usr/local/sbin/remove_suids').send(:parameters)[:content]
      expect(content).not_to be_empty
    end

    it { is_expected.to contain_exec('remove SUID/SGID bits from unknown').with(
      :command => '/usr/local/sbin/remove_suids',
    )}
  end
end
