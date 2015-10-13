# encoding: utf-8

class Cri::BasicHelpTestCase < Cri::TestCase

  def test_run_without_supercommand
    cmd = Cri::Command.new_basic_help

    assert_raises Cri::NoHelpAvailableError do
      cmd.run([])
    end
  end

  def test_run_with_supercommand
    cmd = Cri::Command.define do
      name 'meh'
    end

    help_cmd = Cri::Command.new_basic_help
    cmd.add_command(help_cmd)

    help_cmd.run([])
  end

  def test_run_with_chain_of_commands
    cmd = Cri::Command.define do
      name 'root'
      summary 'I am root!'

      subcommand do
        name 'foo'
        summary 'I am foo!'

        subcommand do
          name 'subsubby'
          summary 'I am subsubby!'
        end
      end
    end

    help_cmd = Cri::Command.new_basic_help
    cmd.add_command(help_cmd)

    # Simple call
    stdout, stderr = capture_io_while do
      help_cmd.run([ 'foo' ])
    end
    assert_match(/I am foo!/m, stdout)
    assert_equal('', stderr)

    # Subcommand
    stdout, stderr = capture_io_while do
      help_cmd.run([ 'foo', 'subsubby' ])
    end
    assert_match(/I am subsubby!/m, stdout)
    assert_equal('', stderr)

    # Non-existing subcommand
    stdout, stderr = capture_io_while do
      assert_raises SystemExit do
        help_cmd.run([ 'foo', 'mysterycmd' ])
      end
    end
    assert_equal '', stdout
    assert_match(/foo: unknown command 'mysterycmd'/, stderr)
  end

end
