# encoding: utf-8

class Cri::CommandRunnerTestCase < Cri::TestCase

  def setup
    super

    @options   = { :vehicle => 'pig' }
    @arguments = %w( baby_monkey )
    @command   = Cri::Command.new
  end

  def test_initialize

    runner = Cri::CommandRunner.new(@options, @arguments, @command)

    assert_equal @options,   runner.options
    assert_equal @arguments, runner.arguments
    assert_equal @command,   runner.command
  end

  def test_call_run
    assert_raises(Cri::NotImplementedError) do
      Cri::CommandRunner.new(@options, @arguments, @command).call
    end

    assert_raises(Cri::NotImplementedError) do
      Cri::CommandRunner.new(@options, @arguments, @command).run
    end
  end

end
