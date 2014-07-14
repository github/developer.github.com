# encoding: utf-8

require 'coveralls'
Coveralls.wear!

require 'minitest'
require 'minitest/autorun'

require 'cri'

require 'stringio'

class Cri::TestCase < Minitest::Test

  def setup
    @orig_io = capture_io
  end

  def teardown
    uncapture_io(*@orig_io)
  end

  def capture_io_while(&block)
    orig_io = capture_io
    block.call
    [ $stdout.string, $stderr.string ]
  ensure
    uncapture_io(*orig_io)
  end

  def lines(string)
    string.scan(/^.*\n/).map { |s| s.chomp }
  end

private

  def capture_io
    orig_stdout = $stdout
    orig_stderr = $stderr

    $stdout = StringIO.new
    $stderr = StringIO.new

    [ orig_stdout, orig_stderr ]
  end

  def uncapture_io(orig_stdout, orig_stderr)
    $stdout = orig_stdout
    $stderr = orig_stderr
  end

end

# Unexpected system exit is unexpected
::MiniTest::Unit::TestCase::PASSTHROUGH_EXCEPTIONS.delete(SystemExit)
