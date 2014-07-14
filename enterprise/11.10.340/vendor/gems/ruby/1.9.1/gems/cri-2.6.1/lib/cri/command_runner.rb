# encoding: utf-8

module Cri

  # A command runner is responsible for the execution of a command. Using it
  # is optional, but it is useful for commands whose execution block is large.
  class CommandRunner

    # @return [Hash] A hash contain the options and their values
    attr_reader :options

    # @return [Array] The list of arguments
    attr_reader :arguments

    # @return [Command] The command
    attr_reader :command

    # Creates a command runner from the given options, arguments and command.
    #
    # @param [Hash] options A hash contain the options and their values
    #
    # @param [Array] arguments The list of arguments
    #
    # @param [Cri::Command] command The Cri command
    def initialize(options, arguments, command)
      @options   = options
      @arguments = arguments
      @command   = command
    end

    # Runs the command. By default, this simply does the actual execution, but
    # subclasses may choose to add error handling around the actual execution.
    #
    # @return [void]
    def call
      self.run
    end

    # Performs the actual execution of the command.
    #
    # @return [void]
    #
    # @abstract
    def run
      raise NotImplementedError, 'Cri::CommandRunner subclasses must implement #run'
    end

  end

end
