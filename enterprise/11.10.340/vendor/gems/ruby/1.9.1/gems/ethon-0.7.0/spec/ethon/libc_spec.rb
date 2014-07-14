require 'spec_helper'

describe Ethon::Libc do
  describe "#getdtablesize" do
    it "returns an integer" do
      expect(Ethon::Libc.getdtablesize).to be_a(Integer)
    end

    it "returns bigger zero" do
      expect(Ethon::Libc.getdtablesize).to_not be_zero
    end
  end
end
