require 'spec_helper'

describe Lumberjack::Device::LogFile do

  before :all do
    create_tmp_dir
  end
  
  after :all do
    delete_tmp_dir
  end
  
  it "should append to a file" do
    log_file = File.join(tmp_dir, "a#{rand(1000000000)}.log")
    File.open(log_file, 'w') do |f|
      f.puts("Existing contents")
    end
    
    device = Lumberjack::Device::LogFile.new(log_file, :template => ":message")
    device.write(Lumberjack::LogEntry.new(Time.now, 1, "New log entry", nil, $$, nil))
    device.close
    
    File.read(log_file).should == "Existing contents\nNew log entry#{Lumberjack::LINE_SEPARATOR}"
  end

end
