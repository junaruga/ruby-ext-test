require 'rake/extensiontask'
# A hack to run the Makefile with options.
# https://github.com/rake-compiler/rake-compiler/blob/v1.1.1/lib/rake/extensiontask.rb#L477
ENV['MAKE'] = 'make V=1'
Rake::ExtensionTask.new('testj') do |ext|
  ext.lib_dir = 'lib/testj'
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task default: %i[compile spec]
