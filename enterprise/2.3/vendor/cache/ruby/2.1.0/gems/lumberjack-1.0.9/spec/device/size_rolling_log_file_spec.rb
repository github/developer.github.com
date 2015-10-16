require 'spec_helper'

describe Lumberjack::Device::SizeRollingLogFile do

  before :all do
    create_tmp_dir
  end
  
  after :all do
    delete_tmp_dir
  end

  it "should roll a file when it gets to a specified size" do
    log_file = File.join(tmp_dir, "a#{rand(1000000000)}.log")
    device = Lumberjack::Device::SizeRollingLogFile.new(log_file, :max_size => 40, :template => ":message")
    logger = Lumberjack::Logger.new(device, :buffer_size => 2)
    4.times do |i|
      logger.error("test message #{i + 1}")
      logger.flush
    end
    logger.close
    
    File.read("#{log_file}.1").split(Lumberjack::LINE_SEPARATOR).should == ["test message 1", "test message 2", "test message 3"]
    File.read(log_file).should == "test message 4#{Lumberjack::LINE_SEPARATOR}"
  end
  
  it "should be able to specify the max size in kilobytes" do
    log_file = File.join(tmp_dir, "b#{rand(1000000000)}.log")
    device = Lumberjack::Device::SizeRollingLogFile.new(log_file, :max_size => "32K")
    device.max_size.should == 32768
  end
  
  it "should be able to specify the max size in megabytes" do
    log_file = File.join(tmp_dir, "c#{rand(1000000000)}.log")
    device = Lumberjack::Device::SizeRollingLogFile.new(log_file, :max_size => "100M")
    device.max_size.should == 104_857_600
  end
  
  it "should be able to specify the max size in gigabytes" do
    log_file = File.join(tmp_dir, "d#{rand(1000000000)}.log")
    device = Lumberjack::Device::SizeRollingLogFile.new(log_file, :max_size => "1G")
    device.max_size.should == 1_073_741_824
  end
  
  it "should figure out the next archive file name available" do
    log_file = File.join(tmp_dir, "filename.log")
    (3..11).each do |i|
      File.open("#{log_file}.#{i}", 'w'){|f| f.write(i.to_s)}
    end
    device = Lumberjack::Device::SizeRollingLogFile.new(log_file, :max_size => "100M")
    device.archive_file_suffix.should == "12"
  end

end
