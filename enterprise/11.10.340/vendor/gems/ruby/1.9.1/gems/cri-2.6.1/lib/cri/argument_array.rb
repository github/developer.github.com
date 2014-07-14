# encoding: utf-8

module Cri

  # Represents an array of arguments. It is an array that strips separator
  # arguments (`--`) but provides a `#raw` method to get the raw arguments
  # array, i.e. an array that includes the separator `--` arguments.
  class ArgumentArray < Array

    # Initializes the array using the given raw arguments.
    #
    # @param [Array<String>] raw_arguments A list of raw arguments, i.e.
    #   including any separator arguments (`--`).
    def initialize(raw_arguments)
      super(raw_arguments.reject { |a| '--' == a })
      @raw_arguments = raw_arguments
    end

    # @return [Array<String>] The arguments, including any separator arguments
    #   (`--`)
    def raw
      @raw_arguments
    end

  end

end
