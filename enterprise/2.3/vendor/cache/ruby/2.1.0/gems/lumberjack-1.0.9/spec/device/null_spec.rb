require 'spec_helper'

describe Lumberjack::Device::Null do

  it "should not generate any output" do
    device = Lumberjack::Device::Null.new
    device.write(Lumberjack::LogEntry.new(Time.now, 1, "New log entry", nil, $$, nil))
    device.flush
    device.close
  end

end
