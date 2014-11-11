require 'spec_helper'

describe Yell::Silencer do

  context "initialize with #patterns" do
    subject { Yell::Silencer.new(/this/) }

    its(:patterns) { should eq([/this/]) }
  end

  context "#add" do
    let(:silencer) { Yell::Silencer.new }

    it "should add patterns" do
      silencer.add /this/, /that/

      expect(silencer.patterns).to eq([/this/, /that/])
    end

    it "should ignore duplicate patterns" do
      silencer.add /this/, /that/, /this/

      expect(silencer.patterns).to eq([/this/, /that/])
    end
  end

  context "#call" do
    let(:silencer) { Yell::Silencer.new(/this/) }

    it "should reject messages that match any pattern" do
      expect(silencer.call("this")).to eq([])
      expect(silencer.call("that")).to eq(["that"])
      expect(silencer.call("this", "that")).to eq(["that"])
    end
  end

end

