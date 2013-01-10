require 'nanoc3/tasks'

require './lib/resources'
require 'curb'
require 'yajl'
require 'json-compare'
require 'hashdiff'

desc "Compile the site"
task :compile do
  `nanoc compile`
end

# prompt user for a commit message; default: HEAD commit 1-liner
def commit_message
  last_commit = `git log -1 --pretty=format:"%s"`.chomp.strip
  last_commit = 'Publishing developer content to GitHub pages.' if last_commit == ''

  print "Enter a commit message (default: '#{last_commit}'): "
  STDOUT.flush
  mesg = STDIN.gets.chomp.strip

  mesg = last_commit if mesg == ''
  mesg.gsub(/'/, '') # to allow this to be handed off via -m '#{message}'
end

desc "Publish to http://developer.github.com"
task :publish => [:clean] do
  mesg = commit_message

  FileUtils.rm_r('output') if File.exist?('output')

  sh "nanoc compile"

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

task :api_test do
  API_URL = "https://api.github.com"

  # missing tag, team ?
  public_api = { 
        "FULL_USER" => "/users/octocat",
        "GIST"      => "/users/octocat/gists",
        "TEMPLATES" => "/gitignore/template",
        "TEMPLATE"  => "/gitignore/templates/C",
        "ORG"       => "/users/gjtorikian/orgs",
        "FULL_ORG"  => "/orgs/github",
        "PULL"      => "/repos/octocat/Hello-World/pulls/1",
        "COMMIT"    => "/repos/octocat/Hello-World/pulls/1/commits",
        "FILE"      => "/repos/octocat/Hello-World/pulls/1/files",
        "FULL_REPO" => "/users/octocat/repos",
        "CONTRIBUTOR" => "/repos/octocat/Hello-World/contributors",
        "BRANCHES"   => "/repos/octocat/Hello-World/branches",
        "BRANCH"   => "/repos/octocat/Hello-World/branches/master"
  }

  auth_api = {
    "ISSUE" => "",
    "OAUTH_ACCESS" => ""
  }

  public_api.each do |type, url|
    parser = Yajl::Parser.new

    doc_type = JSON.parse(GitHub::Resources::json(type, true))
    api_hash = parser.parse(Curl.get(API_URL + url).body_str)

    puts "\n#{type}\n"
    
    if api_hash.kind_of?(Array)
      if api_hash.length != doc_type.length
        #puts "WTF, API has #{api_hash.length} entries, while Doc has #{doc_type.length} (#{api_hash.length - doc_type.length})"
      
        #puts "API: #{api_hash} #{doc_type}"

        diff = []
      else
        api_hash.each do |elem, i|
          #puts i
        end
      end
    else
      pp api_hash
      #diff = api_hash.keys - doc_type.keys
    end

    #if diff.length
      #puts "DANGER, DANGER, WILL ROBINSON! The following #{type} values are NOT documented: \n\n"

     # diff.each do |id|
        #puts "#{id} is new!"
     # end
    #end
  end
end