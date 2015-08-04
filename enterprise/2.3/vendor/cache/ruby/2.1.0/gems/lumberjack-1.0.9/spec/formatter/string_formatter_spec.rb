require 'spec_helper'

describe Lumberjack::Formatter::StringFormatter do

  it "should format objects as string by calling their to_s method" do
    formatter = Lumberjack::Formatter::StringFormatter.new
    formatter.call("abc").should == "abc"
    formatter.call(:test).should == "test"
    formatter.call(1).should == "1"
  end

end
