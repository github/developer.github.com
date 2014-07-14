require 'spec_helper'

describe Yell::Repository do
  let(:name) { 'test' }
  let(:logger) { Yell.new(:stdout) }

  subject { Yell::Repository[name] }

  context ".[]" do
    it "should raise when not set" do
      expect { subject }.to raise_error(Yell::LoggerNotFound)
    end

    context "when logger with :name exists" do
      let!(:logger) { Yell.new(:stdout, :name => name) }

      it { should eq(logger) }
    end

    context "given a Class" do
      let!(:logger) { Yell.new(:stdout, :name => "Numeric") }

      it "should raise with the correct :name when logger not found" do
        mock.proxy(Yell::LoggerNotFound).new(String)
        lambda { Yell::Repository[String] }.should raise_error(Yell::LoggerNotFound)
      end

      it "should return the logger" do
        Yell::Repository[Numeric].should eq(logger)
      end

      it "should return the logger when superclass has it defined" do
        Yell::Repository[Integer].should eq(logger)
      end
    end
  end

  context ".[]=" do
    before { Yell::Repository[name] = logger }
    it { should eq(logger) }
  end

  context ".[]= with a named logger" do
    let!(:logger) { Yell.new(:stdout, :name => name) }
    before { Yell::Repository[name] = logger }

    it { should eq(logger) }
  end

  context ".[]= with a named logger of a different name" do
    let(:other) { 'other' }
    let(:logger) { Yell.new(:stdout, :name => other) }
    before { Yell::Repository[name] = logger }

    it "should add logger to both repositories" do
      Yell::Repository[name].should eq(logger)
      Yell::Repository[other].should eq(logger)
    end
  end

  context "loggers" do
    let(:loggers) { { name => logger } }
    subject { Yell::Repository.loggers }
    before { Yell::Repository[name] = logger }

    it { should eq(loggers) }
  end

end

