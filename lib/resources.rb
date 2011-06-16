require 'pp'
require 'yajl/json_gem'
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
        css_class = (status == 204 || status == 404) ? 'headers no-response' : 'headers'
        lines = ["Status: #{STATUSES[status]}"]
        head.each do |key, value|
          case key
            when :pagination
              lines << 'Link: <https://api.github.com/resource?page=2>; rel="next",'
              lines << '      <https://api.github.com/resource?page=5>; rel="last"'
            else lines << "#{key}: #{value}"
          end
        end

        lines << "X-RateLimit-Limit: 5000"
        lines << "X-RateLimit-Remaining: 4999"

        %(<pre class="#{css_class}"><code>#{lines * "\n"}</code></pre>\n)
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

        %(<pre class="highlight"><code class="language-javascript">) +
          JSON.pretty_generate(hash) + "</code></pre>"
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
      "key"   => "ssh-rsa AAA...",
    }

    REPO = {
      "url"              => "https://api.github.com/repos/octocat/Hello-World",
      "html_url"         => "https://github.com/octocat/Hello-World",
      "owner"            => USER,
      "name"             => "Hello-World",
      "description"      => "This your first repo!",
      "homepage"         => "https://github.com",
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
      "default_branch"   => 'master',
      "master_branch"    => 'master',
      "has_issues"       => true,
      "has_wiki"         => true,
      "has_downloads"    => true
    })

    TAG = {
      "commit_url"  => "https://api.github.com/octocat/Hello-World/commits/c5b97d5ae6c19d5c5df71a34c7fbeeda2479ccbc",
      "name"        => "v0.1",
      "sha"         => "c5b97d5ae6c19d5c5df71a34c7fbeeda2479ccbc",
      "zipball_url" => "https://github.com/octocat/Hello-World/zipball/v0.1",
      "tarball_url" => "https://github.com/octocat/Hello-World/tarball/v0.1",
    }

    BRANCH = {
      "commit_url" => "https://api.github.com/octocat/Hello-World/commits/c5b97d5ae6c19d5c5df71a34c7fbeeda2479ccbc",
      "name"       => "master",
      "sha"        => "6dcb09b5b57875f334f61aebed695e2e4193db5e"
    }


    PULL = {
      "url"        => "https://api.github.com/octocat/Hello-World/pulls/1",
      "html_url"   => "https://github.com/octocat/Hello-World/pulls/1",
      "diff_url"   => "https://github.com/octocat/Hello-World/pulls/1.diff",
      "patch_url"  => "https://github.com/octocat/Hello-World/pulls/1.patch",
      "issue_url"  => "https://github.com/octocat/Hello-World/issue/1",
      "number"     => 1,
      "state"      => "open",
      "title"      => "new-feature",
      "body"       => "Please pull these awesome changes",
      "created_at" => "2011-01-26T19:01:12Z",
      "updated_at" => "2011-01-26T19:01:12Z",
      "closed_at"  => "2011-01-26T19:01:12Z",
      "merged_at"  => "2011-01-26T19:01:12Z",
    }

    FULL_PULL = PULL.merge({
      "merged"        => false,
      "mergeable"     => true,
      "merged_by"     => USER,
      "comments"      => 10,
      "commits"       => 3,
      "additions"     => 100,
      "deletions"     => 3,
      "changed_files" => 5,
      "head"          => {
        "label" => "new-topic",
        "ref"   => "new-topic",
        "sha"   => "6dcb09b5b57875f334f61aebed695e2e4193db5e",
        "user"  => USER,
        "repo"  => REPO,
      },
      "base"          => {
        "label" => "master",
        "ref"   => "master",
        "sha"   => "6dcb09b5b57875f334f61aebed695e2e4193db5e",
        "user"  => USER,
        "repo"  => REPO,
      }
    })

    COMMIT = {
    }

    COMMIT_COMMENT = {
      "url"        => "https://api.github.com/repos/octocat/Hello-World/pulls/comments/1",
      "id"         => 1,
      "body"       => "Great stuff",
      "path"       => "file1.txt",
      "position"   => 4,
      "commit_id"  => "6dcb09b5b57875f334f61aebed695e2e4193db5e",
      "user"       => USER,
      "created_at" => "2011-04-14T16:00:49Z",
      "updated_at" => "2011-04-14T16:00:49Z"
    }

    FILE = {
      "sha"       => "6dcb09b5b57875f334f61aebed695e2e4193db5e",
      "filename"  => "file1.txt",
      "status"    => "added",
      "additions" => 103,
      "deletions" => 21,
      "changes"   => 124,
      "blob_url"  => "https://github.com/octocate/Hello-World/blob/6dcb09b5b57875f334f61aebed695e2e4193db5e/file1.txt",
      "raw_url"   => "https://github.com/octocate/Hello-World/raw/6dcb09b5b57875f334f61aebed695e2e4193db5e/file1.txt",
      "patch"     => "@@ -132,7 +132,7 @@ module Test @@ -1000,7 +1000,7 @@ module Test"
    }

    PULL_COMMENT = {
      "url"        => "https://api.github.com/repos/octocat/Hello-World/pulls/comments/1",
      "id"         => 1,
      "body"       => "Great stuff",
      "path"       => "file1.txt",
      "position"   => 4,
      "commit_id"  => "6dcb09b5b57875f334f61aebed695e2e4193db5e",
      "user"       => USER,
      "created_at" => "2011-04-14T16:00:49Z",
      "updated_at" => "2011-04-14T16:00:49Z"
    }

    DOWNLOAD = {
      "url"            => "https://api.github.com/repos/octocat/Hello-World/downloads/1",
      "html_url"       => "https://github.com/repos/octocat/Hello-World/downloads/filename",
      "id"             => 1,
      "name"           => "file.zip",
      "description"    => "The latest release",
      "size"           => 1024,
      "download_count" => 40
    }

    CREATE_DOWNLOAD = DOWNLOAD.merge({
      "policy"         => "hash",
      "signature"      => "hash",
      "bucket"         => "hash",
      "accesskeyid"    => "hash",
      "path"           => "file.zip",
      "acl"            => "public-read",
      "expirationdate" => "2011-04-14T16:00:49Z",
      "prefix"         => "downloads/octocat/Hello-World/",
      "mime_type"      => "application/octet-stream",
      "redirect"       => false
    })

    ORG = {
      "login"      => "github",
      "id"         => 1,
      "url"        => "https://api.github.com/orgs/1",
      "avatar_url" => "https://github.com/images/error/octocat_happy.gif"
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
        "private_repos" => 20
      }
    })

    TEAM = {
      "url" => "https://api.github.com/teams/1",
      "name" => "Owners",
      "id" => 1
    }

    FULL_TEAM = TEAM.merge({
      "permission" => "admin",
      "members_count" => 3,
      "repos_count" => 10
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
  end
end

include GitHub::Resources::Helpers
