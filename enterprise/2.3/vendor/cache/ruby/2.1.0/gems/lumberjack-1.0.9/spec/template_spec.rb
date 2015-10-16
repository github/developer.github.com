require 'spec_helper'

describe Lumberjack::Template do
  
  let(:time_string){ "2011-01-15T14:23:45.123" }
  let(:time){ Time.parse(time_string) }
  let(:entry){ Lumberjack::LogEntry.new(time, Lumberjack::Severity::INFO, "line 1#{Lumberjack::LINE_SEPARATOR}line 2#{Lumberjack::LINE_SEPARATOR}line 3", "app", 12345, "ABCD") }

  it "should format a log entry with a template string" do
    template = Lumberjack::Template.new(":message - :severity, :time, :progname@:pid (:unit_of_work_id)")
    template.call(entry).should == "line 1 - INFO, 2011-01-15T14:23:45.123, app@12345 (ABCD)#{Lumberjack::LINE_SEPARATOR}line 2#{Lumberjack::LINE_SEPARATOR}line 3"
  end
  
  it "should be able to specify the time format for log entries as microseconds" do
    template = Lumberjack::Template.new(":message (:time)", :time_format => :microseconds)
    template.call(entry).should == "line 1 (2011-01-15T14:23:45.123000)#{Lumberjack::LINE_SEPARATOR}line 2#{Lumberjack::LINE_SEPARATOR}line 3"
  end
  
  it "should be able to specify the time format for log entries as milliseconds" do
    template = Lumberjack::Template.new(":message (:time)", :time_format => :milliseconds)
    template.call(entry).should == "line 1 (2011-01-15T14:23:45.123)#{Lumberjack::LINE_SEPARATOR}line 2#{Lumberjack::LINE_SEPARATOR}line 3"
  end
      
  it "should be able to specify the time format for log entries with a custom format" do
    template = Lumberjack::Template.new(":message (:time)", :time_format => "%m/%d/%Y, %I:%M:%S %p")
    template.call(entry).should == "line 1 (01/15/2011, 02:23:45 PM)#{Lumberjack::LINE_SEPARATOR}line 2#{Lumberjack::LINE_SEPARATOR}line 3"
  end
  
  it "should be able to specify a template for additional lines in a message" do
    template = Lumberjack::Template.new(":message (:time)", :additional_lines => " // :message")
    template.call(entry).should == "line 1 (2011-01-15T14:23:45.123) // line 2 // line 3"
  end

end
