require 'spec_helper'

describe Yell::Level do

  context "default" do
    let(:level) { Yell::Level.new }

    it "should should return correctly" do
      expect(level.at?(:debug)).to be_true
      expect(level.at?(:info)).to be_true
      expect(level.at?(:warn)).to be_true
      expect(level.at?(:error)).to be_true
      expect(level.at?(:fatal)).to be_true
    end
  end

  context "given a Symbol" do
    let(:level) { Yell::Level.new(severity) }

    context ":debug" do
      let(:severity) { :debug }

      it "should should return correctly" do
        expect(level.at?(:debug)).to be_true
        expect(level.at?(:info)).to be_true
        expect(level.at?(:warn)).to be_true
        expect(level.at?(:error)).to be_true
        expect(level.at?(:fatal)).to be_true
      end
    end

    context ":info" do
      let(:severity) { :info }

      it "should should return correctly" do
        expect(level.at?(:debug)).to be_false
        expect(level.at?(:info)).to be_true
        expect(level.at?(:warn)).to be_true
        expect(level.at?(:error)).to be_true
        expect(level.at?(:fatal)).to be_true
      end
    end

    context ":warn" do
      let(:severity) { :warn }

      it "should should return correctly" do
        expect(level.at?(:debug)).to be_false
        expect(level.at?(:info)).to be_false
        expect(level.at?(:warn)).to be_true
        expect(level.at?(:error)).to be_true
        expect(level.at?(:fatal)).to be_true
      end
    end

    context ":error" do
      let(:severity) { :error }

      it "should should return correctly" do
        expect(level.at?(:debug)).to be_false
        expect(level.at?(:info)).to be_false
        expect(level.at?(:warn)).to be_false
        expect(level.at?(:error)).to be_true
        expect(level.at?(:fatal)).to be_true
      end
    end

    context ":fatal" do
      let(:severity) { :fatal }

      it "should should return correctly" do
        expect(level.at?(:debug)).to be_false
        expect(level.at?(:info)).to be_false
        expect(level.at?(:warn)).to be_false
        expect(level.at?(:error)).to be_false
        expect(level.at?(:fatal)).to be_true
      end
    end
  end

  context "given a String" do
    let(:level) { Yell::Level.new(severity) }

    context "basic string" do
      let(:severity) { 'error' }

      it "should should return correctly" do
        expect(level.at?(:debug)).to be_false
        expect(level.at?(:info)).to be_false
        expect(level.at?(:warn)).to be_false
        expect(level.at?(:error)).to be_true
        expect(level.at?(:fatal)).to be_true
      end
    end

    context "complex string with outer boundaries" do
      let(:severity) { 'gte.info lte.error' }

      it "should should return correctly" do
        expect(level.at?(:debug)).to be_false
        expect(level.at?(:info)).to be_true
        expect(level.at?(:warn)).to be_true
        expect(level.at?(:error)).to be_true
        expect(level.at?(:fatal)).to be_false
      end
    end

    context "complex string with inner boundaries" do
      let(:severity) { 'gt.info lt.error' }

      it "should be valid" do
        expect(level.at?(:debug)).to be_false
        expect(level.at?(:info)).to be_false
        expect(level.at?(:warn)).to be_true
        expect(level.at?(:error)).to be_false
        expect(level.at?(:fatal)).to be_false
      end
    end

    context "complex string with precise boundaries" do
      let(:severity) { 'at.info at.error' }

      it "should be valid" do
        expect(level.at?(:debug)).to be_false
        expect(level.at?(:info)).to be_true
        expect(level.at?(:warn)).to be_false
        expect(level.at?(:error)).to be_true
        expect(level.at?(:fatal)).to be_false
      end
    end

    context "complex string with combined boundaries" do
      let(:severity) { 'gte.error at.debug' }

      it "should be valid" do
        expect(level.at?(:debug)).to be_true
        expect(level.at?(:info)).to be_false
        expect(level.at?(:warn)).to be_false
        expect(level.at?(:error)).to be_true
        expect(level.at?(:fatal)).to be_true
      end
    end
  end

  context "given an Array" do
    let(:level) { Yell::Level.new( [:debug, :warn, :fatal] ) }

    it "should return correctly" do
      expect(level.at?(:debug)).to be_true
      expect(level.at?(:info)).to be_false
      expect(level.at?(:warn)).to be_true
      expect(level.at?(:error)).to be_false
      expect(level.at?(:fatal)).to be_true
    end
  end

  context "given a Range" do
    let(:level) { Yell::Level.new( (1..3) ) }

    it "should return correctly" do
      expect(level.at?(:debug)).to be_false
      expect(level.at?(:info)).to be_true
      expect(level.at?(:warn)).to be_true
      expect(level.at?(:error)).to be_true
      expect(level.at?(:fatal)).to be_false
    end
  end

  context "given a Yell::Level instance" do
    let(:level) { Yell::Level.new(:warn) }

    it "should return correctly" do
      expect(level.at?(:debug)).to be_false
      expect(level.at?(:info)).to be_false
      expect(level.at?(:warn)).to be_true
      expect(level.at?(:error)).to be_true
      expect(level.at?(:fatal)).to be_true
    end
  end

  context "backwards compatibility" do
    let(:level) { Yell::Level.new :warn }

    it "should return correctly to :to_i" do
      expect(level.to_i).to eq(2)
    end

    it "should typecast with Integer correctly" do
      expect(Integer(level)).to eq(2)
    end

    it "should be compatible when passing to array (https://github.com/rudionrails/yell/issues/1)" do
      severities = %w(FINE INFO WARNING SEVERE SEVERE INFO)

      expect(severities[level]).to eq("WARNING")
    end
  end

end

