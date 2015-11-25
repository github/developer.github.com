require 'spec_helper'

describe Yell::Configuration do

  describe ".load!" do
    let(:file) { fixture_path + '/yell.yml' }
    let(:config) { Yell::Configuration.load!(file) }

    subject { config }

    it { should be_kind_of(Hash) }
    it { should have_key(:level) }
    it { should have_key(:adapters) }

    context ":level" do
      subject { config[:level] }

      it { should eq("info") }
    end

    context ":adapters" do
      subject { config[:adapters] }

      it { should be_kind_of(Array) }

      # stdout
      it { expect(subject.first).to eq(:stdout) }

      # stderr
      it { expect(subject.last).to be_kind_of(Hash) }
      it { expect(subject.last).to eq(:stderr => {:level => 'gte.error'}) }
    end
  end

end

