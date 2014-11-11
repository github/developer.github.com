require 'spec_helper'

describe Ethon::Easy::Mirror do
  let(:options) { nil }
  let(:mirror) { described_class.new(options) }

  describe ".informations_to_mirror" do
    [
      :return_code, :response_code, :response_body, :response_headers,
      :total_time, :starttransfer_time, :appconnect_time,
      :pretransfer_time, :connect_time, :namelookup_time,
      :effective_url, :primary_ip, :redirect_count, :debug_info
    ].each do |name|
      it "contains #{name}" do
        expect(described_class.informations_to_mirror).to include(name)
      end
    end
  end

  describe "#to_hash" do
    let(:options) { {:return_code => 1} }

    it "returns mirror as hash" do
      expect(mirror.to_hash).to eq(options)
    end
  end

  describe "#log_informations" do
    let(:options) { {:return_code => 1} }

    it "returns hash" do
      expect(mirror.log_informations).to be_a(Hash)
    end

    it "includes return code" do
      expect(mirror.log_informations).to include(options)
    end
  end
end
