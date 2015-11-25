require 'spec_helper'

class LoggableFactory
  include Yell::Loggable
end

describe Yell::Loggable do
  let(:factory) { LoggableFactory.new }
  subject { factory }

  it { should respond_to(:logger) }

  it "should make a lookup in the Yell::Repository" do
    mock(Yell::Repository)[LoggableFactory]

    factory.logger
  end

end

