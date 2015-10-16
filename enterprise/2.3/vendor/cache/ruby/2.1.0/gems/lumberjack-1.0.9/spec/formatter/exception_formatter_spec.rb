require 'spec_helper'

describe Lumberjack::Formatter::ExceptionFormatter do

  it "should convert an exception without a backtrace to a string" do
    e = ArgumentError.new("not expected")
    formatter = Lumberjack::Formatter::ExceptionFormatter.new
    formatter.call(e).should == "ArgumentError: not expected"
  end
  
  it "should convert an exception with a backtrace to a string" do
    begin
      raise ArgumentError.new("not expected")
    rescue => e
      formatter = Lumberjack::Formatter::ExceptionFormatter.new
      formatter.call(e).should == "ArgumentError: not expected#{Lumberjack::LINE_SEPARATOR}  #{e.backtrace.join(Lumberjack::LINE_SEPARATOR + '  ')}"
    end
  end
  
end
