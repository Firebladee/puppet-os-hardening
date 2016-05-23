require 'spec_helper'
describe 'os_hardening::blacklist_files' do

  context 'with defaults' do
    let(:title) { 'test' }

    it { is_expected.to contain_exec('remove suid/sgid bit from test').with(
      :command => '/bin/chmod ug-s test',
      :onlyif  => '/usr/bin/test -f test -a -u test -o -f test -a -g test',
    )}
  end
end
