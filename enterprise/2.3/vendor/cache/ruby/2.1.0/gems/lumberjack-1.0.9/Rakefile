require 'rubygems'
require 'rake'
require 'rubygems/package_task'

desc 'Default: run unit tests.'
task :default => :test

desc 'RVM likes to call it tests'
task :tests => :test

begin
  require 'rspec'
  require 'rspec/core/rake_task'
  desc 'Run the unit tests'
  RSpec::Core::RakeTask.new(:test)
rescue LoadError
  task :test do
    STDERR.puts "You must have rspec 2.0 installed to run the tests"
  end
end

namespace :rbx do
  desc "Cleanup *.rbc files in lib directory"
  task :delete_rbc_files do
    FileList["**/*.rbc"].each do |rbc_file|
      File.delete(rbc_file)
    end
    nil
  end
end

spec_file = File.expand_path('../lumberjack.gemspec', __FILE__)
if File.exist?(spec_file)
  spec = eval(File.read(spec_file))

  Gem::PackageTask.new(spec) do |p|
    p.gem_spec = spec
  end
  Rake.application["package"].prerequisites.unshift("rbx:delete_rbc_files")
end
