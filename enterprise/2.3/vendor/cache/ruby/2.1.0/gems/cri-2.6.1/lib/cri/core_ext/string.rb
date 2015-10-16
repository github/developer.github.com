# encoding: utf-8

require 'colored'

module Cri::CoreExtensions

  # @deprecated
  module String

    # @see Cri::StringFormatter#to_paragraphs
    def to_paragraphs
      Cri::StringFormatter.new.to_paragraphs(self)
    end

    # @see Cri::StringFormatter#to_paragraphs
    def wrap_and_indent(width, indentation)
      Cri::StringFormatter.new.wrap_and_indent(self, width, indentation)
    end

    # @see Cri::StringFormatter#format_as_title
    def formatted_as_title
      Cri::StringFormatter.new.format_as_title(self)
    end

    # @see Cri::StringFormatter#format_as_command
    def formatted_as_command
      Cri::StringFormatter.new.format_as_command(self)
    end

    # @see Cri::StringFormatter#format_as_option
    def formatted_as_option
      Cri::StringFormatter.new.format_as_option(self)
    end

  end

end
