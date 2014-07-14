require 'spec_helper'

# Since Yell::Event.new is not called directly, but through
# the logger methods, we need to divert here in order to get 
# the correct caller.
class EventFactory
  def self.event(logger, level, message)
    self._event(logger, level, message)
  end

  private

  def self._event(logger, level, message)
    Yell::Event.new(logger, level, message)
  end

end

describe Yell::Event do
  let(:logger) { Yell::Logger.new(:trace => true) }
  let(:event) { Yell::Event.new(logger, 1, 'Hello World!') }

  context "#level" do
    subject { event.level }
    it { should eq(1) }
  end

  context "#messages" do
    subject { event.messages }
    it { should eq(['Hello World!']) }
  end

  context "#time" do
    let(:time) { Time.now }
    subject { event.time.to_s }

    before { Timecop.freeze(time) }

    it { should eq(time.to_s) }
  end

  context "#hostname" do
    subject { event.hostname }
    it { should eq(Socket.gethostname) }
  end

  context "#pid" do
    subject { event.pid }
    it { should eq(Process.pid) }
  end

  context "#id when forked", :pending => RUBY_PLATFORM == 'java' ? "No forking with jruby" : false do
    subject { @pid }

    before do
      read, write = IO.pipe

      @pid = Process.fork do
        event = Yell::Event.new(logger, 1, 'Hello World!')
        write.puts event.pid
      end
      Process.wait
      write.close

      @child_pid = read.read.to_i
      read.close
    end

    it { should_not eq(Process.pid) }
    it { should eq(@child_pid) }
  end

  context "#progname" do
    subject { event.progname }
    it { should eq($0) }
  end

  context ":caller" do
    subject { EventFactory.event(logger, 1, "Hello World") }

    context "with trace" do
      its(:file) { should eq(__FILE__) }
      its(:line) { should eq("8") }
      its(:method) { should eq("event") }
    end

    context "without trace" do
      before { logger.trace = false }

      its(:file) { should eq("") }
      its(:line) { should eq("") }
      its(:method) { should eq("") }
    end
  end

end

