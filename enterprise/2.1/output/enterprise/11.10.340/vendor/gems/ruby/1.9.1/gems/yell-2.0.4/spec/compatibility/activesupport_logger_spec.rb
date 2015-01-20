# encoding: utf-8
require 'spec_helper'

begin
  require 'active_support'
rescue LoadError
end

# make a setup just like in railties ~> 4.0.0
#
# We simulate the case when Rails 4 starts up its server
# and wants to append the log output.
describe "Compatibility to ActiveSupport::Logger", :pending => (!defined?(ActiveSupport) || ActiveSupport::VERSION::MAJOR < 4) do

  let!(:yell) { Yell.new($stdout, :format => "%m") }

  let!(:logger) do
    console = ActiveSupport::Logger.new($stdout)
    console.formatter = yell.formatter
    console.level = yell.level

    yell.extend(ActiveSupport::Logger.broadcast(console))

    console
  end

  it "should behave correctly" do
    mock($stdout).syswrite("Hello World\n") # yell
    mock($stdout).write("Hello World\n") # logger

    yell.info "Hello World"
  end

end

