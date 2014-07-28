require 'nanoc3/tasks'
require 'tmpdir'

task :default => [:test]

desc "Compile the site"
task :compile do
  `nanoc compile`
end

desc "Test the output"
task :test => [:clean, :remove_output_dir, :compile] do
  require 'html/proofer'
  HTML::Proofer.new("./output").run
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
  mesg.gsub(/'/, '') # Allow this to be handed off via -m '#{message}'
end

desc "Publish to http://developer.github.com"
task :publish, [:no_commit_msg] => [:clean, :remove_output_dir] do |t, args|
  mesg = commit_message(args[:no_commit_msg])
  sh "nanoc compile"

  # save precious files
  if ENV['IS_HEROKU']
    `git checkout origin/gh-pages`
  else
    `git checkout gh-pages`
  end
  tmpdir = Dir.mktmpdir
  FileUtils.cp_r("enterprise", tmpdir)
  FileUtils.cp("robots.txt", tmpdir)
  `git checkout master`

  ENV['GIT_DIR'] = File.expand_path(`git rev-parse --git-dir`.chomp)
  ENV['RUBYOPT'] = nil
  old_sha = `git rev-parse refs/remotes/origin/gh-pages`.chomp
  Dir.chdir('output') do
    ENV['GIT_INDEX_FILE'] = gif = '/tmp/dev.gh.i'
    ENV['GIT_WORK_TREE'] = Dir.pwd
    File.unlink(gif) if File.file?(gif)
    # restore precious files
    FileUtils.cp_r("#{tmpdir}/enterprise", ".")
    FileUtils.cp("#{tmpdir}/robots.txt", ".")
    FileUtils.rm_rf(tmpdir) if File.exists?(tmpdir)
    `git add -A`
    tsha = `git write-tree`.strip
    puts "Created tree   #{tsha}"
    # Heroku runs git@1.7, we don't have the luxury of -m
    if ENV['IS_HEROKU']
      `echo #{mesg} > changelog`
      csha = `git commit-tree #{tsha} -p #{old_sha} < changelog`.strip
    elsif old_sha.size == 40
      csha = `git commit-tree #{tsha} -p #{old_sha} -m '#{mesg}'`.strip
    else
      csha = `git commit-tree #{tsha} -m '#{mesg}'`.strip
    end
    puts "Created commit #{csha}"
    puts `git show #{csha} --stat`
    puts "Updating gh-pages from #{old_sha}"
    `git update-ref refs/heads/gh-pages #{csha}`
    `git push origin gh-pages`
  end
end
