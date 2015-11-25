require 'spec_helper'

class LoggerFactory
  attr_accessor :logger

  def info
    logger.info :foo
  end

  def add
    logger.add 1, :bar
  end
end

describe Yell::Logger do
  let(:filename) { fixture_path + '/logger.log' }

  describe "a Logger instance" do
    let(:logger) { Yell::Logger.new }
    subject { logger }

    context "log methods" do
      it { should respond_to(:debug) }
      it { should respond_to(:debug?) }

      it { should respond_to(:info) }
      it { should respond_to(:info?) }

      it { should respond_to(:warn) }
      it { should respond_to(:warn?) }

      it { should respond_to(:error) }
      it { should respond_to(:error?) }

      it { should respond_to(:fatal) }
      it { should respond_to(:fatal?) }

      it { should respond_to(:unknown) }
      it { should respond_to(:unknown?) }
    end

    context "default #name" do
      its(:name) { should eq("<Yell::Logger##{logger.object_id}>") }

      it "should not be added to the repository" do
        expect { Yell::Repository[logger.name] }.to raise_error(Yell::LoggerNotFound)
      end
    end

    context "default #adapter" do
      subject { logger.adapters.instance_variable_get(:@collection) }

      its(:size) { should == 1 }
      its(:first) { should be_kind_of(Yell::Adapters::File) }
    end

    context "default #level" do
      subject { logger.level }

      it { should be_instance_of(Yell::Level) }
      its(:severities) { should eq([true, true, true, true, true, true]) }
    end

    context "default #trace" do
      subject { logger.trace }

      it { should be_instance_of(Yell::Level) }
      its(:severities) { should eq([false, false, false, true, true, true]) } # from error onwards
    end
  end

  describe "initialize with #name" do
    let(:name) { 'test' }
    let!(:logger) { Yell.new(:name => name) }

    it "should set the name correctly" do
      expect(logger.name).to eq(name)
    end

    it "should be added to the repository" do
      expect(Yell::Repository[name]).to eq(logger)
    end
  end

  context "initialize with #level" do
    let(:level) { :error }
    let(:logger) { Yell.new(:level => level) }
    subject { logger.level }

    it { should be_instance_of(Yell::Level) }
    its(:severities) { should eq([false, false, false, true, true, true]) }
  end

  context "initialize with #trace" do
    let(:trace) { :info }
    let(:logger) { Yell.new(:trace => trace) }
    subject { logger.trace }

    it { should be_instance_of(Yell::Level) }
    its(:severities) { should eq([false, true, true, true, true, true]) }
  end

  context "initialize with #silence" do
    let(:silence) { "test" }
    let(:logger) { Yell.new(:silence => silence) }
    subject { logger.silencer }

    it { should be_instance_of(Yell::Silencer) }
    its(:patterns) { should eq([silence]) }
  end

  context "initialize with a #filename" do
    it "should call adapter with :file" do
      mock.proxy(Yell::Adapters::File).new(:filename => filename)

      Yell::Logger.new(filename)
    end
  end

  context "initialize with a #filename of Pathname type" do
    let(:pathname) { Pathname.new(filename) }

    it "should call adapter with :file" do
      mock.proxy(Yell::Adapters::File).new(:filename => pathname)

      Yell::Logger.new(pathname)
    end
  end

  context "initialize with a :stdout adapter" do
    before { mock.proxy(Yell::Adapters::Stdout).new(anything) }

    it "should call adapter with STDOUT" do
      Yell::Logger.new(STDOUT)
    end

    it "should call adapter with :stdout" do
      Yell::Logger.new(:stdout)
    end
  end

  context "initialize with a :stderr adapter" do
    before { mock.proxy(Yell::Adapters::Stderr).new(anything) }

    it "should call adapter with STDERR" do
      Yell::Logger.new(STDERR)
    end

    it "should call adapter with :stderr" do
      Yell::Logger.new(:stderr)
    end
  end

  context "initialize with a block" do
    let(:level) { Yell::Level.new :error }
    let(:adapters) { logger.adapters.instance_variable_get(:@collection) }

    context "with arity" do
      let(:logger) do
        Yell::Logger.new(:level => level) { |l| l.adapter(:stdout) }
      end

      it "should pass the level correctly" do
        expect(logger.level).to eq(level)
      end

      it "should pass the adapter correctly" do
        expect(adapters.first).to be_instance_of(Yell::Adapters::Stdout)
      end
    end

    context "without arity" do
      let(:logger) do
        Yell::Logger.new(:level => level) { adapter(:stdout) }
      end

      it "should pass the level correctly" do
        expect(logger.level).to eq(level)
      end

      it "should pass the adapter correctly" do
        expect(adapters.first).to be_instance_of(Yell::Adapters::Stdout)
      end
    end
  end

  context "initialize with #adapters option" do
    it "should set adapters in logger correctly" do
      any_instance_of(Yell::Logger) do |logger|
        mock.proxy(logger).adapter(:stdout)
        mock.proxy(logger).adapter(:stderr, :level => :error)
      end

      Yell::Logger.new(:adapters => [:stdout, {:stderr => {:level => :error}}])
    end
  end

  context "caller's :file, :line and :method" do
    let(:stdout) { Yell::Adapters::Stdout.new(:format => "%F, %n: %M") }
    let(:logger) { Yell::Logger.new(:trace => true) { |l| l.adapter(stdout) } }

    it "should write correctly" do
      factory = LoggerFactory.new
      factory.logger = logger

      mock(stdout.send(:stream)).syswrite("#{__FILE__}, 7: info\n")
      mock(stdout.send(:stream)).syswrite("#{__FILE__}, 11: add\n")

      factory.info
      factory.add
    end
  end

  context "logging in general" do
    let(:logger) { Yell::Logger.new(filename, :format => "%m") }
    let(:line) { File.open(filename, &:readline) }

    it "should output a single message" do
      logger.info "Hello World"

      expect(line).to eq("Hello World\n")
    end

    it "should output multiple messages" do
      logger.info ["Hello", "W", "o", "r", "l", "d"]

      expect(line).to eq("Hello W o r l d\n")
    end

    it "should output a hash and message" do
      logger.info ["Hello World", {:test => :message}]

      expect(line).to eq("Hello World test: message\n")
    end

    it "should output a hash and message" do
      logger.info [{:test => :message}, "Hello World"]

      expect(line).to eq("test: message Hello World\n")
    end

    it "should output a hash and block" do
      logger.info(:test => :message) { "Hello World" }

      expect(line).to eq("test: message Hello World\n")
    end
  end

  context "logging with a silencer" do
    let(:silence) { "this" }
    let(:stdout) { Yell::Adapters::Stdout.new }
    let(:logger) { Yell::Logger.new(stdout, :silence => silence) }

    it "should not pass a matching message to any adapter" do
      dont_allow(stdout).write

      logger.info "this should not be logged"
    end

    it "should pass a non-matching message to any adapter" do
      mock(stdout).write(is_a(Yell::Event))

      logger.info "that should be logged"
    end
  end

end

