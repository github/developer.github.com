require_relative 'lib/resources'
require 'tmpdir'

Dir.glob('tasks/**/*.rake').each { |r| load r }

task :default => [:test]

desc 'Builds the site'
task :build do
  if ENV['RACK_ENV'] == 'test'
    begin
      sh 'node_modules/gulp/bin/gulp.js build > build.txt'
    rescue StandardError => e
      puts 'uh oh'
      $stderr.puts `cat build.txt`
      raise e
    end
  else
    sh 'node_modules/gulp/bin/gulp.js build'
  end
end

desc "Test the output"
task :test => [:remove_tmp_dir, :remove_output_dir, :build, :run_proofer]

desc "Run the HTML-Proofer"
task :run_proofer do
  require 'html/proofer'
  ignored_links = [%r{www.w3.org}]
  latest_ent_version = GitHub::Resources::Helpers::CONTENT['LATEST_ENTERPRISE_VERSION']
  # swap versionless Enterprise articles with versioned paths
  href_swap = {
    %r{help\.github\.com/enterprise/admin/} => "help.github.com/enterprise/#{config[:versions][0]}/admin/",
    %r{help\.github\.com/enterprise/user/} => "help.github.com/enterprise/#{config[:versions][0]}/user/"
  }
  HTML::Proofer.new("./output", :href_ignore => ignored_links, :href_swap => href_swap).run
end

desc "Remove the tmp dir"
task :remove_tmp_dir do
  FileUtils.rm_r('tmp') if File.exist?('tmp')
end

desc "Remove the output dir"
task :remove_output_dir do
  FileUtils.rm_r('output') if File.exist?('output')
end

# Prompt user for a commit message; default: P U B L I S H :emoji:
def commit_message(no_commit_msg = false)
  publish_emojis = [':boom:', ':rocket:', ':metal:', ':bulb:', ':zap:',
    ':sailboat:', ':gift:', ':ship:', ':shipit:', ':sparkles:', ':rainbow:']
  default_message = "P U B L I S H #{publish_emojis.sample}"

  unless no_commit_msg
    print "Enter a commit message (default: '#{default_message}'): "
    STDOUT.flush
    mesg = STDIN.gets.chomp.strip
  end

  mesg = default_message if mesg.nil? || mesg == ''
  mesg << "\nGenerated from #{ENV['BUILD_SHA']}" if ENV['BUILD_SHA']
  mesg.gsub(/'/, '') # Allow this to be handed off via -m '#{message}'
end

namespace :assets do
  task :precompile => [:build] do
    sh 'mv output _site/'
  end
end

desc "Publish to http://developer.github.com"
task :publish, [:no_commit_msg] => [:remove_tmp_dir, :remove_output_dir, :build] do |t, args|
  message = commit_message(args[:no_commit_msg])

  Dir.mktmpdir do |tmp|
    system "mv output/* #{tmp}"
    system "cp .gitignore #{tmp}"
    system 'git checkout gh-pages'
    system "rsync -av #{tmp}/ ."
    system 'git add .'
    system "git commit -am #{message.shellescape}"
    system 'git push origin gh-pages --force'
    system 'git checkout master'
  end
end
