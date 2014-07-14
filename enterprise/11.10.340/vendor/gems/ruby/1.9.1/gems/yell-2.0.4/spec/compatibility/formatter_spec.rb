require 'spec_helper'
require 'logger'

describe "backwards compatible formatter" do

  let(:time) { Time.now }
  let(:formatter) { Yell::Formatter.new(Yell::DefaultFormat) }
  let(:logger) { Logger.new($stdout) }

  before do
    Timecop.freeze(time)

    logger.formatter = formatter
  end

  it "should format out the message correctly" do
    mock($stdout).write("#{time.iso8601} [ INFO] #{$$} : Hello World!\n")

    logger.info "Hello World!"
  end

end

