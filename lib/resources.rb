require 'pp'
require 'stringio'

module GitHub
  module Resources
    module Helpers
      def json(key)
        hash = Resources.const_get(key.to_s.upcase)
        hash = yield hash if block_given?

        io   = StringIO.new
        pp   = PP.new(io, 79)
        pp.guard_inspect_key { pp.pp(hash) }
        pp.flush
        io.string
      end
    end

    USER = {
      "url"          => "https://api.github.com/users/octocat.json",
      "html_url"     => "https://github.com/octocat",
      "type"         => "User",
      "login"        => "octocat",
      "name"         => "monalisa octocat",
      "company"      => "GitHub",
      "email"        => "octocat@github.com",
      "blog"         => "https://github.com/blog",
      "gravatar_url" => "https://github.com/images/error/octocat_happy.gif",
      "location"     => "San Francisco",
      "created_at"   => "2008-01-14T04:33:35Z"
    }

    FULL_USER = USER.merge({
      "public_gists"        => 1,
      "public_repos"        => 2,
      "followers"           => 20,
      "following"           => 0,
      "collaborators"       => 8,
      "private_gists"       => 81,
      "total_private_repos" => 100,
      "owned_private_repos" => 100,
      "disk_usage"          => 10000
    })

    REPO = {
      "url"              => "https://api.github.com/repos/octocat/Hello-World.json",
      "html_url"         => "https://github.com/octocat/Hello-World",
      "owner"            => USER,
      "name"             => "Hello-World",
      "description"      => "This your first repo!",
      "homepage"         => "",
      "language"         => nil,
      "private"          => false,
      "fork"             => false,
      "forks"            => 9,
      "watchers"         => 80,
      "size"             => 108,
      "open_issues"      => 0,
      "pushed_at"        => "2011-01-26T19:06:43Z",
      "created_at"       =>"2011-01-26T19:01:12Z"
    }

    FULL_REPO = REPO.merge({
      "organization"     => USER.merge('type' => 'Organization'),
      "parent"           => REPO,
      "source"           => REPO,
      "integrate_branch" => nil,
      "master_branch"    => nil,
      "has_issues"       => true,
      "has_wiki"         => true,
      "has_downloads"    => true
    })

    MILESTONE = {}
    LABEL = {}

    ISSUE = {
      "url"        => "https://api.github.com/repos/octocat/Hello-World/issues/1.json",
      "html_url"   => "https://github.com/octocat/Hello-World/issues/1",
      "number"     => 1347,
      "state"      => "open",
      "title"      => "Found a bug",
      "body"       => "I'm having a problem with this.",
      "user"       => USER,
      "labels"     => [LABEL],
      "assignee"   => USER,
      "milestone"  => MILESTONE,
      "comments"   => 0,
      "closed_at"  => nil,
      "created_at" => "2011-04-22T13:33:48Z",
      "updated_at" => "2011-04-22T13:33:48Z"
    }
  end
end

include GitHub::Resources::Helpers
