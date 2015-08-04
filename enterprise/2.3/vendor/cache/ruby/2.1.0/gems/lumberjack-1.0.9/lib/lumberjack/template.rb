module Lumberjack
  # A template converts entries to strings. Templates can contain the following place holders to
  # reference log entry values:
  #
  # * <tt>:time</tt>
  # * <tt>:severity</tt>
  # * <tt>:progname</tt>
  # * <tt>:unit_of_work_id</tt>
  # * <tt>:message</tt>
  class Template
    TEMPLATE_ARGUMENT_ORDER = %w(:time :severity :progname :pid :unit_of_work_id :message).freeze
    DEFAULT_TIME_FORMAT = "%Y-%m-%dT%H:%M:%S."
    MILLISECOND_FORMAT = "%03d"
    MICROSECOND_FORMAT = "%06d"
    
    # Create a new template from the markup. The +first_line+ argument is used to format only the first
    # line of a message. Additional lines will be added to the message unformatted. If you wish to format
    # the additional lines, use the <tt>:additional_lines</tt> options to specify a template. Note that you'll need
    # to provide the line separator character in this template if you want to keep the message on multiple lines.
    #
    # The time will be formatted as YYYY-MM-DDTHH:MM:SSS.SSS by default. If you wish to change the format, you
    # can specify the <tt>:time_format</tt> option which can be either a time format template as documented in
    # +Time#strftime+ or the values +:milliseconds+ or +:microseconds+ to use the standard format with the
    # specified precision.
    #
    # Messages will have white space stripped from both ends.
    def initialize(first_line, options = {})
      @first_line_template = compile(first_line)
      additional_lines = options[:additional_lines] || "#{Lumberjack::LINE_SEPARATOR}:message"
      @additional_line_template = compile(additional_lines)
      # Formatting the time is relatively expensive, so only do it if it will be used
      @template_include_time = first_line.include?(":time") || additional_lines.include?(":time")
      @time_format = options[:time_format] || :milliseconds
    end
    
    # Convert an entry into a string using the template.
    def call(entry)
      lines = entry.message.strip.split(Lumberjack::LINE_SEPARATOR)
      formatted_time = format_time(entry.time) if @template_include_time
      message = @first_line_template % [formatted_time, entry.severity_label, entry.progname, entry.pid, entry.unit_of_work_id, lines.shift]
      lines.each do |line|
        message << @additional_line_template % [formatted_time, entry.severity_label, entry.progname, entry.pid, entry.unit_of_work_id, line]
      end
      message
    end
    
    private

    def format_time(time) #:nodoc:
      if @time_format.is_a?(String)
        time.strftime(@time_format)
      elsif @time_format == :milliseconds
        time.strftime(DEFAULT_TIME_FORMAT) << MILLISECOND_FORMAT % (time.usec / 1000.0).round
      else
        time.strftime(DEFAULT_TIME_FORMAT) << MICROSECOND_FORMAT % time.usec
      end
    end
    
    # Compile the template string into a value that can be used with sprintf.
    def compile(template) #:nodoc:
      template.gsub(/:[a-z0-9_]+/) do |match|
        position = TEMPLATE_ARGUMENT_ORDER.index(match)
        if position
          "%#{position + 1}$s"
        else
          match
        end
      end
    end
  end
end
