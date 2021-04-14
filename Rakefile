begin
  require 'rake/extensiontask'

  # Set MAKEFLAGS for GNU/BSD make to print compiling commands in verbose mode.
  # https://github.com/rake-compiler/rake-compiler/pull/192
  ENV['MAKEFLAGS'] = 'V=1' if ENV['MAKEFLAGS'].nil?

  Rake::ExtensionTask.new('testj') do |ext|
    ext.lib_dir = 'lib/testj'
  end
rescue LoadError
  warn 'Failed to load a depdendency of compile task.'
end

# See https://github.com/sparklemotion/nokogiri/blob/main/rakelib/debug.rake
desc "Set environment variables to build and/or test with debug options"
task :debug do
  ENV['TESTJ_DEBUG'] = 'true'
  ENV['CFLAGS'] ||= ''
  ENV['CFLAGS'] += ' -DDEBUG'
end

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
  warn 'Failed to load a depdendency of spec task.'
end

task default: %i[compile spec]
