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

        %(<pre class="headers"><code>#{lines * "\n"}</code></pre>\n)
      end

      def json(key)
        hash = case key
          when Hash
            h = {}
            key.each { |k, v| h[k.to_s] = v }
            h
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

    MILESTONE = {
      "url" => "https://api.github.com/repos/octocat/Hello-World/milestones/1.json",
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
      "url"   => "https://api.github.com/repos/octocat/Hello-World/labels/bug.json",
      "name"  => "bug",
      "color" => "f29513"
    }

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
      "url"        => "https://api.github.com/repos/octocat/Hello-World/issues/comments/1001987.json",
      "body"       => "Me too",
      "user"       => USER,
      "created_at" => "2011-04-14T16:00:49Z",
      "updated_at" => "2011-04-14T16:00:49Z"
    }

    GIST_HISTORY = {
      "history" => [
        {
          "url"     => "https://api.github.com/gists/1/57a7f021a713b1c5a6a199b54cc514735d2d462f.json",
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
      "url"          => "https://api.github.com/gists/1.json",
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

    FULL_GIST = GIST.merge(GIST_HISTORY)
    FULL_GIST['files']['ring.erl']['content'] = 'contents of gist'

    GIST_COMMENT = {
      "id"         => 1,
      "url"        => "https://api.github.com/gists/comments/1.json",
      "body"       => "Just commenting for the sake of commenting",
      "user"       => USER,
      "created_at" => "2011-04-18T23:23:56Z"
    }
  end
end

include GitHub::Resources::Helpers
