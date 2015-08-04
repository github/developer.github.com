require 'spec_helper'

describe Lumberjack::Formatter::InspectFormatter do

  it "should format objects as string by calling their inspect method" do
    formatter = Lumberjack::Formatter::InspectFormatter.new
    formatter.call("abc").should == "\"abc\""
    formatter.call(:test).should == ":test"
    formatter.call(1).should == "1"
    formatter.call([:a, 1, "b"]).should == [:a, 1, "b"].inspect
  end

end
