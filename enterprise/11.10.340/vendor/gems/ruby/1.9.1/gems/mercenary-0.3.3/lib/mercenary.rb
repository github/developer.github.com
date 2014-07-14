lib = File.expand_path('../', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "mercenary/version"
require "optparse"
require "logger"

module Mercenary
  autoload :Command,   "mercenary/command"
  autoload :Option,    "mercenary/option"
  autoload :Presenter, "mercenary/presenter"
  autoload :Program,   "mercenary/program"

  # Public: Instantiate a new program and execute.
  #
  # name - the name of your program
  #
  # Returns nothing.
  def self.program(name)
    program = Program.new(name)
    yield program
    program.go(ARGV)
  end
end
