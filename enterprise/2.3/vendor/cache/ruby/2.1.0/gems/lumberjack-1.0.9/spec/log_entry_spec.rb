require 'spec_helper'

describe Lumberjack::LogEntry do
  
  it "should have a time" do
    t = Time.now
    entry = Lumberjack::LogEntry.new(t, Lumberjack::Severity::INFO, "test", "app", 1500, "ABCD")
    entry.time.should == t
    entry.time = t + 1
    entry.time.should == t + 1
  end
  
  it "should have a severity" do
    entry = Lumberjack::LogEntry.new(Time.now, Lumberjack::Severity::INFO, "test", "app", 1500, "ABCD")
    entry.severity.should == Lumberjack::Severity::INFO
    entry.severity = Lumberjack::Severity::WARN
    entry.severity.should == Lumberjack::Severity::WARN
  end
  
  it "should convert a severity label to a numeric level" do
    entry = Lumberjack::LogEntry.new(Time.now, "INFO", "test", "app", 1500, "ABCD")
    entry.severity.should == Lumberjack::Severity::INFO
  end
  
  it "should get the severity as a string" do
    Lumberjack::LogEntry.new(Time.now, Lumberjack::Severity::DEBUG, "test", "app", 1500, nil).severity_label.should == "DEBUG"
    Lumberjack::LogEntry.new(Time.now, Lumberjack::Severity::INFO, "test", "app", 1500, nil).severity_label.should == "INFO"
    Lumberjack::LogEntry.new(Time.now, Lumberjack::Severity::WARN, "test", "app", 1500, nil).severity_label.should == "WARN"
    Lumberjack::LogEntry.new(Time.now, Lumberjack::Severity::ERROR, "test", "app", 1500, nil).severity_label.should == "ERROR"
    Lumberjack::LogEntry.new(Time.now, Lumberjack::Severity::FATAL, "test", "app", 1500, nil).severity_label.should == "FATAL"
    Lumberjack::LogEntry.new(Time.now, -1, "test", "app", 1500, nil).severity_label.should == "UNKNOWN"
    Lumberjack::LogEntry.new(Time.now, 1000, "test", "app", 1500, nil).severity_label.should == "UNKNOWN"
  end
  
  it "should have a message" do
    entry = Lumberjack::LogEntry.new(Time.now, Lumberjack::Severity::INFO, "test", "app", 1500, "ABCD")
    entry.message.should == "test"
    entry.message = "new message"
    entry.message.should == "new message"
  end
  
  it "should have a progname" do
    entry = Lumberjack::LogEntry.new(Time.now, Lumberjack::Severity::INFO, "test", "app", 1500, "ABCD")
    entry.progname.should == "app"
    entry.progname = "prog"
    entry.progname.should == "prog"
  end
  
  it "should have a pid" do
    entry = Lumberjack::LogEntry.new(Time.now, Lumberjack::Severity::INFO, "test", "app", 1500, "ABCD")
    entry.pid.should == 1500
    entry.pid = 150
    entry.pid.should == 150
  end
  
  it "should have a unit_of_work_id" do
    entry = Lumberjack::LogEntry.new(Time.now, Lumberjack::Severity::INFO, "test", "app", 1500, "ABCD")
    entry.unit_of_work_id.should == "ABCD"
    entry.unit_of_work_id = "1234"
    entry.unit_of_work_id.should == "1234"
  end
  
  it "should be converted to a string" do
    t = Time.parse("2011-01-29T12:15:32.001")
    entry = Lumberjack::LogEntry.new(t, Lumberjack::Severity::INFO, "test", "app", 1500, "ABCD")
    entry.to_s.should == "[2011-01-29T12:15:32.001 INFO app(1500) #ABCD] test"
  end

end
