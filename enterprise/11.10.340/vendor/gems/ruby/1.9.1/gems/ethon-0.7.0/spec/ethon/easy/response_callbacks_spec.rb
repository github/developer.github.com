require 'spec_helper'

describe Ethon::Easy::ResponseCallbacks do
  let(:easy) { Ethon::Easy.new }

  [:on_complete, :on_headers, :on_body].each do |callback_type|
    describe "##{callback_type}" do
      it "responds" do
        expect(easy).to respond_to("#{callback_type}")
      end

      context "when no block given" do
        it "returns @#{callback_type}" do
          expect(easy.send("#{callback_type}")).to eq([])
        end
      end

      context "when block given" do
        it "stores" do
          easy.send(callback_type) { p 1 }
          expect(easy.instance_variable_get("@#{callback_type}")).to have(1).items
        end
      end

      context "when multiple blocks given" do
        it "stores" do
          easy.send(callback_type) { p 1 }
          easy.send(callback_type) { p 2 }
          expect(easy.instance_variable_get("@#{callback_type}")).to have(2).items
        end
      end
    end
  end

  describe "#complete" do
    before do
      easy.on_complete {|r| String.new(r.url) }
    end

    it "executes blocks and passes self" do
      String.should_receive(:new).with(easy.url)
      easy.complete
    end

    context "when @on_complete nil" do
      it "doesn't raise" do
        easy.instance_variable_set(:@on_complete, nil)
        expect{ easy.complete }.to_not raise_error(NoMethodError)
      end
    end
  end

  describe "#headers" do
    before do
      easy.on_headers {|r| String.new(r.url) }
    end

    it "executes blocks and passes self" do
      String.should_receive(:new).with(easy.url)
      easy.headers
    end

    context "when @on_headers nil" do
      it "doesn't raise" do
        easy.instance_variable_set(:@on_headers, nil)
        expect{ easy.headers }.to_not raise_error(NoMethodError)
      end
    end
  end

  describe "#body" do
    before do
      @chunk = nil
      @r = nil
      easy.on_body { |chunk, r| @chunk = chunk ; @r = r }
    end

    it "executes blocks and passes self" do
      easy.body("the chunk")
      expect(@r).to be(easy)
    end

    it "executes blocks and passes chunk" do
      easy.body("the chunk")
      expect(@chunk).to eq("the chunk")
    end

    context "when @on_body nil" do
      it "doesn't raise" do
        easy.instance_variable_set(:@on_body, nil)
        expect{ easy.body("the chunk") }.to_not raise_error(NoMethodError)
      end
    end
  end
end
