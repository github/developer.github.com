require 'pp'
require 'stringio'

module GitHub
  module Resources
    module Helpers
      STATUSES = {
        200 => '200 OK',
        201 => '201 Created',
        204 => '204 No Content',
        301 => '301 Moved Permanently',
        304 => '304 Not Modified',
        401 => '401 Unauthorized',
        403 => '403 Forbidden',
        404 => '404 Not Found',
        409 => '409 Conflict',
        422 => '422 Unprocessable Entity',
        500 => '500 Server Error'
      }

      def headers(status, head = {})
        lines = ["Status: #{STATUSES[status]}"]
        head.each do |key, value|
          case key
            when :pagination
              lines << "X-Next: https://api.github.com/resource?page=2"
              lines << "X-Last: https://api.github.com/resource?page=5"
            else lines << "#{key}: #{value}"
          end
        end

        lines << "X-RateLimit-Limit: 5000"
        lines << "X-RateLimit-Remaining: 4999"
        css    = status == 204 ? nil : 'headers'

        %(<pre class="#{css}"><code>#{lines * "\n"}</code></pre>\n)
      end

      def json(key)
        hash = case key
          when Hash
            h = {}
            key.each { |k, v| h[k.to_s] = v }
            h
          when Array
            key
          else Resources.const_get(key.to_s.upcase)
        end

        hash = yield hash if block_given?

        io   = StringIO.new
        pp   = PP.new(io, 79)
        pp.guard_inspect_key { pp.pp(hash) }
        pp.flush
        %(<pre class="highlight"><code class="language-javascript">) +
          io.string + "</code></pre>"
      end
    end

    USER = {
      "login"        => "octocat",
      "id"           => 1,
      "gravatar_url" => "https://github.com/images/error/octocat_happy.gif",
      "url"          => "https://api.github.com/users/octocat"
    }

    FULL_USER = USER.merge({
      "name"         => "monalisa octocat",
      "company"      => "GitHub",
      "blog"         => "https://github.com/blog",
      "location"     => "San Francisco",
      "email"        => "octocat@github.com",
      "hireable"     => false,
      "bio"          => "There once was...",
      "public_repos" => 2,
      "public_gists" => 1,
      "followers"    => 20,
      "following"    => 0,
      "html_url"     => "https://github.com/octocat",
      "created_at"   => "2008-01-14T04:33:35Z",
      "type"         => "User"
    })

    PRIVATE_USER = FULL_USER.merge({
      "total_private_repos" => 100,
      "owned_private_repos" => 100,
      "private_gists"       => 81,
      "disk_usage"          => 10000,
      "collaborators"       => 8,
      "plan"                => {
        "name"          => "Medium",
        "space"         => 400,
        "collaborators" => 10,
        "private_repos" => 20
      }
    })

    PUBLIC_KEY = {
      "url"   => "https://api.github.com/user/keys/1",
      "id"    => "1",
      "title" => "octocat@octomac",
      "key"   => "<public ssh key>",
    }

    REPO = {
      "url"              => "https://api.github.com/repos/octocat/Hello-World",
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

    ORG = {
      "id"           => 1,
      "url"          => "https://apit.github.com/orgs/1",
      "gravatar_url" => "https://github.com/images/error/octocat_happy.gif"
    }

    FULL_ORG = ORG.merge({
      "name"         => "github",
      "company"      => "GitHub",
      "blog"         => "https://github.com/blog",
      "location"     => "San Francisco",
      "email"        => "octocat@github.com",
      "public_repos" => 2,
      "public_gists" => 1,
      "followers"    => 20,
      "following"    => 0,
      "html_url"     => "https://github.com/octocat",
      "created_at"   => "2008-01-14T04:33:35Z",
      "type"         => "Organization"
    })

    PRIVATE_ORG = FULL_ORG.merge({
      "total_private_repos" => 100,
      "owned_private_repos" => 100,
      "private_gists"       => 81,
      "disk_usage"          => 10000,
      "collaborators"       => 8,
      "billing_email"       => "support@github.com",
      "plan"                => {
        "name"          => "Medium",
        "space"         => 400,
        "collaborators" => 10,
        "private_repos" => 20
      }
    })

    MILESTONE = {
      "url" => "https://api.github.com/repos/octocat/Hello-World/milestones/1",
      "number"        => 1,
      "state"         => "open",
      "title"         => "v1.0",
      "description"   => "",
      "creator"       => USER,
      "open_issues"   => 4,
      "closed_issues" => 8,
      "created_at"    => "2011-04-10T20:09:31Z",
      "due_on"        => nil
    }

    LABEL = {
      "url"   => "https://api.github.com/repos/octocat/Hello-World/labels/bug",
      "name"  => "bug",
      "color" => "f29513"
    }

    ISSUE = {
      "url"        => "https://api.github.com/repos/octocat/Hello-World/issues/1",
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
      "pull_request" => {
        "html_url"  => "https://github.com/octocat/Hello-World/issues/1",
        "diff_url"  => "https://github.com/octocat/Hello-World/issues/1.diff",
        "patch_url" => "https://github.com/octocat/Hello-World/issues/1.patch"
      },
      "closed_at"  => nil,
      "created_at" => "2011-04-22T13:33:48Z",
      "updated_at" => "2011-04-22T13:33:48Z"
    }

    ISSUE_COMMENT = {
      "url"        => "https://api.github.com/repos/octocat/Hello-World/issues/comments/1",
      "body"       => "Me too",
      "user"       => USER,
      "created_at" => "2011-04-14T16:00:49Z",
      "updated_at" => "2011-04-14T16:00:49Z"
    }

    ISSUE_EVENT = {
      "url" => "https://api.github.com/repos/octocat/Hello-World/issues/events/1",
      "actor"      => USER,
      "event"      => "closed",
      "commit_id"  => "SHA",
      "created_at" => "2011-04-14T16:00:49Z"
    }

    GIST_HISTORY = {
      "history" => [
        {
          "url"     => "https://api.github.com/gists/1/57a7f021a713b1c5a6a199b54cc514735d2d462f",
          "version" => "57a7f021a713b1c5a6a199b54cc514735d2d462f",
          "user"    => USER,
          "change_status" => {
            "deletions" => 0,
            "additions" => 180,
            "total"     => 180
          },
          "committed_at" => "2010-04-14T02:15:15Z"
        }
      ]
    }

    GIST_FORKS = {
      "forks" => [
        {
          "user" => USER,
          "url" => "https://api.github.com/gists/5",
          "created_at" => "2011-04-14T16:00:49Z"
        }
      ]
    }

    GIST_FILES = {
      "files" => {
        "ring.erl"   => {
          "size"     => 932,
          "filename" => "ring.erl",
          "raw_url"  => "https://gist.github.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl"
        }
      }
    }

    GIST = {
      "url"          => "https://api.github.com/gists/1",
      "id"           => "1",
      "description"  => "description of gist",
      "public"       => true,
      "user"         => USER,
      "files"        => GIST_FILES,
      "comments"     => 0,
      "git_pull_url" => "git://gist.github.com/1.git",
      "git_push_url" => "git@gist.github.com:1.git",
      "created_at"   => "2010-04-14T02:15:15Z"
    }.update(GIST_FILES)

    FULL_GIST = GIST.merge(GIST_FORKS).merge(GIST_HISTORY)
    FULL_GIST['files']['ring.erl']['content'] = 'contents of gist'

    GIST_COMMENT = {
      "id"         => 1,
      "url"        => "https://api.github.com/gists/comments/1",
      "body"       => "Just commenting for the sake of commenting",
      "user"       => USER,
      "created_at" => "2011-04-18T23:23:56Z"
    }

    TREE = {
      "count"  => 3,
      "sha"  => "9fb037999f264ba9a7fc6274d15fa3ae2ab98312",
      "tree"  => [
        { "path" => "file.rb",
          "mode" => "100644",
          "type" => "blob",
          "sha"  => "44b4fc6d56897b048c772eb4087f854f46256132"
        },
        { "path" => "subdir",
          "mode" => "040000",
          "type" => "tree",
          "sha"  => "f484d249c660418515fb01c2b9662073663c242e"
        },
        { "path" => "exec_file",
          "mode" => "100755",
          "type" => "blob",
          "sha"  => "45b983be36b73c0788dc9cbcb76cbb80fc7bb057"
        }
      ]
    }
    TREE_EXTRA = {
      "count" => 4,
      "tree" => {
          "path" => "subdir/file.txt",
          "mode" => "100644",
          "type" => "blob",
          "sha"  => "7c258a9869f33c1e1e1f74fbb32f07c86cb5a75b"
      }
    }
    FULL_TREE = TREE.merge(TREE_EXTRA) do |k, o, n|
      k == 'tree' ? o << n : n
    end

    COMMIT = {
      "sha" => "cd52fced9c728f3a37578620e9d6135a55eb2ef2",
      "author" => {
        "name"  => "Scott Chacon",
        "email" => "scott@github.com",
        "date"  => "2008-07-09T16:13:30+12:00"
      },
      "committer" => {
        "name"  => "Scott Chacon",
        "email" => "scott@github.com",
        "date"  => "2008-07-09T16:13:30+12:00"
      },
      "message"  => "my commit message",
      "tree"     => "9fb037999f264ba9a7fc6274d15fa3ae2ab98312",
      "parents"  => ["7d1b31e74ee336d15cbd21741bc88a537ed063a0"]
    }

    TAG = {
      "sha" => "b8d04eddde9f53f3bc76dd048f3477062a27c91a",
      "tag" => "v1.0",
      "tagger" => {
        "name"  => "Scott Chacon",
        "email" => "scott@github.com",
        "date"  => "2008-07-09T16:13:30+12:00"
      },
      "message" => "my tag message",
      "object"  => "9fb037999f264ba9a7fc6274d15fa3ae2ab98312",
      "type"    => "commit"
    }

    REFS = [
      { "ref" => "refs/heads/master",
        "sha" => "75e41c7ddf122d799730c39d2295ee840d9b7b08",
        "type" => "commit" },
      { "ref" => "refs/heads/gh-page",
        "sha" => "1bb58aecaf6bbcf9f7e39dff2e42e0291f42d235",
        "type" => "commit" },
      { "ref" => "refs/tags/v0.1",
        "sha" => "be87be3a49e75474e438a9a9f44b3deafb0af01c",
        "type" => "tag" },
      { "ref" => "refs/notes/commits",
        "sha" => "1bb58aecaf6bbcf9f7e39dff2e42e0291f42d235",
        "type" => "commit" },
    ]

  end
end

include GitHub::Resources::Helpers
