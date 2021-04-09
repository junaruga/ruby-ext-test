require 'rake/extensiontask'
Rake::ExtensionTask.new('testj') do |ext|
  ext.lib_dir = 'lib/testj'
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task default: %i[compile spec]
