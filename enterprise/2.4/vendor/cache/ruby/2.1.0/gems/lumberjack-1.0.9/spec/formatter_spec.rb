require 'spec_helper'

describe Lumberjack::Formatter do

  let(:formatter){ Lumberjack::Formatter.new }
  
  it "should have a default set of formatters" do
    formatter.format("abc").should == "abc"
    formatter.format([1, 2, 3]).should == "[1, 2, 3]"
    formatter.format(ArgumentError.new("boom")).should == "ArgumentError: boom"
  end
  
  it "should be able to add a formatter object for a class" do
    formatter.add(Numeric, lambda{|obj| "number: #{obj}"})
    formatter.format(10).should == "number: 10"
  end
  
  it "should be able to add a formatter block for a class" do
    formatter.add(Numeric){|obj| "number: #{obj}"}
    formatter.format(10).should == "number: 10"
  end
  
  it "should be able to remove a formatter for a class" do
    formatter.remove(String)
    formatter.format("abc").should == "\"abc\""
  end
  
  it "should be able to chain add and remove calls" do
    formatter.remove(String).should == formatter
    formatter.add(String, Lumberjack::Formatter::StringFormatter.new).should == formatter
  end
  
  it "should format an object based on the class hierarchy" do
    formatter.add(Numeric){|obj| "number: #{obj}"}
    formatter.add(Fixnum){|obj| "fixed number: #{obj}"}
    formatter.format(10).should == "fixed number: 10"
    formatter.format(10.1).should == "number: 10.1"
  end
  
  it "should have a default formatter" do
    formatter.remove(Object)
    formatter.format(:test).should == ":test"
  end

end
