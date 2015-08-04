module Lumberjack
  class Device
    # This logging device writes log entries as strings to an IO stream. By default, messages will be buffered
    # and written to the stream in a batch when the buffer is full or when +flush+ is called.
    class Writer < Device
      DEFAULT_FIRST_LINE_TEMPLATE = "[:time :severity :progname(:pid) #:unit_of_work_id] :message".freeze
      DEFAULT_ADDITIONAL_LINES_TEMPLATE = "#{Lumberjack::LINE_SEPARATOR}> [#:unit_of_work_id] :message".freeze

      # The size of the internal buffer. Defaults to 32K.
      attr_reader :buffer_size
      
      # Internal buffer to batch writes to the stream.
      class Buffer # :nodoc:
        attr_reader :size
        
        def initialize
          @values = []
          @size = 0
        end
        
        def <<(string)
          @values << string
          @size += string.size
        end
        
        def empty?
          @values.empty?
        end
        
        def join(delimiter)
          @values.join(delimiter)
        end
        
        def clear
          @values = []
          @size = 0
        end
      end
      
      # Create a new device to write log entries to a stream. Entries are converted to strings
      # using a Template. The template can be specified using the <tt>:template</tt> option. This can
      # either be a Proc or a string that will compile into a Template object.
      #
      # If the template is a Proc, it should accept an LogEntry as its only argument and output a string.
      #
      # If the template is a template string, it will be used to create a Template. The
      # <tt>:additional_lines</tt> and <tt>:time_format</tt> options will be passed through to the
      # Template constuctor.
      #
      # The default template is <tt>"[:time :severity :progname(:pid) #:unit_of_work_id] :message"</tt>
      # with additional lines formatted as <tt>"\n [#:unit_of_work_id] :message"</tt>. The unit of
      # work id will only appear if it is present.
      #
      # The size of the internal buffer in bytes can be set by providing <tt>:buffer_size</tt> (defaults to 32K).
      def initialize(stream, options = {})
        @lock = Mutex.new
        @stream = stream
        @stream.sync = true if @stream.respond_to?(:sync=)
        @buffer = Buffer.new
        @buffer_size = (options[:buffer_size] || 0)
        template = (options[:template] || DEFAULT_FIRST_LINE_TEMPLATE)
        if template.respond_to?(:call)
          @template = template
        else
          additional_lines = (options[:additional_lines] || DEFAULT_ADDITIONAL_LINES_TEMPLATE)
          @template = Template.new(template, :additional_lines => additional_lines, :time_format => options[:time_format])
        end
      end
      
      # Set the buffer size in bytes. The device will only be physically written to when the buffer size
      # is exceeded.
      def buffer_size=(value)
        @buffer_size = value
        flush
      end
      
      # Write an entry to the stream. The entry will be converted into a string using the defined template.
      def write(entry)
        string = @template.call(entry)
        @lock.synchronize do
          @buffer << string
        end
        flush if @buffer.size >= buffer_size
      end
      
      # Close the underlying stream.
      def close
        flush
        stream.close
      end
      
      # Flush the underlying stream.
      def flush
        @lock.synchronize do
          before_flush
          unless @buffer.empty?
            out = @buffer.join(Lumberjack::LINE_SEPARATOR) << Lumberjack::LINE_SEPARATOR
            begin
              stream.write(out)
              stream.flush
            rescue => e
              $stderr.write("#{e.class.name}: #{e.message}#{' at ' + e.backtrace.first if e.backtrace}")
              $stderr.write(out)
              $stderr.flush
            end
            @buffer.clear
          end
        end
      end
      
      protected
      
      # Callback method that will be executed before data is written to the stream. Subclasses
      # can override this method if needed.
      def before_flush
      end
      
      # Set the underlying stream.
      def stream=(stream)
        @stream = stream
      end
      
      # Get the underlying stream.
      def stream
        @stream
      end
    end
  end
end
