# encoing: utf-8

require 'rake/testtask'
require 'yard'

YARD::Rake::YardocTask.new(:doc) do |yard|
  yard.files   = Dir['lib/**/*.rb']
  yard.options = [
    '--markup',        'markdown',
    '--readme',        'README.adoc',
    '--files',         'NEWS.md,LICENSE',
    '--output-dir',    'doc/yardoc',
  ]
end

task :test do
  require './test/helper.rb'

  FileList['./test/**/test_*.rb', './test/**/*_spec.rb'].each do |fn|
    require fn
  end
end

task :default => :test
