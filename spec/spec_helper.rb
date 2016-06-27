require 'rack'
require 'capybara'
require 'capybara/dsl'
require 'rspec/core'
require 'capybara/rspec/matchers'
require 'capybara/rspec/features'
require 'awesome_print'
require 'yaml'
require 'nanoc'
require 'selenium/webdriver'

Dir.glob('tasks/*.rake').each { |r| load r}

# All the blog posts we're interested in checking. This means we're looking at
# files that have changed on this particular branch we're on.
#
# Returns an Array of String filenames.
def posts
  return @posts if defined? @posts

  diffable_files = `git diff -z --name-only --diff-filter=ACRTUXB origin/master -- content/changes/`.split("\0")

  @posts = diffable_files.select do |filename|
    ext = File.extname(filename)
    ext == ".md" || ext == ".html"
  end
end

# this does the file serving
class ImplictIndex
  def initialize(root)
    @root = root
    @file_server = ::Rack::File.new(root)

    res_path = ::File.join(File.dirname(__FILE__), '..', 'output')
    @res_server  = ::Rack::File.new(::File.expand_path(res_path))
  end
  attr_reader :root, :file_server, :res_server

  def call(env)
    path = env['PATH_INFO']

    # if we are looking at / let's try index.html
    if path == '/' && exists?('index.html')
      env['PATH_INFO'] = '/index.html'
    elsif !exists?(path) && exists?(path + '.html')
      env['PATH_INFO'] += '.html'
    elsif exists?(path) && directory?(path) && exists?(File.join(path, 'index.html'))
      env['PATH_INFO'] += '/index.html'
    end

    self.file_server.call(env)
  end

  def exists?(path)
    File.exist?(File.join(self.root, path))
  end

  def directory?(path)
    File.directory?(File.join(self.root, path))
  end
end

# Wire up Capybara to test again static files served by Rack
# Courtesy of http://opensoul.org/blog/archives/2010/05/11/capybaras-eating-cucumbers/

Capybara.app = Rack::Builder.new do
  map '/' do
    # use Rack::CommonLogger, $stderr
    use Rack::Lint
    run ImplictIndex.new(File.join(File.dirname(__FILE__), '..', 'output'))
  end
end.to_app

Capybara.register_driver :phantomjs do |app|
  Capybara::Selenium::Driver.new(app, browser: :phantomjs)
end

Capybara.javascript_driver = :selenium

RSpec.configure do |config|
  config.order = 'random'
  config.color = true
  config.formatter = :progress
  config.filter_run_excluding :skip => true

  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers

  config.before do
    if self.class.include?(Capybara::DSL)
      example = RSpec.current_example
      Capybara.current_driver = Capybara.javascript_driver if example.metadata[:js]
      Capybara.current_driver = example.metadata[:driver] if example.metadata[:driver]
    end
  end

  config.after do
    if self.class.include?(Capybara::DSL)
      Capybara.use_default_driver
    end
  end
end
