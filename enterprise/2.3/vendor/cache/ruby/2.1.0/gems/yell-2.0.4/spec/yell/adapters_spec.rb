require 'spec_helper'

describe Yell::Adapters do

  context ".new" do
    it "should accept an adapter instance" do
      stdout = Yell::Adapters::Stdout.new
      adapter = Yell::Adapters.new(stdout)

      expect(adapter).to eq(stdout)
    end

    it "should accept STDOUT" do
      mock.proxy(Yell::Adapters::Stdout).new(anything)

      Yell::Adapters.new(STDOUT)
    end

    it "should accept STDERR" do
      mock.proxy(Yell::Adapters::Stderr).new(anything)

      Yell::Adapters.new(STDERR)
    end

    it "should raise an unregistered adapter" do
      expect {
        Yell::Adapters.new :unknown
      }.to raise_error(Yell::AdapterNotFound)
    end
  end

  context ".register" do
    let(:name) { :test }
    let(:klass) { mock }

    before { Yell::Adapters.register(name, klass) }

    it "should allow to being called from :new" do
      mock(klass).new(anything)

      Yell::Adapters.new(name)
    end
  end

end
