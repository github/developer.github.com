module Lumberjack
  class Formatter
    # Format an exception including the backtrace.
    class ExceptionFormatter
      def call(exception)
        message = "#{exception.class.name}: #{exception.message}"
        message << "#{Lumberjack::LINE_SEPARATOR}  #{exception.backtrace.join("#{Lumberjack::LINE_SEPARATOR}  ")}" if exception.backtrace
        message
      end
    end
  end
end
