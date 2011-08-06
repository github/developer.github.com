require 'nanoc3/tasks'

desc "Compile the site"
task :compile do
  `nanoc compile`
end

desc "Publish to http://developer.github.com"
task :publish => [:clean] do
  FileUtils.rm_r('output') if File.exist?('output')

  sh "nanoc compile"

  # this should not be necessary, but I can't figure out how to
  # just keep a goddamn static file in the root with nanoc
  File.open("output/CNAME", 'w+') do |f|
    f.puts("developer.github.com")
  end

  ENV['GIT_DIR'] = File.expand_path(`git rev-parse --git-dir`.chomp)
  old_sha = `git rev-parse refs/remotes/origin/gh-pages`.chomp
  Dir.chdir('output') do
    ENV['GIT_INDEX_FILE'] = gif = '/tmp/dev.gh.i'
    ENV['GIT_WORK_TREE'] = Dir.pwd
    File.unlink(gif) if File.file?(gif)
    `git add -A`
    tsha = `git write-tree`.strip
    puts "Created tree   #{tsha}"
    if old_sha.size == 40
      csha = `echo 'boom' | git commit-tree #{tsha} -p #{old_sha}`.strip
    else
      csha = `echo 'boom' | git commit-tree #{tsha}`.strip
    end
    puts "Created commit #{csha}"
    puts `git show #{csha} --stat`
    puts "Updating gh-pages from #{old_sha}"
    `git update-ref refs/heads/gh-pages #{csha}`
    `git push origin gh-pages`
  end
end
