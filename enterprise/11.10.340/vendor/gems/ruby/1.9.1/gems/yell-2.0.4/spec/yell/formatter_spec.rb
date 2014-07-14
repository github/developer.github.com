require 'spec_helper'

describe Yell::Formatter do

  let(:logger) { Yell::Logger.new(:stdout, :name => 'Yell') }
  let(:message) { "Hello World!" }
  let(:event) { Yell::Event.new(logger, 1, message) }

  let(:pattern) { "%m" }
  let(:formatter) { Yell::Formatter.new(pattern) }

  let(:time) { Time.now }

  subject { formatter.call(event) }

  before do
    Timecop.freeze(time)
  end

  describe "patterns" do
    context "%m" do
      let(:pattern) { "%m" }
      it { should eq("#{event.messages.join(' ')}\n") }
    end

    context "%l" do
      let(:pattern) { "%l" }
      it { should eq("#{Yell::Severities[event.level][0,1]}\n") }
    end

    context "%L" do
      let(:pattern) { "%L" }
      it { should eq("#{Yell::Severities[event.level]}\n") }
    end

    context "%d" do
      let(:pattern) { "%d" }
      it { should eq("#{event.time.iso8601}\n") }
    end

    context "%p" do
      let(:pattern) { "%p" }
      it { should eq("#{event.pid}\n") }
    end

    context "%P" do
      let(:pattern) { "%P" }
      it { should eq("#{event.progname}\n") }
    end

    context "%t" do
      let(:pattern) { "%t" }
      it { should eq("#{event.thread_id}\n") }
    end

    context "%h" do
      let(:pattern) { "%h" }
      it { should eq("#{event.hostname}\n") }
    end

    context ":caller" do
      let(:_caller) { [nil, nil, "/path/to/file.rb:123:in `test_method'"] }

      before do
        any_instance_of(Yell::Event) do |e|
          stub(e).file { "/path/to/file.rb" }
          stub(e).line { "123" }
          stub(e).method { "test_method" }
        end
      end

      context "%F" do
        let(:pattern) { "%F" }
        it { should eq("/path/to/file.rb\n") }
      end

      context "%f" do
        let(:pattern) { "%f" }
        it { should eq("file.rb\n") }
      end

      context "%M" do
        let(:pattern) { "%M" }
        it { should eq("test_method\n") }
      end

      context "%n" do
        let(:pattern) { "%n" }
        it { should eq("123\n") }
      end
    end

    context "%N" do
      let(:pattern) { "%N" }
      it { should eq("Yell\n") }
    end
  end

  describe "presets" do
    context "NoFormat" do
      let(:pattern) { Yell::NoFormat }
      it { should eq("Hello World!\n") }
    end

    context "DefaultFormat" do
      let(:pattern) { Yell::DefaultFormat }
      it { should eq("#{time.iso8601} [ INFO] #{$$} : Hello World!\n")  }
    end

    context "BasicFormat" do
      let(:pattern) { Yell::BasicFormat }
      it { should eq("I, #{time.iso8601} : Hello World!\n") }
    end

    context "ExtendedFormat" do
      let(:pattern) { Yell::ExtendedFormat }
      it { should eq("#{time.iso8601} [ INFO] #{$$} #{Socket.gethostname} : Hello World!\n") }
    end
  end

  describe "Exception" do
    let(:message) { StandardError.new("This is an Exception") }

    before do
      stub(message).backtrace { ["backtrace"] }
    end

    it { should eq("StandardError: This is an Exception\n\tbacktrace\n") }
  end

  describe "Hash" do
    let(:message) { {:test => 'message'} }

    it { should eq("test: message\n") }
  end

  describe "custom message modifiers" do
    let(:formatter) do
      Yell::Formatter.new(pattern) { |f| f.modify(String) { |m| "Modified! #{m}" } }
    end

    it { should eq("Modified! #{message}\n") }
  end

end

