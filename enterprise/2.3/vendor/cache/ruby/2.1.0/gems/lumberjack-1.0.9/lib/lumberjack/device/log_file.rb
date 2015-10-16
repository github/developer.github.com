require 'fileutils'

module Lumberjack
  class Device
    # This is a logging device that appends log entries to a file.
    class LogFile < Writer
      # The absolute path of the file being logged to.
      attr_reader :path
      
      # Create a logger to the file at +path+. Options are passed through to the Writer constructor.
      def initialize(path, options = {})
        @path = File.expand_path(path)
        FileUtils.mkdir_p(File.dirname(@path))
        super(File.new(@path, 'a', :encoding => "ascii-8bit"), options)
      end
    end
  end
end
