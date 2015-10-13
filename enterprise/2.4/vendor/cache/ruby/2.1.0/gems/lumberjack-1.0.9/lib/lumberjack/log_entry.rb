module Lumberjack
  # An entry in a log is a data structure that captures the log message as well as
  # information about the system that logged the message.
  class LogEntry
    attr_accessor :time, :message, :severity, :progname, :pid, :unit_of_work_id
    
    TIME_FORMAT = "%Y-%m-%dT%H:%M:%S".freeze
    
    def initialize(time, severity, message, progname, pid, unit_of_work_id)
      @time = time
      @severity = (severity.is_a?(Fixnum) ? severity : Severity.label_to_level(severity))
      @message = message
      @progname = progname
      @pid = pid
      @unit_of_work_id = unit_of_work_id
    end
    
    def severity_label
      Severity.level_to_label(severity)
    end
    
    def to_s
      buf = "[#{time.strftime(TIME_FORMAT)}.#{(time.usec / 1000.0).round.to_s.rjust(3, '0')} #{severity_label} #{progname}(#{pid})"
      if unit_of_work_id
        buf << " #"
        buf << unit_of_work_id
      end
      buf << "] "
      buf << message
    end
    
    def inspect
      to_s
    end
  end
end
