require 'spec_helper'

describe Ethon::Easy::Form do
  let(:hash) { {} }
  let!(:easy) { Ethon::Easy.new }
  let(:form) { Ethon::Easy::Form.new(easy, hash) }

  describe ".new" do
    it "assigns attribute to @params" do
      expect(form.instance_variable_get(:@params)).to eq(hash)
    end
  end

  describe "#first" do
    it "returns a pointer" do
      expect(form.first).to be_a(FFI::Pointer)
    end
  end

  describe "#last" do
    it "returns a pointer" do
      expect(form.first).to be_a(FFI::Pointer)
    end
  end

  describe "#multipart?" do
    before { form.instance_variable_set(:@query_pairs, pairs) }

    context "when query_pairs contains string values" do
      let(:pairs) { [['a', '1'], ['b', '2']] }

      it "returns false" do
        expect(form.multipart?).to be_false
      end
    end

    context "when query_pairs contains file" do
      let(:pairs) { [['a', '1'], ['b', ['path', 'encoding', 'abs_path']]] }

      it "returns true" do
        expect(form.multipart?).to be_true
      end
    end
  end

  describe "#materialize" do
    before { form.instance_variable_set(:@query_pairs, pairs) }

    context "when query_pairs contains string values" do
      let(:pairs) { [['a', '1']] }

      it "adds params to form" do
        Ethon::Curl.should_receive(:formadd)
        form.materialize
      end
    end

    context "when query_pairs contains nil" do
      let(:pairs) { [['a', nil]] }

      it "adds params to form" do
        Ethon::Curl.should_receive(:formadd)
        form.materialize
      end
    end

    context "when query_pairs contains file" do
      let(:pairs) { [['a', ["file", "type", "path/file"]]] }

      it "adds file to form" do
        Ethon::Curl.should_receive(:formadd)
        form.materialize
      end
    end
  end
end
