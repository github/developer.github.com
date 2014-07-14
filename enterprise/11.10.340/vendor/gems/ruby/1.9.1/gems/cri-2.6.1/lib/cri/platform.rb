# encoding: utf-8

module Cri

  module Platform

    # @return [Boolean] true if the current platform is Windows, false
    # otherwise.
    def self.windows?
      !!(RUBY_PLATFORM =~ /windows|bccwin|cygwin|djgpp|mingw|mswin|wince/i)
    end

    # Checks whether colors can be enabled. For colors to be enabled, the given
    # IO should be a TTY, and, when on Windows, ::Win32::Console::ANSI needs to
    # be defined.
    #
    # @return [Boolean] True if colors should be enabled, false otherwise.
    def self.color?(io)
      if !io.tty?
        false
      elsif windows?
        defined?(::Win32::Console::ANSI)
      else
        true
      end
    end

  end

end
