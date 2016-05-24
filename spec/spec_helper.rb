require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'
require 'simplecov'
require 'coveralls'

include RspecPuppetFacts

RSpec.configure do |config|
  config.formatter = :documentation
end

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  add_filter '/spec/'
end

Coveralls.wear!

at_exit { RSpec::Puppet::Coverage.report! }
