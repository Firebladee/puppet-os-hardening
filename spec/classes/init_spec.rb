require 'spec_helper'
describe 'os_hardening' do

  context 'with defaults' do
    let(:facts) {{ :retrieve_system_users => 'root' }}

    [
      'os_hardening',
      'os_hardening::limits',
      'os_hardening::login_defs',
      'os_hardening::minimize_access',
      'os_hardening::pam',
      'os_hardening::profile',
      'os_hardening::securetty',
      'os_hardening::suid_sgid',
      'os_hardening::sysctl',
    ].each { |f|
      it { is_expected.to contain_class(f) }
    }

    it { is_expected.to have_class_count(11) }
    it { is_expected.to have_resource_count(258) }
  end
end
