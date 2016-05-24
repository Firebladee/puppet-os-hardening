require 'spec_helper'
describe 'os_hardening::sysctl' do

  describe 'with defaults' do
    it { is_expected.to contain_class('os_hardening::sysctl') }
    it { is_expected.to have_class_count(3) }
    it { is_expected.to have_resource_count(206) }
 
    let(:params) {{ :log_martians => false }} 
    it { is_expected.to contain_sysctl('net.ipv4.ip_forward').with_value('0') }

    it { is_expected.to contain_sysctl('net.ipv6.conf.all.disable_ipv6').with_value('1') }
    it { is_expected.to contain_sysctl('net.ipv6.conf.all.forwarding').with_value('0') }
    it { is_expected.to contain_sysctl('net.ipv6.conf.default.router_solicitations').with_value('0') }
    it { is_expected.to contain_sysctl('net.ipv6.conf.default.accept_ra_rtr_pref').with_value('0') }
    it { is_expected.to contain_sysctl('net.ipv6.conf.default.accept_ra_pinfo').with_value('0') }
    it { is_expected.to contain_sysctl('net.ipv6.conf.default.accept_ra_defrtr').with_value('0') }
    it { is_expected.to contain_sysctl('net.ipv6.conf.default.autoconf').with_value('0') }
    it { is_expected.to contain_sysctl('net.ipv6.conf.default.dad_transmits').with_value('0') }
    it { is_expected.to contain_sysctl('net.ipv6.conf.default.max_addresses').with_value('1') }

    it { is_expected.to contain_sysctl('net.ipv6.conf.all.accept_ra').with_value('0') }
    it { is_expected.to contain_sysctl('net.ipv6.conf.default.accept_ra').with_value('0') }

    it { is_expected.to contain_sysctl('net.ipv4.conf.all.rp_filter').with_value('1') }
    it { is_expected.to contain_sysctl('net.ipv4.conf.default.rp_filter').with_value('1') }

    it { is_expected.to contain_sysctl('net.ipv4.icmp_echo_ignore_broadcasts').with_value('1') }

    it { is_expected.to contain_sysctl('net.ipv4.icmp_ignore_bogus_error_responses').with_value('1') }

    it { is_expected.to contain_sysctl('net.ipv4.icmp_ratelimit').with_value('100') }

    it { is_expected.to contain_sysctl('net.ipv4.icmp_ratemask').with_value('88089') }

    it { is_expected.to contain_sysctl('net.ipv4.tcp_timestamps').with_value('0') }

    it { is_expected.to contain_sysctl('net.ipv4.conf.all.arp_ignore').with_value('1') }
    it { is_expected.to contain_sysctl('net.ipv4.conf.all.arp_announce').with_value('2') }

    it { is_expected.to contain_sysctl('net.ipv4.tcp_rfc1337').with_value('1') }

    it { is_expected.to contain_sysctl('net.ipv4.tcp_syncookies').with_value('1') }

    it { is_expected.to contain_sysctl('net.ipv4.conf.all.shared_media').with_value('1') }
    it { is_expected.to contain_sysctl('net.ipv4.conf.default.shared_media').with_value('1') }

    it { is_expected.to contain_sysctl('net.ipv4.conf.all.accept_source_route').with_value('0') }
    it { is_expected.to contain_sysctl('net.ipv6.conf.all.accept_source_route').with_value('0') }
    it { is_expected.to contain_sysctl('net.ipv4.conf.default.accept_source_route').with_value('0') }
    it { is_expected.to contain_sysctl('net.ipv6.conf.default.accept_source_route').with_value('0') }

    it { is_expected.to contain_sysctl('net.ipv4.conf.all.accept_redirects').with_value('0') }
    it { is_expected.to contain_sysctl('net.ipv4.conf.default.accept_redirects').with_value('0') }
    it { is_expected.to contain_sysctl('net.ipv6.conf.all.accept_redirects').with_value('0') }
    it { is_expected.to contain_sysctl('net.ipv6.conf.default.accept_redirects').with_value('0') }
    it { is_expected.to contain_sysctl('net.ipv4.conf.all.secure_redirects').with_value('0') }
    it { is_expected.to contain_sysctl('net.ipv4.conf.default.secure_redirects').with_value('0') }

    it { is_expected.to contain_sysctl('net.ipv4.conf.all.send_redirects').with_value('0') }
    it { is_expected.to contain_sysctl('net.ipv4.conf.default.send_redirects').with_value('0') }

    it { is_expected.to contain_sysctl('net.ipv4.conf.all.log_martians').with_value('0') }

    it { is_expected.to contain_sysctl('kernel.sysrq').with_value('0') }

    it { is_expected.to contain_sysctl('kernel.randomize_va_space').with_value('2') }

    it { is_expected.to contain_sysctl('fs.suid_dumpable').with_value('0') }
  end

  context 'with enable_ipv4_forwarding => true' do
    let(:params) { { :enable_ipv4_forwarding => true } }
    it { is_expected.to contain_sysctl('net.ipv4.ip_forward').with_value('1') }
  end

  context 'with enable_ipv6 => true' do
    let(:params) { { :enable_ipv6 => true } }
    it { is_expected.to contain_sysctl('net.ipv6.conf.all.disable_ipv6').with_value('0') }
    it { is_expected.to contain_sysctl('net.ipv6.conf.all.forwarding').with_value('0') }

    context 'with enable_ipv6_forwarding => true' do
      let(:params) { { :enable_ipv6_forwarding => true, :enable_ipv6 => true } }
      it { is_expected.to contain_sysctl('net.ipv6.conf.all.forwarding').with_value('1') }
    end

    context 'with enable_ipv6_forwarding => false' do
      let(:params) { { :enable_ipv6_forwarding => false, :enable_ipv6 => true } }
      it { is_expected.to contain_sysctl('net.ipv6.conf.all.forwarding').with_value('0') }
    end
  end

  context 'with arp_restricted => false' do
    let(:params) { { :arp_restricted => false } }
    it { is_expected.to contain_sysctl('net.ipv4.conf.all.arp_ignore').with_value('0') }
    it { is_expected.to contain_sysctl('net.ipv4.conf.all.arp_announce').with_value('0') }
  end

  context 'with enable_module_loading => false' do
    let(:params) { { :enable_module_loading => false } }
    it { is_expected.to contain_sysctl('kernel.modules_disabled').with_value('1') }
  end

  context 'with enable_sysrq => true' do
    let(:params) { { :enable_sysrq => true } }
    allowed_sysrq = 4 + 16 + 32 + 64 + 128
    it { is_expected.to contain_sysctl('kernel.sysrq').with_value(allowed_sysrq) }
  end

  context 'with enable_stack_protection => false' do
    let(:params) { { :enable_stack_protection => false } }
    it { is_expected.to contain_sysctl('kernel.randomize_va_space').with_value('0') }
  end

  context 'with enable_core_dump => true' do
    let(:params) { { :enable_core_dump => true } }
    it { is_expected.to contain_sysctl('fs.suid_dumpable').with_value('1') }
  end

  context 'with log_martians => true' do
    let(:params) {{ :log_martians => true }}
    it { is_expected.to contain_sysctl('net.ipv4.conf.all.log_martians').with_value('1') }
  end
end
