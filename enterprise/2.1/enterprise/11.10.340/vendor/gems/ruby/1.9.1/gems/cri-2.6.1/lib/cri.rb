# encoding: utf-8

require 'cri/version'

# The namespace for Cri, a library for building easy-to-use commandline tools
# with support for nested commands.
module Cri

  # A generic error class for all Cri-specific errors.
  class Error < ::StandardError
  end

  # Error that will be raised when an implementation for a method or command
  # is missing. For commands, this may mean that a run block is missing.
  class NotImplementedError < Error
  end

  # Error that will be raised when no help is available because the help
  # command has no supercommand for which to show help.
  class NoHelpAvailableError < Error
  end

  autoload 'Command',           'cri/command'
  autoload 'StringFormatter',   'cri/string_formatter'
  autoload 'CommandDSL',        'cri/command_dsl'
  autoload 'CommandRunner',     'cri/command_runner'
  autoload 'HelpRenderer',      'cri/help_renderer'
  autoload 'OptionParser',      'cri/option_parser'
  autoload 'Platform',          'cri/platform'

end

require 'set'

require 'cri/core_ext'
require 'cri/argument_array'
