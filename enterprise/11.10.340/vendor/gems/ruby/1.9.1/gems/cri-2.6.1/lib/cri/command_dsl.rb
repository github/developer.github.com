# encoding: utf-8

module Cri

  # The command DSL is a class that is used for building and modifying
  # commands.
  class CommandDSL

    # Creates a new DSL, intended to be used for building a single command. A
    # {CommandDSL} instance is not reusable; create a new instance if you want
    # to build another command.
    #
    # @param [Cri::Command, nil] command The command to modify, or nil if a
    #   new command should be created
    def initialize(command=nil)
      @command = command || Cri::Command.new
    end

    # @return [Cri::Command] The built command
    def command
      @command
    end

    # Adds a subcommand to the current command. The command can either be
    # given explicitly, or a block can be given that defines the command.
    #
    # @param [Cri::Command, nil] command The command to add as a subcommand,
    #   or nil if the block should be used to define the command that will be
    #   added as a subcommand
    #
    # @return [void]
    def subcommand(command=nil, &block)
      if command.nil?
        command = Cri::Command.define(&block)
      end

      @command.add_command(command)
    end

    # Sets the command name.
    #
    # @param [String] arg The new command name
    #
    # @return [void]
    def name(arg)
      @command.name = arg
    end

    # Sets the command aliases.
    #
    # @param [String, Symbol, Array] args The new command aliases
    #
    # @return [void]
    def aliases(*args)
      @command.aliases = args.flatten.map { |a| a.to_s }
    end

    # Sets the command summary.
    #
    # @param [String] arg The new command summary
    #
    # @return [void]
    def summary(arg)
      @command.summary = arg
    end

    # Sets the command description.
    #
    # @param [String] arg The new command description
    #
    # @return [void]
    def description(arg)
      @command.description = arg
    end

    # Sets the command usage. The usage should not include the “usage:”
    # prefix, nor should it include the command names of the supercommand.
    #
    # @param [String] arg The new command usage
    #
    # @return [void]
    def usage(arg)
      @command.usage = arg
    end

    # Marks the command as hidden. Hidden commands do not show up in the list of
    # subcommands of the parent command, unless --verbose is passed (or
    # `:verbose => true` is passed to the {Cri::Command#help} method). This can
    # be used to mark commands as deprecated.
    #
    # @return [void]
    def be_hidden
      @command.hidden = true
    end

    # Adds a new option to the command. If a block is given, it will be
    # executed when the option is successfully parsed.
    #
    # @param [String, Symbol, nil] short The short option name
    #
    # @param [String, Symbol, nil] long The long option name
    #
    # @param [String] desc The option description
    #
    # @option params [:forbidden, :required, :optional] :argument Whether the
    #   argument is forbidden, required or optional
    #
    # @option params [Boolean] :multiple Whether or not the option should
    #   be multi-valued
    #
    # @return [void]
    def option(short, long, desc, params={}, &block)
      requiredness = params.fetch(:argument, :forbidden)
      multiple = params.fetch(:multiple, false)

      if short.nil? && long.nil?
        raise ArgumentError, "short and long options cannot both be nil"
      end

      @command.option_definitions << {
        :short    => short.nil? ? nil : short.to_s,
        :long     => long.nil? ? nil : long.to_s,
        :desc     => desc,
        :argument => requiredness,
        :multiple => multiple,
        :block    => block,
      }
    end
    alias_method :opt, :option

    # Adds a new option with a required argument to the command. If a block is
    # given, it will be executed when the option is successfully parsed.
    #
    # @param [String, Symbol, nil] short The short option name
    #
    # @param [String, Symbol, nil] long The long option name
    #
    # @param [String] desc The option description
    #
    # @option params [Boolean] :multiple Whether or not the option should
    #   be multi-valued
    #
    # @return [void]
    #
    # @see {#option}
    def required(short, long, desc, params={}, &block)
      params = params.merge(:argument => :required)
      self.option(short, long, desc, params, &block)
    end

    # Adds a new option with a forbidden argument to the command. If a block
    # is given, it will be executed when the option is successfully parsed.
    #
    # @param [String, Symbol, nil] short The short option name
    #
    # @param [String, Symbol, nil] long The long option name
    #
    # @param [String] desc The option description
    #
    # @option params [Boolean] :multiple Whether or not the option should
    #   be multi-valued
    #
    # @return [void]
    #
    # @see {#option}
    def flag(short, long, desc, params={}, &block)
      params = params.merge(:argument => :forbidden)
      self.option(short, long, desc, params, &block)
    end
    alias_method :forbidden, :flag

    # Adds a new option with an optional argument to the command. If a block
    # is given, it will be executed when the option is successfully parsed.
    #
    # @param [String, Symbol, nil] short The short option name
    #
    # @param [String, Symbol, nil] long The long option name
    #
    # @param [String] desc The option description
    #
    # @option params [Boolean] :multiple Whether or not the option should
    #   be multi-valued
    #
    # @return [void]
    #
    # @see {#option}
    def optional(short, long, desc, params={}, &block)
      params = params.merge(:argument => :optional)
      self.option(short, long, desc, params, &block)
    end

    # Sets the run block to the given block. The given block should have two
    # or three arguments (options, arguments, and optionally the command).
    # Calling this will override existing run block or runner declarations
    # (using {#run} and {#runner}, respectively).
    #
    # @yieldparam [Hash<Symbol,Object>] opts A map of option names, as defined
    #   in the option definitions, onto strings (when single-valued) or arrays
    #   (when multi-valued)
    #
    # @yieldparam [Array<String>] args A list of arguments
    #
    # @return [void]
    def run(&block)
      unless [2, 3].include?(block.arity)
        raise ArgumentError,
          "The block given to Cri::Command#run expects two or three args"
      end

      @command.block = block
    end

    # Defines the runner class for this command. Calling this will override
    # existing run block or runner declarations (using {#run} and {#runner},
    # respectively).
    #
    # @param [Class<CommandRunner>] klass The command runner class (subclass
    #   of {CommandRunner}) that is used for executing this command.
    #
    # @return [void]
    def runner(klass)
      run do |opts, args, cmd|
        klass.new(opts, args, cmd).call
      end
    end
  end
end
