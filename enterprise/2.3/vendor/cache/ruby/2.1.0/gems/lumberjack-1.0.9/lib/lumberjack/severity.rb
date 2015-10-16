module Lumberjack
  # The standard severity levels for logging messages.
  module Severity
    UNKNOWN = 5
    FATAL = 4
    ERROR = 3
    WARN = 2
    INFO = 1
    DEBUG = 0
    
    SEVERITY_LABELS = %w(DEBUG INFO WARN ERROR FATAL UNKNOWN).freeze
    
    class << self
      def level_to_label(severity)
        SEVERITY_LABELS[severity] || SEVERITY_LABELS.last
      end
    
      def label_to_level(label)
        SEVERITY_LABELS.index(label.to_s.upcase) || UNKNOWN
      end
    end
  end
end
