require 'spec_helper'

describe Lumberjack::Device::DateRollingLogFile do

  before :all do
    create_tmp_dir
  end
  
  after :all do
    delete_tmp_dir
  end
  
  let(:one_day){ 60 * 60 * 24 }
  
  it "should roll the file daily" do
    today = Date.today
    now = Time.now
    log_file = File.join(tmp_dir, "a#{rand(1000000000)}.log")
    device = Lumberjack::Device::DateRollingLogFile.new(log_file, :roll => :daily, :template => ":message")
    logger = Lumberjack::Logger.new(device, :buffer_size => 2)
    logger.error("test day one")
    logger.flush
    Time.stub(:now => now + one_day)
    Date.stub(:today => today + 1)
    logger.error("test day two")
    logger.close
    
    File.read("#{log_file}.#{today.strftime('%Y-%m-%d')}").should == "test day one#{Lumberjack::LINE_SEPARATOR}"
    File.read(log_file).should == "test day two#{Lumberjack::LINE_SEPARATOR}"
  end

  it "should roll the file weekly" do
    today = Date.today
    now = Time.now
    log_file = File.join(tmp_dir, "b#{rand(1000000000)}.log")
    device = Lumberjack::Device::DateRollingLogFile.new(log_file, :roll => :weekly, :template => ":message")
    logger = Lumberjack::Logger.new(device, :buffer_size => 2)
    logger.error("test week one")
    logger.flush
    Time.stub(:now => now + (7 * one_day))
    Date.stub(:today => today + 7)
    logger.error("test week two")
    logger.close
    
    File.read("#{log_file}.#{today.strftime('week-of-%Y-%m-%d')}").should == "test week one#{Lumberjack::LINE_SEPARATOR}"
    File.read(log_file).should == "test week two#{Lumberjack::LINE_SEPARATOR}"
  end

  it "should roll the file monthly" do
    today = Date.today
    now = Time.now
    log_file = File.join(tmp_dir, "c#{rand(1000000000)}.log")
    device = Lumberjack::Device::DateRollingLogFile.new(log_file, :roll => :monthly, :template => ":message")
    logger = Lumberjack::Logger.new(device, :buffer_size => 2)
    logger.error("test month one")
    logger.flush
    Time.stub(:now => now + (31 * one_day))
    Date.stub(:today => today + 31)
    logger.error("test month two")
    logger.close
    
    File.read("#{log_file}.#{today.strftime('%Y-%m')}").should == "test month one#{Lumberjack::LINE_SEPARATOR}"
    File.read(log_file).should == "test month two#{Lumberjack::LINE_SEPARATOR}"
  end

end
