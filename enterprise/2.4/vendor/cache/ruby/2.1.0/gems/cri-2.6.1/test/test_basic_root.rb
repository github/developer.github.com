# encoding: utf-8

class Cri::BasicRootTestCase < Cri::TestCase

  def test_run_with_help
    cmd = Cri::Command.new_basic_root

    stdout, stderr = capture_io_while do
      assert_raises SystemExit do
        cmd.run(%w( -h ))
      end
    end

    assert stdout =~ /COMMANDS.*\n.*help.*show help/
  end

end
