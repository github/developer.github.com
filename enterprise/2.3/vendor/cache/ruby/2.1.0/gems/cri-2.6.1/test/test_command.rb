# encoding: utf-8

class Cri::CommandTestCase < Cri::TestCase

  def simple_cmd
    Cri::Command.define do
      name        'moo'
      usage       'moo [options] arg1 arg2 ...'
      summary     'does stuff'
      description 'This command does a lot of stuff.'

      option    :a, :aaa, 'opt a', :argument => :optional do |value, cmd|
        $stdout.puts "#{cmd.name}:#{value}"
      end
      required  :b, :bbb, 'opt b'
      optional  :c, :ccc, 'opt c'
      flag      :d, :ddd, 'opt d'
      forbidden :e, :eee, 'opt e'

      run do |opts, args, c|
        $stdout.puts "Awesome #{c.name}!"

        $stdout.puts args.join(',')

        opts_strings = []
        opts.each_pair { |k,v| opts_strings << "#{k}=#{v}" }
        $stdout.puts opts_strings.sort.join(',')
      end
    end
  end

  def bare_cmd
    Cri::Command.define do
      name        'moo'

      run do |opts, args|
      end
    end
  end

  def nested_cmd
    super_cmd = Cri::Command.define do
      name        'super'
      usage       'super [command] [options] [arguments]'
      summary     'does super stuff'
      description 'This command does super stuff.'

      option    :a, :aaa, 'opt a', :argument => :optional do |value, cmd|
        $stdout.puts "#{cmd.name}:#{value}"
      end
      required  :b, :bbb, 'opt b'
      optional  :c, :ccc, 'opt c'
      flag      :d, :ddd, 'opt d'
      forbidden :e, :eee, 'opt e'
    end

    super_cmd.define_command do
      name        'sub'
      aliases     'sup'
      usage       'sub [options]'
      summary     'does subby stuff'
      description 'This command does subby stuff.'

      option    :m, :mmm, 'opt m', :argument => :optional
      required  :n, :nnn, 'opt n'
      optional  :o, :ooo, 'opt o'
      flag      :p, :ppp, 'opt p'
      forbidden :q, :qqq, 'opt q'

      run do |opts, args|
        $stdout.puts "Sub-awesome!"

        $stdout.puts args.join(',')

        opts_strings = []
        opts.each_pair { |k,v| opts_strings << "#{k}=#{v}" }
        $stdout.puts opts_strings.join(',')
      end
    end

    super_cmd.define_command do
      name        'sink'
      usage       'sink thing_to_sink'
      summary     'sinks stuff'
      description 'Sinks stuff (like ships and the like).'

      run do |opts, args|
      end
    end

    super_cmd
  end

  def nested_cmd_with_run_block
    super_cmd = Cri::Command.define do
      name        'super'
      usage       'super [command] [options] [arguments]'
      summary     'does super stuff'
      description 'This command does super stuff.'

      run do |opts, args|
        $stdout.puts "super"
      end
    end

    super_cmd.define_command do
      name        'sub'
      aliases     'sup'
      usage       'sub [options]'
      summary     'does subby stuff'
      description 'This command does subby stuff.'

      run do |opts, args|
        $stdout.puts "sub"
      end
    end

    super_cmd
  end

  def test_invoke_simple_without_opts_or_args
    out, err = capture_io_while do
      simple_cmd.run(%w())
    end

    assert_equal [ 'Awesome moo!', '', '' ], lines(out)
    assert_equal [], lines(err)
  end

  def test_invoke_simple_with_args
    out, err = capture_io_while do
      simple_cmd.run(%w(abc xyz))
    end

    assert_equal [ 'Awesome moo!', 'abc,xyz', '' ], lines(out)
    assert_equal [], lines(err)
  end

  def test_invoke_simple_with_opts
    out, err = capture_io_while do
      simple_cmd.run(%w(-c -b x))
    end

    assert_equal [ 'Awesome moo!', '', 'bbb=x,ccc=true' ], lines(out)
    assert_equal [], lines(err)
  end

  def test_invoke_simple_with_missing_opt_arg
    out, err = capture_io_while do
      assert_raises SystemExit do
        simple_cmd.run(%w( -b ))
      end
    end

    assert_equal [], lines(out)
    assert_equal [ "moo: option requires an argument -- b" ], lines(err)
  end

  def test_invoke_simple_with_illegal_opt
    out, err = capture_io_while do
      assert_raises SystemExit do
        simple_cmd.run(%w( -z ))
      end
    end

    assert_equal [], lines(out)
    assert_equal [ "moo: illegal option -- z" ], lines(err)
  end

  def test_invoke_simple_with_opt_with_block
    out, err = capture_io_while do
      simple_cmd.run(%w( -a 123 ))
    end

    assert_equal [ 'moo:123', 'Awesome moo!', '', 'aaa=123' ], lines(out)
    assert_equal [], lines(err)
  end

  def test_invoke_nested_without_opts_or_args
    out, err = capture_io_while do
      assert_raises SystemExit do
        nested_cmd.run(%w())
      end
    end

    assert_equal [ ], lines(out)
    assert_equal [ 'super: no command given' ], lines(err)
  end

  def test_invoke_nested_with_correct_command_name
    out, err = capture_io_while do
      nested_cmd.run(%w( sub ))
    end

    assert_equal [ 'Sub-awesome!', '', '' ], lines(out)
    assert_equal [ ], lines(err)
  end

  def test_invoke_nested_with_incorrect_command_name
    out, err = capture_io_while do
      assert_raises SystemExit do
        nested_cmd.run(%w( oogabooga ))
      end
    end

    assert_equal [ ], lines(out)
    assert_equal [ "super: unknown command 'oogabooga'" ], lines(err)
  end

  def test_invoke_nested_with_ambiguous_command_name
    out, err = capture_io_while do
      assert_raises SystemExit do
        nested_cmd.run(%w( s ))
      end
    end

    assert_equal [ ], lines(out)
    assert_equal [ "super: 's' is ambiguous:", "  sink sub" ], lines(err)
  end

  def test_invoke_nested_with_alias
    out, err = capture_io_while do
      nested_cmd.run(%w( sup ))
    end

    assert_equal [ 'Sub-awesome!', '', '' ], lines(out)
    assert_equal [ ], lines(err)
  end

  def test_invoke_nested_with_options_before_command
    out, err = capture_io_while do
      nested_cmd.run(%w( -a 666 sub ))
    end

    assert_equal [ 'super:666', 'Sub-awesome!', '', 'aaa=666' ], lines(out)
    assert_equal [ ], lines(err)
  end

  def test_invoke_nested_with_run_block
    out, err = capture_io_while do
      nested_cmd_with_run_block.run(%w())
    end

    assert_equal [ 'super' ], lines(out)
    assert_equal [ ], lines(err)

    out, err = capture_io_while do
      nested_cmd_with_run_block.run(%w( sub ))
    end

    assert_equal [ 'sub' ], lines(out)
    assert_equal [ ], lines(err)
  end

  def test_help_nested
    def $stdout.tty? ; true ; end

    help = nested_cmd.subcommands.find { |cmd| cmd.name == 'sub' }.help

    assert help.include?("USAGE\e[0m\e[0m\n    \e[32msuper\e[0m \e[32msub\e[0m [options]\n")
  end

  def test_help_with_and_without_colors
    def $stdout.tty? ; true ; end
    help_on_tty = simple_cmd.help
    def $stdout.tty? ; false ; end
    help_not_on_tty = simple_cmd.help

    assert_includes help_on_tty,     "\e[31mUSAGE\e[0m\e[0m\n    \e[32mmoo"
    assert_includes help_not_on_tty, "USAGE\n    moo"
  end

  def test_help_for_bare_cmd
    bare_cmd.help
  end

  def test_help_with_optional_options
    def $stdout.tty? ; true ; end

    cmd = Cri::Command.define do
      name 'build'
      flag :s,  nil,   'short'
      flag nil, :long, 'long'
    end
    help = cmd.help

    assert_match(/--long.*-s/m,                           help)
    assert_match(/^\e\[33m       --long    \e\[0mlong$/,  help)
    assert_match(/^\e\[33m    -s           \e\[0mshort$/, help)
  end

  def test_help_with_multiple_groups
    help = nested_cmd.subcommands.find { |cmd| cmd.name == 'sub' }.help

    assert_match(/OPTIONS.*OPTIONS FOR SUPER/m,  help)
  end

  def test_modify_with_block_argument
    cmd = Cri::Command.define do |c|
      c.name 'build'
    end
    assert_equal 'build', cmd.name

    cmd.modify do |c|
      c.name 'compile'
    end

    assert_equal 'compile', cmd.name
  end

  def test_modify_without_block_argument
    cmd = Cri::Command.define do
      name 'build'
    end
    assert_equal 'build', cmd.name

    cmd.modify do
      name 'compile'
    end

    assert_equal 'compile', cmd.name
  end

  def test_new_basic_root
    cmd = Cri::Command.new_basic_root.modify do
      name 'mytool'
    end

    # Check option definitions
    assert_equal 1, cmd.option_definitions.size
    opt_def = cmd.option_definitions.to_a[0]
    assert_equal 'help', opt_def[:long]

    # Check subcommand
    assert_equal 1,      cmd.subcommands.size
    assert_equal 'help', cmd.subcommands.to_a[0].name
  end

  def test_define_with_block_argument
    cmd = Cri::Command.define do |c|
      c.name 'moo'
    end

    assert_equal 'moo', cmd.name
  end

  def test_define_without_block_argument
    cmd = Cri::Command.define do
      name 'moo'
    end

    assert_equal 'moo', cmd.name
  end

  def test_define_subcommand_with_block_argument
    cmd = bare_cmd
    cmd.define_command do |c|
      c.name 'baresub'
    end

    assert_equal 'baresub', cmd.subcommands.to_a[0].name
  end

  def test_define_subcommand_without_block_argument
    cmd = bare_cmd
    cmd.define_command do
      name 'baresub'
    end

    assert_equal 'baresub', cmd.subcommands.to_a[0].name
  end

  def test_backtrace_includes_filename
    error = assert_raises RuntimeError do
      Cri::Command.define('raise "boom"', 'mycommand.rb')
    end

    assert_match /mycommand.rb/, error.backtrace.join("\n")
  end

  def test_hidden_commands_single
    cmd    = nested_cmd
    subcmd = simple_cmd
    cmd.add_command subcmd
    subcmd.modify do |c|
      c.name    'old-and-deprecated'
      c.summary 'does stuff the ancient, totally deprecated way'
      c.be_hidden
    end

    refute cmd.help.include?('hidden commands omitted')
    assert cmd.help.include?('hidden command omitted')
    refute cmd.help.include?('old-and-deprecated')

    refute cmd.help(:verbose => true).include?('hidden commands omitted')
    refute cmd.help(:verbose => true).include?('hidden command omitted')
    assert cmd.help(:verbose => true).include?('old-and-deprecated')
  end

  def test_hidden_commands_multiple
    cmd    = nested_cmd

    subcmd = simple_cmd
    cmd.add_command subcmd
    subcmd.modify do |c|
      c.name    'first'
      c.summary 'does stuff first'
    end

    subcmd = simple_cmd
    cmd.add_command subcmd
    subcmd.modify do |c|
      c.name    'old-and-deprecated'
      c.summary 'does stuff the old, deprecated way'
      c.be_hidden
    end

    subcmd = simple_cmd
    cmd.add_command subcmd
    subcmd.modify do |c|
      c.name    'ancient-and-deprecated'
      c.summary 'does stuff the ancient, reallydeprecated way'
      c.be_hidden
    end

    assert cmd.help.include?('hidden commands omitted')
    refute cmd.help.include?('hidden command omitted')
    refute cmd.help.include?('old-and-deprecated')
    refute cmd.help.include?('ancient-and-deprecated')

    refute cmd.help(:verbose => true).include?('hidden commands omitted')
    refute cmd.help(:verbose => true).include?('hidden command omitted')
    assert cmd.help(:verbose => true).include?('old-and-deprecated')
    assert cmd.help(:verbose => true).include?('ancient-and-deprecated')

    pattern = /ancient-and-deprecated.*first.*old-and-deprecated/m
    assert_match(pattern, cmd.help(:verbose => true))
  end

  def test_run_with_raw_args
    cmd = Cri::Command.define do
      name 'moo'
      run do |opts, args|
        puts "args=#{args.join(',')} args.raw=#{args.raw.join(',')}"
      end
    end

    out, err = capture_io_while do
      cmd.run(%w( foo -- bar ))
    end
    assert_equal "args=foo,bar args.raw=foo,--,bar\n", out
  end

  def test_run_without_block
    cmd = Cri::Command.define do
      name 'moo'
    end

    assert_raises(Cri::NotImplementedError) do
      cmd.run([])
    end
  end

  def test_runner_with_raw_args
    cmd = Cri::Command.define do
      name 'moo'
      runner(Class.new(Cri::CommandRunner) do
        def run
          puts "args=#{arguments.join(',')} args.raw=#{arguments.raw.join(',')}"
        end
      end)
    end

    out, err = capture_io_while do
      cmd.run(%w( foo -- bar ))
    end
    assert_equal "args=foo,bar args.raw=foo,--,bar\n", out
  end

  def test_compare
    foo = Cri::Command.define { name 'foo' }
    bar = Cri::Command.define { name 'bar' }
    qux = Cri::Command.define { name 'qux' }

    assert_equal [ bar, foo, qux ], [ foo, bar, qux ].sort
  end

end
