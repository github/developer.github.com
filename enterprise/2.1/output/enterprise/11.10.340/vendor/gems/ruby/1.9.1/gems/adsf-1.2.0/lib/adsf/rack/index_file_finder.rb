module Adsf::Rack

  class IndexFileFinder

    def initialize(app, options)
      @app = app
      @root = options[:root] or raise ArgumentError, ':root option is required but was not given'
      @index_filenames = options[:index_filenames] || [ 'index.html' ]
    end

    def call(env)
      # Get path
      path_info = ::Rack::Utils.unescape(env['PATH_INFO'])
      path = ::File.join(@root, path_info)

      # Redirect if necessary
      if ::File.directory?(path) && path_info !~ /\/$/
        new_path_info = path_info + '/'
        return [
          302,
          { 'Location' => new_path_info, 'Content-Type' => 'text/html' },
          [ "Redirecting you to #{new_path_info}&hellip;" ]
        ]
      end

      # Add index file if necessary
      new_env = env.dup
      if ::File.directory?(path)
        if index_filename = index_file_in(path)
          new_env['PATH_INFO'] = ::File.join(path_info, index_filename)
        end
      end

      # Pass on
      @app.call(new_env)
    end

  private

    def index_file_in(dir)
      @index_filenames.find do |index_filename|
        ::File.file?(::File.join(dir, index_filename))
      end
    end

  end

end
