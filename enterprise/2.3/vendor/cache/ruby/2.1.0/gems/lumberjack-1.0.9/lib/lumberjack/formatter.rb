module Lumberjack
  # This class controls the conversion of log entry messages into strings. This allows you
  # to log any object you want and have the logging system worry about converting it into a string.
  #
  # Formats are added to a Formatter by associating them with a class using the +add+ method. Formats
  # are any object that responds to the +call+ method.
  #
  # By default, all object will be converted to strings using their inspect method except for Strings
  # and Exceptions. Strings are not converted and Exceptions are converted using the ExceptionFormatter.
  class Formatter
    load File.expand_path("../formatter/exception_formatter.rb", __FILE__)
    load File.expand_path("../formatter/inspect_formatter.rb", __FILE__)
    load File.expand_path("../formatter/pretty_print_formatter.rb", __FILE__)
    load File.expand_path("../formatter/string_formatter.rb", __FILE__)
    
    def initialize
      @class_formatters = {}
      @_default_formatter = InspectFormatter.new
      add(Object, @_default_formatter)
      add(String, :string)
      add(Exception, :exception)
    end
    
    # Add a formatter for a class. The formatter can be specified as either an object
    # that responds to the +call+ method or as a symbol representing one of the predefined
    # formatters, or as a block to the method call.
    #
    # The predefined formatters are: <tt>:inspect</tt>, <tt>:string</tt>, <tt>:exception</tt>, and <tt>:pretty_print</tt>.
    #
    # === Examples
    #
    #   # Use a predefined formatter
    #   formatter.add(MyClass, :pretty_print)
    #
    #   # Pass in a formatter object
    #   formatter.add(MyClass, Lumberjack::Formatter::PrettyPrintFormatter.new)
    #
    #   # Use a block
    #   formatter.add(MyClass){|obj| obj.humanize}
    #
    #   # Add statements can be chained together
    #   formatter.add(MyClass, :pretty_print).add(YourClass){|obj| obj.humanize}
    def add(klass, formatter = nil, &block)
      formatter ||= block
      if formatter.is_a?(Symbol)
        formatter_class_name = "#{formatter.to_s.gsub(/(^|_)([a-z])/){|m| $~[2].upcase}}Formatter"
        formatter = Formatter.const_get(formatter_class_name).new
      end
      @class_formatters[klass] = formatter
      self
    end
    
    # Remove the formatter associated with a class. Remove statements can be chained together.
    def remove(klass)
      @class_formatters.delete(klass)
      self
    end
    
    # Format a message object as a string.
    def format(message)
      formatter_for(message.class).call(message)
    end
    
    # Hack for compatibility with Logger::Formatter
    def call(severity, timestamp, progname, msg)
      "#{format(msg)}\n"
    end    

    private
    
    # Find the formatter for a class by looking it up using the class hierarchy.
    def formatter_for(klass) #:nodoc:
      while klass != nil do
        formatter = @class_formatters[klass]
        return formatter if formatter
        klass = klass.superclass
      end
      @_default_formatter
    end
  end
end
