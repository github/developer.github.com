require 'spec_helper'

describe Ethon::Curl do
  describe ".init" do
    before { Ethon::Curl.send(:class_variable_set, :@@initialized, false) }

    context "when global_init fails" do
      it "raises global init error" do
        Ethon::Curl.should_receive(:global_init).and_return(1)
        expect{ Ethon::Curl.init }.to raise_error(Ethon::Errors::GlobalInit)
      end
    end

    context "when global_init works" do
      before { Ethon::Curl.should_receive(:global_init).and_return(0) }

      it "doesn't raises global init error" do
        expect{ Ethon::Curl.init }.to_not raise_error(Ethon::Errors::GlobalInit)
      end

      it "logs" do
        Ethon.logger.should_receive(:debug)
        Ethon::Curl.init
      end
    end
  end
end
