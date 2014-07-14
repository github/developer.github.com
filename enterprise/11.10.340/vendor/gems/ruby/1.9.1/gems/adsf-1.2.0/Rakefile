# Load adsf
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + '/lib'))
require 'adsf'

desc 'Run all tests'
task :test do
  $LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))

  require 'minitest/unit'
  MiniTest::Unit.autorun

  test_files = Dir["test/**/test_*.rb"]
  test_files.each { |f| require f }
end

task :default => :test
