source 'https://rubygems.org'

puppetversion = ENV['PUPPET_VERSION']
if puppetversion
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end

gem 'rspec-puppet'
gem 'puppetlabs_spec_helper'
gem 'puppet-lint'
gem 'rubocop', '~> 0.31' if RUBY_VERSION > '1.9.2'
gem 'simplecov'
gem 'coveralls', require: false
gem 'rspec-puppet-facts', :require => false
