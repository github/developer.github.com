require 'spec_helper'

describe Lumberjack::Formatter::PrettyPrintFormatter do

  it "should convert an object to a string using pretty print" do
    object = Object.new
    def object.pretty_print(q)
      q.text "woot!"
    end
    formatter = Lumberjack::Formatter::PrettyPrintFormatter.new
    formatter.call(object).should == "woot!"
  end

end
