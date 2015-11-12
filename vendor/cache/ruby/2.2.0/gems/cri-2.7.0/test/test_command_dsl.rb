# encoding: utf-8

module Cri
  class CommandDSLTestCase < Cri::TestCase
    def test_create_command
      # Define
      dsl = Cri::CommandDSL.new
      dsl.instance_eval do
        name        'moo'
        usage       'dunno whatever'
        summary     'does stuff'
        description 'This command does a lot of stuff.'

        option    :a, :aaa, 'opt a', :argument => :optional, :multiple => true
        required  :b, :bbb, 'opt b'
        optional  :c, :ccc, 'opt c'
        flag      :d, :ddd, 'opt d'
        forbidden :e, :eee, 'opt e'
        flag      :f, :fff, 'opt f', :hidden => true

        run do |_opts, _args|
          $did_it_work = :probably
        end
      end
      command = dsl.command

      # Run
      $did_it_work = :sadly_not
      command.run(%w( -a x -b y -c -d -e ))
      assert_equal :probably, $did_it_work

      # Check
      assert_equal 'moo', command.name
      assert_equal 'dunno whatever', command.usage
      assert_equal 'does stuff', command.summary
      assert_equal 'This command does a lot of stuff.', command.description

      # Check options
      expected_option_definitions = Set.new([
        { :short => 'a', :long => 'aaa', :desc => 'opt a', :argument => :optional,  :multiple => true,  :hidden => false, :block => nil },
        { :short => 'b', :long => 'bbb', :desc => 'opt b', :argument => :required,  :multiple => false, :hidden => false, :block => nil },
        { :short => 'c', :long => 'ccc', :desc => 'opt c', :argument => :optional,  :multiple => false, :hidden => false, :block => nil },
        { :short => 'd', :long => 'ddd', :desc => 'opt d', :argument => :forbidden, :multiple => false, :hidden => false, :block => nil },
        { :short => 'e', :long => 'eee', :desc => 'opt e', :argument => :forbidden, :multiple => false, :hidden => false, :block => nil },
        { :short => 'f', :long => 'fff', :desc => 'opt f', :argument => :forbidden, :multiple => false, :hidden => true,  :block => nil },
      ])
      actual_option_definitions = Set.new(command.option_definitions)
      assert_equal expected_option_definitions, actual_option_definitions
    end

    def test_optional_options
      # Define
      dsl = Cri::CommandDSL.new
      dsl.instance_eval do
        name        'moo'
        usage       'dunno whatever'
        summary     'does stuff'
        description 'This command does a lot of stuff.'

        flag :s,  nil,   'short'
        flag nil, :long, 'long'

        run do |_opts, _args|
          $did_it_work = :probably
        end
      end
      command = dsl.command

      # Run
      $did_it_work = :sadly_not
      command.run(%w( -s --long ))
      assert_equal :probably, $did_it_work

      # Check options
      expected_option_definitions = Set.new([
        { :short => 's', :long => nil,    :desc => 'short', :argument => :forbidden, :multiple => false, :hidden => false, :block => nil },
        { :short => nil, :long => 'long', :desc => 'long',  :argument => :forbidden, :multiple => false, :hidden => false, :block => nil },
      ])
      actual_option_definitions = Set.new(command.option_definitions)
      assert_equal expected_option_definitions, actual_option_definitions
    end

    def test_multiple
      # Define
      dsl = Cri::CommandDSL.new
      dsl.instance_eval do
        flag     :f, :flag,     'flag', :multiple => true
        required :r, :required, 'req',  :multiple => true
        optional :o, :optional, 'opt',  :multiple => true

        run { |_opts, _args| }
      end
      command = dsl.command

      # Check options
      expected_option_definitions = Set.new([
        { :short => 'f', :long => 'flag',     :desc => 'flag', :argument => :forbidden, :multiple => true, :hidden => false, :block => nil },
        { :short => 'r', :long => 'required', :desc => 'req',  :argument => :required,  :multiple => true, :hidden => false, :block => nil },
        { :short => 'o', :long => 'optional', :desc => 'opt',  :argument => :optional,  :multiple => true, :hidden => false, :block => nil },
      ])
      actual_option_definitions = Set.new(command.option_definitions)
      assert_equal expected_option_definitions, actual_option_definitions
    end

    def test_hidden
      # Define
      dsl = Cri::CommandDSL.new
      dsl.instance_eval do
        flag     :f, :flag,     'flag', :hidden => true
        required :r, :required, 'req',  :hidden => true
        optional :o, :optional, 'opt',  :hidden => true

        run { |_opts, _args| }
      end
      command = dsl.command

      # Check options
      expected_option_definitions = Set.new([
        { :short => 'f', :long => 'flag',     :desc => 'flag', :argument => :forbidden, :multiple => false, :hidden => true, :block => nil },
        { :short => 'r', :long => 'required', :desc => 'req',  :argument => :required,  :multiple => false, :hidden => true, :block => nil },
        { :short => 'o', :long => 'optional', :desc => 'opt',  :argument => :optional,  :multiple => false, :hidden => true, :block => nil },
      ])
      actual_option_definitions = Set.new(command.option_definitions)
      assert_equal expected_option_definitions, actual_option_definitions
    end

    def test_required_short_and_long
      # Define
      dsl = Cri::CommandDSL.new
      assert_raises ArgumentError do
        dsl.instance_eval do
          option nil, nil, 'meh'
        end
      end
      assert_raises ArgumentError do
        dsl.instance_eval do
          flag nil, nil, 'meh'
        end
      end
      assert_raises ArgumentError do
        dsl.instance_eval do
          required nil, nil, 'meh'
        end
      end
      assert_raises ArgumentError do
        dsl.instance_eval do
          optional nil, nil, 'meh'
        end
      end
    end

    def test_subcommand
      # Define
      dsl = Cri::CommandDSL.new
      dsl.instance_eval do
        name 'super'
        subcommand do |c|
          c.name 'sub'
        end
      end
      command = dsl.command

      # Check
      assert_equal 'super', command.name
      assert_equal 1,       command.subcommands.size
      assert_equal 'sub',   command.subcommands.to_a[0].name
    end

    def test_aliases
      # Define
      dsl = Cri::CommandDSL.new
      dsl.instance_eval do
        aliases :moo, :aah
      end
      command = dsl.command

      # Check
      assert_equal %w( aah moo ), command.aliases.sort
    end

    def test_run_arity
      dsl = Cri::CommandDSL.new
      assert_raises ArgumentError do
        dsl.instance_eval do
          run do |_a, _b, _c, _d, _e|
          end
        end
      end
    end

    def test_runner
      # Define
      dsl = Cri::CommandDSL.new
      dsl.instance_eval <<-EOS
        class Cri::CommandDSLTestCaseCommandRunner < Cri::CommandRunner
          def run
            $did_it_work = arguments[0]
          end
        end

        runner Cri::CommandDSLTestCaseCommandRunner
  EOS
      command = dsl.command

      # Check
      $did_it_work = false
      command.run(%w( certainly ))
      assert_equal 'certainly', $did_it_work
    end
  end
end
