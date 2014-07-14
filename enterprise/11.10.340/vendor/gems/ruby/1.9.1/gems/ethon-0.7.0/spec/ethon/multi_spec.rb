require 'spec_helper'

describe Ethon::Multi do
  describe ".new" do
    it "inits curl" do
      Ethon::Curl.should_receive(:init)
      Ethon::Multi.new
    end

    context "when options not empty" do
      context "when pipelining is set" do
        let(:options) { { :pipelining => true } }

        it "sets pipelining" do
          Ethon::Multi.any_instance.should_receive(:pipelining=).with(true)
          Ethon::Multi.new(options)
        end
      end
    end
  end
end
