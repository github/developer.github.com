require 'spec_helper'

describe Lumberjack::Device::RollingLogFile do

  before :all do
    Lumberjack::Device::SizeRollingLogFile #needed by jruby
    create_tmp_dir
  end
  
  after :all do
    delete_tmp_dir
  end
  
  let(:entry){ Lumberjack::LogEntry.new(Time.now, 1, "New log entry", nil, $$, nil) }

  it "should check for rolling the log file on flush" do
    device = Lumberjack::Device::RollingLogFile.new(File.join(tmp_dir, "test.log"), :buffer_size => 32767)
    device.write(entry)
    device.should_receive(:roll_file?).twice.and_return(false)
    device.flush
    device.close
  end
  
  it "should roll the file by archiving the existing file and opening a new stream and calling after_roll" do
    log_file = File.join(tmp_dir, "test_2.log")
    device = Lumberjack::Device::RollingLogFile.new(log_file, :template => ":message", :buffer_size => 32767)
    device.should_receive(:roll_file?).and_return(false, true)
    device.should_receive(:after_roll)
    device.stub(:archive_file_suffix => "rolled")
    device.write(entry)
    device.flush
    device.write(Lumberjack::LogEntry.new(Time.now, 1, "Another log entry", nil, $$, nil))
    device.close
    File.read("#{log_file}.rolled").should == "New log entry#{Lumberjack::LINE_SEPARATOR}"
    File.read(log_file).should == "Another log entry#{Lumberjack::LINE_SEPARATOR}"
  end
  
  it "should reopen the file if the stream inode doesn't match the file path inode" do
    log_file = File.join(tmp_dir, "test_3.log")
    device = Lumberjack::Device::RollingLogFile.new(log_file, :template => ":message")
    device.stub(:roll_file? => false)
    device.write(entry)
    device.flush
    File.rename(log_file, "#{log_file}.rolled")
    device.flush
    device.write(Lumberjack::LogEntry.new(Time.now, 1, "Another log entry", nil, $$, nil))
    device.close
    File.read("#{log_file}.rolled").should == "New log entry#{Lumberjack::LINE_SEPARATOR}"
    File.read(log_file).should == "Another log entry#{Lumberjack::LINE_SEPARATOR}"
  end
  
  it "should roll the file properly with multiple thread and processes using it" do
    log_file = File.join(tmp_dir, "test_4.log")
    process_count = 8
    thread_count = 4
    entry_count = 400
    max_size = 128
    severity = Lumberjack::Severity::INFO
    message = "This is a test message that is written to the log file to indicate what the state of the application is."
    
    logger_test = lambda do
      device = Lumberjack::Device::SizeRollingLogFile.new(log_file, :max_size => max_size, :template => ":message", :buffer_size => 32767)
      threads = []
      thread_count.times do
        threads << Thread.new do
          entry_count.times do |i|
            device.write(Lumberjack::LogEntry.new(Time.now, severity, message, "test", $$, nil))
            device.flush if i % 10 == 0
          end
        end
      end
      threads.each{|thread| thread.join}
      device.close
    end
    
    # Process.fork is unavailable on jruby so we need to use the java threads instead.
    if RUBY_PLATFORM.match(/java/)
      outer_threads = []
      process_count.times do
        outer_threads << Thread.new(&logger_test)
      end
      outer_threads.each{|thread| thread.join}
    else
      process_count.times do
        Process.fork(&logger_test)
      end
      Process.waitall
    end
    
    line_count = 0
    file_count = 0
    Dir.glob("#{log_file}*").each do |file|
      file_count += 1
      lines = File.read(file).split(Lumberjack::LINE_SEPARATOR)
      line_count += lines.size
      lines.each do |line|
        line.should == message
      end
      unless file == log_file
        #File.size(file).should >= max_size
      end
    end
    
    file_count.should > 3
    line_count.should == process_count * thread_count * entry_count
  end
  
  it "should only keep a specified number of archived log files" do
    log_file = File.join(tmp_dir, "test_5.log")
    device = Lumberjack::Device::RollingLogFile.new(log_file, :template => ":message", :keep => 2, :buffer_size => 32767)
    device.should_receive(:roll_file?).and_return(false, true, true, true)
    device.should_receive(:archive_file_suffix).and_return("delete", "another", "keep")
    t = Time.now
    File.should_receive(:ctime).with("#{log_file}.delete").at_least(1).times.and_return(t + 1)
    File.should_receive(:ctime).with("#{log_file}.another").at_least(1).times.and_return(t + 2)
    File.should_receive(:ctime).with("#{log_file}.keep").at_least(1).times.and_return(t + 3)
    device.write(entry)
    device.flush
    device.write(entry)
    device.flush
    device.write(entry)
    device.flush
    device.write(entry)
    device.close
    Dir.glob("#{log_file}*").sort.should == [log_file, "#{log_file}.another", "#{log_file}.keep"]
  end

end
