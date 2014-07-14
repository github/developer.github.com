$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

ENV['YELL_ENV'] = 'test'

require 'rspec/core'
require 'rspec/expectations'
require 'rr'
require 'timecop'
require 'pry'

begin
  require 'coveralls'
  require 'simplecov'

  STDERR.puts "Running coverage..."
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]

  SimpleCov.start do
    add_filter 'spec'
  end
rescue LoadError
  # do nothing
end

require 'yell'

RSpec.configure do |config|
  config.mock_framework = :rr

  config.before :each do
    Yell::Repository.loggers.clear

    Dir[ fixture_path + "/*.log" ].each { |f| File.delete f }
  end

  config.after :each do
    Timecop.return # release time after each test
  end


  private

  def fixture_path
    File.expand_path( "fixtures", File.dirname(__FILE__) )
  end

end

