require 'puppet-lint/tasks/puppet-lint'
require 'puppetlabs_spec_helper/rake_tasks'

PuppetLint.configuration.send('disable_autoloader_layout')
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.fail_on_warnings = true
PuppetLint.configuration.ignore_paths = ['vendor/**/*.pp']

if RUBY_VERSION > '1.9.2'
  require 'rubocop'
  require 'rubocop/rake_task'

  desc 'Run all linters: rubocop and puppet-lint'
  task :run_all_linters => [:rubocop, :lint]

  # Rubocop
  desc 'Run Rubocop lint checks'
  task :rubocop do
    RuboCop::RakeTask.new
  end

else
  desc 'Run all linters: rubocop and puppet-lint'
  task :run_all_linters => [:lint]

end

desc 'Validate manifests, templates, and ruby files'
task :validate do
  Dir['manifests/**/*.pp'].each do |manifest|
    sh "puppet parser validate --noop #{manifest}"
  end
  Dir['spec/**/*.rb', 'lib/**/*.rb'].each do |ruby_file|
    sh "ruby -c #{ruby_file}" unless ruby_file =~ %r{/spec\/fixtures/}
  end
  Dir['templates/**/*.erb'].each do |template|
    sh "erb -P -x -T '-' #{template} | ruby -c"
  end
end
