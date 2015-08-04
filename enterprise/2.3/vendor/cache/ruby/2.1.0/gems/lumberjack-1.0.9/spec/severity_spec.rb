require 'spec_helper'

describe Lumberjack::Severity do
  
  it "should convert a level to a label" do
    Lumberjack::Severity.level_to_label(Lumberjack::Severity::DEBUG).should == "DEBUG"
    Lumberjack::Severity.level_to_label(Lumberjack::Severity::INFO).should == "INFO"
    Lumberjack::Severity.level_to_label(Lumberjack::Severity::WARN).should == "WARN"
    Lumberjack::Severity.level_to_label(Lumberjack::Severity::ERROR).should == "ERROR"
    Lumberjack::Severity.level_to_label(Lumberjack::Severity::FATAL).should == "FATAL"
    Lumberjack::Severity.level_to_label(-1).should == "UNKNOWN"
  end
  
  it "should convert a label to a level" do
    Lumberjack::Severity.label_to_level("DEBUG").should == Lumberjack::Severity::DEBUG
    Lumberjack::Severity.label_to_level(:info).should == Lumberjack::Severity::INFO
    Lumberjack::Severity.label_to_level(:warn).should == Lumberjack::Severity::WARN
    Lumberjack::Severity.label_to_level("Error").should == Lumberjack::Severity::ERROR
    Lumberjack::Severity.label_to_level("FATAL").should == Lumberjack::Severity::FATAL
    Lumberjack::Severity.label_to_level("???").should == Lumberjack::Severity::UNKNOWN
  end
  
end
