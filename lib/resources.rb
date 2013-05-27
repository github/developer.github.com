require 'pp'
require 'yajl/json_gem'
require 'stringio'
require 'cgi'
require 'securerandom'

module GitHub
  module Resources
    module Helpers
      STATUSES = {
        200 => '200 OK',
        201 => '201 Created',
        202 => '202 Accepted',
        204 => '204 No Content',
        205 => '205 Reset Content',
        301 => '301 Moved Permanently',
        302 => '302 Found',
        307 => '307 Temporary Redirect',
        304 => '304 Not Modified',
        401 => '401 Unauthorized',
        403 => '403 Forbidden',
        404 => '404 Not Found',
        405 => '405 Method not allowed',
        409 => '409 Conflict',
        422 => '422 Unprocessable Entity',
        500 => '500 Server Error'
      }

      AUTHORS = {
        :technoweenie => '821395fe70906c8290df7f18ac4ac6cf',
        :pengwynn     => '7e19cd5486b5d6dc1ef90e671ba52ae0',
        :pezra        => 'f38112009dc16547051c8ac246cee443',
        :rick         => 'a44d5abad6e86cff4e34d9f0839535c9',
        :agh          => '6af915d3c6aa4ad30bbad43d8035fe10',
        :jasonrudolph => '592e1e6f041f9a4ec51846fd82013aea',
        :Caged        => '97c3a8eea9b7eaa9e1e93ea3cd47399f',
        :foca         => 'd0ca2bf32bda9e9ea8c4473ffc3aaa0d',
        :ymendel      => 'b1b1d33e0655e841d4fd8467359c58d0'
      }

      DefaultTimeFormat = "%B %-d, %Y".freeze

      def post_date(item)
        strftime item[:created_at]
      end

      def strftime(time, format = DefaultTimeFormat)
        attribute_to_time(time).strftime(format)
      end

      def gravatar_for(login)
        %(<img height="16" width="16" src="%s" />) % gravatar_url_for(login)
      end

      def gravatar_url_for(login)
        md5 = AUTHORS[login.to_sym]
        default = "https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"
        "https://secure.gravatar.com/avatar/%s?s=20&d=%s" %
          [md5, default]
      end

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

      def text_html(response, status, head = {})
        hs = headers(status, head.merge('Content-Type' => 'text/html'))
        res = CGI.escapeHTML(response)
        hs + %(<pre class="highlight"><code>) + res + "</code></pre>"
      end

    end

    USER = {
      "login"        => "octocat",
      "id"           => 1,
      "avatar_url"   => "https://github.com/images/error/octocat_happy.gif",
      "gravatar_id"  => "somehexcode",
      "url"          => "https://api.github.com/users/octocat"
    }

    CONTRIBUTOR = USER.merge({
      "contributions" => 32
    })

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

    SIMPLE_PUBLIC_KEY = {
      "id"    => 1,
      "key"   => "ssh-rsa AAA..."
    }

    PUBLIC_KEY = SIMPLE_PUBLIC_KEY.merge \
      "url"   => "https://api.github.com/user/keys/1",
      "title" => "octocat@octomac"

    SIMPLE_REPO = {
      "id"               => 1296269,
      "owner"            => USER,
      "name"             => "Hello-World",
      "full_name"        => "octocat/Hello-World",
      "description"      => "This your first repo!",
      "private"          => false,
      "fork"             => false,
      "url"              => "https://api.github.com/repos/octocat/Hello-World",
      "html_url"         => "https://github.com/octocat/Hello-World"
    }

    REPO = SIMPLE_REPO.merge({
      "clone_url"        => "https://github.com/octocat/Hello-World.git",
      "git_url"          => "git://github.com/octocat/Hello-World.git",
      "ssh_url"          => "git@github.com:octocat/Hello-World.git",
      "svn_url"          => "https://svn.github.com/octocat/Hello-World",
      "mirror_url"       => "git://git.example.com/octocat/Hello-World",
      "homepage"         => "https://github.com",
      "language"         => nil,
      "forks"            => 9,
      "forks_count"      => 9,
      "watchers"         => 80,
      "watchers_count"   => 80,
      "size"             => 108,
      "master_branch"    => 'master',
      "open_issues"      => 0,
      "pushed_at"        => "2011-01-26T19:06:43Z",
      "created_at"       => "2011-01-26T19:01:12Z",
      "updated_at"       => "2011-01-26T19:14:43Z"
    })

    FULL_REPO = REPO.merge({
      "organization"     => USER.merge('type' => 'Organization'),
      "parent"           => REPO,
      "source"           => REPO,
      "has_issues"       => true,
      "has_wiki"         => true,
      "has_downloads"    => true
    })

    TAG = {
      "name"        => "v0.1",
      "commit"      => {
          "sha"     => "c5b97d5ae6c19d5c5df71a34c7fbeeda2479ccbc",
          "url"  => "https://api.github.com/octocat/Hello-World/commits/c5b97d5ae6c19d5c5df71a34c7fbeeda2479ccbc"
      },
      "zipball_url" => "https://github.com/octocat/Hello-World/zipball/v0.1",
      "tarball_url" => "https://github.com/octocat/Hello-World/tarball/v0.1",
    }

    BRANCHES = [
      {
        "name"   => "master",
        "commit" => {
          "sha" => "6dcb09b5b57875f334f61aebed695e2e4193db5e",
          "url" => "https://api.github.com/repos/octocat/Hello-World/commits/c5b97d5ae6c19d5c5df71a34c7fbeeda2479ccbc"
        }
      }
    ]

    BRANCH = {"name"=>"master",
 "commit"=>
  {"sha"=>"7fd1a60b01f91b314f59955a4e4d4e80d8edf11d",
   "commit"=>
    {"author"=>
      {"name"=>"The Octocat",
       "date"=>"2012-03-06T15:06:50-08:00",
       "email"=>"octocat@nowhere.com"},
     "url"=>
      "https://api.github.com/repos/octocat/Hello-World/git/commits/7fd1a60b01f91b314f59955a4e4d4e80d8edf11d",
     "message"=>
      "Merge pull request #6 from Spaceghost/patch-1\n\nNew line at end of file.",
     "tree"=>
      {"sha"=>"b4eecafa9be2f2006ce1b709d6857b07069b4608",
       "url"=>
        "https://api.github.com/repos/octocat/Hello-World/git/trees/b4eecafa9be2f2006ce1b709d6857b07069b4608"},
     "committer"=>
      {"name"=>"The Octocat",
       "date"=>"2012-03-06T15:06:50-08:00",
       "email"=>"octocat@nowhere.com"}},
   "author"=>
    {"gravatar_id"=>"7ad39074b0584bc555d0417ae3e7d974",
     "avatar_url"=>
      "https://secure.gravatar.com/avatar/7ad39074b0584bc555d0417ae3e7d974?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
     "url"=>"https://api.github.com/users/octocat",
     "id"=>583231,
     "login"=>"octocat"},
   "parents"=>
    [{"sha"=>"553c2077f0edc3d5dc5d17262f6aa498e69d6f8e",
      "url"=>
       "https://api.github.com/repos/octocat/Hello-World/commits/553c2077f0edc3d5dc5d17262f6aa498e69d6f8e"},
     {"sha"=>"762941318ee16e59dabbacb1b4049eec22f0d303",
      "url"=>
       "https://api.github.com/repos/octocat/Hello-World/commits/762941318ee16e59dabbacb1b4049eec22f0d303"}],
   "url"=>
    "https://api.github.com/repos/octocat/Hello-World/commits/7fd1a60b01f91b314f59955a4e4d4e80d8edf11d",
   "committer"=>
    {"gravatar_id"=>"7ad39074b0584bc555d0417ae3e7d974",
     "avatar_url"=>
      "https://secure.gravatar.com/avatar/7ad39074b0584bc555d0417ae3e7d974?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
     "url"=>"https://api.github.com/users/octocat",
     "id"=>583231,
     "login"=>"octocat"}},
 "_links"=>
  {"html"=>"https://github.com/octocat/Hello-World/tree/master",
   "self"=>"https://api.github.com/repos/octocat/Hello-World/branches/master"}}

 MERGE_COMMIT = {
  "sha" => "7fd1a60b01f91b314f59955a4e4d4e80d8edf11d",
  "commit" => {
    "author" => {
      "name" => "The Octocat",
      "date" => "2012-03-06T15:06:50-08:00",
      "email" => "octocat@nowhere.com"
    },
    "committer" => {
      "name" => "The Octocat",
      "date" => "2012-03-06T15:06:50-08:00",
      "email" => "octocat@nowhere.com"
    },
    "message" => "Shipped cool_feature!",
    "tree" => {
      "sha" => "b4eecafa9be2f2006ce1b709d6857b07069b4608",
      "url" => "https://api.github.com/repos/octocat/Hello-World/git/trees/b4eecafa9be2f2006ce1b709d6857b07069b4608"
    },
    "url" => "https://api.github.com/repos/octocat/Hello-World/git/commits/7fd1a60b01f91b314f59955a4e4d4e80d8edf11d",
    "comment_count" => 0
  },
  "url" => "https://api.github.com/repos/octocat/Hello-World/commits/7fd1a60b01f91b314f59955a4e4d4e80d8edf11d",
  "comments_url" => "https://api.github.com/repos/octocat/Hello-World/commits/7fd1a60b01f91b314f59955a4e4d4e80d8edf11d/comments",
  "author" => {
    "login" => "octocat",
    "id" => 583231,
    "avatar_url" => "https://secure.gravatar.com/avatar/7ad39074b0584bc555d0417ae3e7d974?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
    "gravatar_id" => "7ad39074b0584bc555d0417ae3e7d974",
    "url" => "https://api.github.com/users/octocat",
    "html_url" => "https://github.com/octocat",
    "followers_url" => "https://api.github.com/users/octocat/followers",
    "following_url" => "https://api.github.com/users/octocat/following",
    "gists_url" => "https://api.github.com/users/octocat/gists{/gist_id}",
    "starred_url" => "https://api.github.com/users/octocat/starred{/owner}{/repo}",
    "subscriptions_url" => "https://api.github.com/users/octocat/subscriptions",
    "organizations_url" => "https://api.github.com/users/octocat/orgs",
    "repos_url" => "https://api.github.com/users/octocat/repos",
    "events_url" => "https://api.github.com/users/octocat/events{/privacy}",
    "received_events_url" => "https://api.github.com/users/octocat/received_events",
    "type" => "User"
  },
  "committer" => {
    "login" => "octocat",
    "id" => 583231,
    "avatar_url" => "https://secure.gravatar.com/avatar/7ad39074b0584bc555d0417ae3e7d974?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
    "gravatar_id" => "7ad39074b0584bc555d0417ae3e7d974",
    "url" => "https://api.github.com/users/octocat",
    "html_url" => "https://github.com/octocat",
    "followers_url" => "https://api.github.com/users/octocat/followers",
    "following_url" => "https://api.github.com/users/octocat/following",
    "gists_url" => "https://api.github.com/users/octocat/gists{/gist_id}",
    "starred_url" => "https://api.github.com/users/octocat/starred{/owner}{/repo}",
    "subscriptions_url" => "https://api.github.com/users/octocat/subscriptions",
    "organizations_url" => "https://api.github.com/users/octocat/orgs",
    "repos_url" => "https://api.github.com/users/octocat/repos",
    "events_url" => "https://api.github.com/users/octocat/events{/privacy}",
    "received_events_url" => "https://api.github.com/users/octocat/received_events",
    "type" => "User"
  },
  "parents" => [
    {
      "sha" => "553c2077f0edc3d5dc5d17262f6aa498e69d6f8e",
      "url" => "https://api.github.com/repos/octocat/Hello-World/commits/553c2077f0edc3d5dc5d17262f6aa498e69d6f8e"
    },
    {
      "sha" => "762941318ee16e59dabbacb1b4049eec22f0d303",
      "url" => "https://api.github.com/repos/octocat/Hello-World/commits/762941318ee16e59dabbacb1b4049eec22f0d303"
    }
  ]
}

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
      },
      "_links" => {
        "self" => {'href' =>
          "https://api.github.com/octocat/Hello-World/pulls/1"},
        "html" => {'href' =>
          "https://github.com/octocat/Hello-World/pull/1"},
        "comments" => {'href' =>
          "https://api.github.com/octocat/Hello-World/issues/1/comments"},
        "review_comments" => {'href' =>
          "https://api.github.com/octocat/Hello-World/pulls/1/comments"}
      },
      "user" => USER
    }

    FULL_PULL = PULL.merge({
      "merge_commit_sha" =>  "e5bd3914e2e596debea16f433f57875b5b90bcd6",
      "merged"        => false,
      "mergeable"     => true,
      "merged_by"     => USER,
      "comments"      => 10,
      "commits"       => 3,
      "additions"     => 100,
      "deletions"     => 3,
      "changed_files" => 5
    })

    COMMIT = {
      "url" => "https://api.github.com/repos/octocat/Hello-World/commits/6dcb09b5b57875f334f61aebed695e2e4193db5e",
      "sha" => "6dcb09b5b57875f334f61aebed695e2e4193db5e",
      "commit" => {
        "url" => "https://api.github.com/repos/octocat/Hello-World/git/commits/6dcb09b5b57875f334f61aebed695e2e4193db5e",
        "author" => {
           "name"  => "Monalisa Octocat",
           "email" => "support@github.com",
           "date"  => "2011-04-14T16:00:49Z",
        },
        "committer" => {
           "name"  => "Monalisa Octocat",
           "email" => "support@github.com",
           "date"  => "2011-04-14T16:00:49Z",
        },
        "message" => "Fix all the bugs",
        "tree" => {
          "url" => "https://api.github.com/repos/octocat/Hello-World/tree/6dcb09b5b57875f334f61aebed695e2e4193db5e",
          "sha" => "6dcb09b5b57875f334f61aebed695e2e4193db5e",
        },
      },
      "author" => USER,
      "committer" => USER,
      "parents" => [{
        "url" => "https://api.github.com/repos/octocat/Hello-World/commits/6dcb09b5b57875f334f61aebed695e2e4193db5e",
        "sha" => "6dcb09b5b57875f334f61aebed695e2e4193db5e",
      }]
    }

    FULL_COMMIT = COMMIT.merge({
      "stats" => {
        "additions" => 104,
        "deletions" => 4,
        "total"     => 108,
      },
      "files" => [{
        "filename"  => "file1.txt",
        "additions" => 10,
        "deletions" => 2,
        "changes" => 12,
        "status" => "modified",
        "raw_url" => "https://github.com/octocat/Hello-World/raw/7ca483543807a51b6079e54ac4cc392bc29ae284/file1.txt",
        "blob_url" => "https://github.com/octocat/Hello-World/blob/7ca483543807a51b6079e54ac4cc392bc29ae284/file1.txt",
        "patch" => "@@ -29,7 +29,7 @@\n....."
      }]
    })

    COMMIT_COMMENT = {
      "html_url"   => "https://github.com/octocat/Hello-World/commit/6dcb09b5b57875f334f61aebed695e2e4193db5e#commitcomment-1",
      "url"        => "https://api.github.com/repos/octocat/Hello-World/comments/1",
      "id"         => 1,
      "body"       => "Great stuff",
      "path"       => "file1.txt",
      "position"   => 4,
      "line"       => 14,
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
      "blob_url"  => "https://github.com/octocat/Hello-World/blob/6dcb09b5b57875f334f61aebed695e2e4193db5e/file1.txt",
      "raw_url"   => "https://github.com/octocat/Hello-World/raw/6dcb09b5b57875f334f61aebed695e2e4193db5e/file1.txt",
      "patch"     => "@@ -132,7 +132,7 @@ module Test @@ -1000,7 +1000,7 @@ module Test"
    }

    COMMIT_COMPARISON = {
      "url" => "https://api.github.com/repos/octocat/Hello-World/compare/master...topic",
      "html_url" => "https://github.com/octocat/Hello-World/compare/master...topic",
      "permalink_url" => "https://github.com/octocat/Hello-World/compare/octocat:bbcd538c8e72b8c175046e27cc8f907076331401...octocat:0328041d1152db8ae77652d1618a02e57f745f17",
      "diff_url" => "https://github.com/octocat/Hello-World/compare/master...topic.diff",
      "patch_url" => "https://github.com/octocat/Hello-World/compare/master...topic.patch",
      "base_commit" => COMMIT,
      "status" => "behind",
      "ahead_by" => 1,
      "behind_by" => 2,
      "total_commits" => 1,
      "commits" => [COMMIT],
      "files" => [FILE],
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
      "updated_at" => "2011-04-14T16:00:49Z",
      "_links" => {
        "self" => {'href' =>
          "https://api.github.com/octocat/Hello-World/pulls/comments/1"},
        "html" => {'href' =>
          "https://github.com/octocat/Hello-World/pull/1#discussion-diff-1"},
        "pull_request" => {'href' =>
          "https://api.github.com/octocat/Hello-World/pulls/1"}
      }
    }

    DOWNLOAD = {
      "url"            => "https://api.github.com/repos/octocat/Hello-World/downloads/1",
      "html_url"       => "https://github.com/repos/octocat/Hello-World/downloads/new_file.jpg",
      "id"             => 1,
      "name"           => "new_file.jpg",
      "description"    => "Description of your download",
      "size"           => 1024,
      "download_count" => 40,
      "content_type"   => ".jpg"
    }

    CREATE_DOWNLOAD = DOWNLOAD.merge({
      "policy"         => "ewogICAg...",
      "signature"      => "mwnFDC...",
      "bucket"         => "github",
      "accesskeyid"    => "1ABCDEFG...",
      "path"           => "downloads/octocat/Hello-World/new_file.jpg",
      "acl"            => "public-read",
      "expirationdate" => "2011-04-14T16:00:49Z",
      "prefix"         => "downloads/octocat/Hello-World/",
      "mime_type"      => "image/jpeg",
      "redirect"       => false,
      "s3_url"         => "https://github.s3.amazonaws.com/"
    })

    ORG = {
      "login"      => "github",
      "id"         => 1,
      "url"        => "https://api.github.com/orgs/github",
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

    LABEL = {
      "url"   => "https://api.github.com/repos/octocat/Hello-World/labels/bug",
      "name"  => "bug",
      "color" => "f29513"
    }

    ISSUE = {
      "url"        => "https://api.github.com/repos/octocat/Hello-World/issues/1347",
      "html_url"   => "https://github.com/octocat/Hello-World/issues/1347",
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
        "html_url"  => "https://github.com/octocat/Hello-World/issues/1347",
        "diff_url"  => "https://github.com/octocat/Hello-World/issues/1347.diff",
        "patch_url" => "https://github.com/octocat/Hello-World/issues/1347.patch"
      },
      "closed_at"  => nil,
      "created_at" => "2011-04-22T13:33:48Z",
      "updated_at" => "2011-04-22T13:33:48Z"
    }

    ISSUE_COMMENT = {
      "id"         => 1,
      "url"        => "https://api.github.com/repos/octocat/Hello-World/issues/comments/1",
      "html_url"   => "https://github.com/octocat/Hello-World/issues/1347#issuecomment-1",
      "body"       => "Me too",
      "user"       => USER,
      "created_at" => "2011-04-14T16:00:49Z",
      "updated_at" => "2011-04-14T16:00:49Z"
    }

    ISSUE_EVENT = {
      "url" => "https://api.github.com/repos/octocat/Hello-World/issues/events/1",
      "actor"      => USER,
      "event"      => "closed",
      "commit_id"  => "6dcb09b5b57875f334f61aebed695e2e4193db5e",
      "created_at" => "2011-04-14T16:00:49Z"
    }

    FULL_ISSUE_EVENT = ISSUE_EVENT.merge('issue' => ISSUE)

    ISSUE_SEARCH_ITEM = {
      "gravatar_id" =>  "4c3d600867886124a73f14a907b1a955",
      "position" =>  10,
      "number" =>  10,
      "votes" =>  2,
      "created_at" =>  "2010-06-04T23:20:33Z",
      "comments" =>  5,
      "body" =>  "Issue body goes here",
      "title" =>  "This is is the issue title",
      "updated_at" =>  "2010-06-04T23:20:33Z",
      "html_url" =>  "https://github.com/pengwynn/linkedin/issues/10",
      "user" =>  "ckarbass",
      "labels" =>  [
        "api",
        "feature request",
        "investigation"
      ],
      "state" =>  "open"
    }

    ISSUE_SEARCH_RESULTS = {
      "issues" => [ISSUE_SEARCH_ITEM]
    }

    REPO_SEARCH_ITEM = {
      "type" => "repo",
      "created" => "2011-09-05T11:07:54Z",
      "watchers" => 2913,
      "has_downloads" => true,
      "username" => "mathiasbynens",
      "homepage" => "http://mths.be/dotfiles",
      "url" => "https://github.com/mathiasbynens/dotfiles",
      "fork" => false,
      "has_issues" => true,
      "has_wiki" => false,
      "forks" => 520,
      "size" => 192,
      "private" => false,
      "followers" => 2913,
      "name" => "dotfiles",
      "owner" => "mathiasbynens",
      "open_issues" => 12,
      "pushed_at" => "2012-06-05T03:37:13Z",
      "score" => 3.289718,
      "pushed" => "2012-06-05T03:37:13Z",
      "description" => "sensible hacker defaults for OS X",
      "language" => "VimL",
      "created_at" => "2011-09-05T11:07:54Z"
    }

    REPO_SEARCH_RESULTS = {
      "repositories" => [REPO_SEARCH_ITEM]
    }

    USER_SEARCH_ITEM = {
      "gravatar_id" => "70889091349f7598bce9afa588034310",
      "name" => "Hirotaka Kawata",
      "created_at" => "2009-10-05T01:32:06Z",
      "location" => "Tsukuba, Ibaraki, Japan",
      "public_repo_count" => 8,
      "followers" => 10,
      "language" => "Python",
      "fullname" => "Hirotaka Kawata",
      "username" => "techno",
      "id" => "user-135050",
      "repos" => 8,
      "type" => "user",
      "followers_count" => 10,
      "login" => "techno",
      "score" => 4.2559967,
      "created" => "2009-10-05T01:32:06Z"
    }

    USER_SEARCH_RESULTS = {
      "users" => [USER_SEARCH_ITEM]
    }

    EMAIL_SEARCH_RESULTS = {
      "user" => {
        "public_repo_count" => 2,
        "public_gist_count" => 1,
        "followers_count"   => 20,
        "following_count"   => 0,
        "created"           => "2009-10-05T01:32:06Z",
        "created_at"        => "2009-10-05T01:32:06Z",
        "name"              => "monalisa octocat",
        "company"           => "GitHub",
        "blog"              => "https://github.com/blog",
        "location"          => "San Francisco",
        "email"             => "octocat@github.com",
        "id"                => 2,
        "login"             => "octocat",
        "type"              => "User",
        "gravatar_id"       => "70889091349f7598bce9afa588034310",
      }
    }

    GIST_HISTORY = {
      "history" => [
        {
          "url"     => "https://api.github.com/gists/#{SecureRandom.hex(10)}",
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
          "url" => "https://api.github.com/gists/#{SecureRandom.hex(10)}",
          "created_at" => "2011-04-14T16:00:49Z"
        }
      ]
    }

    GIST_FILE = {
      "size"     => 932,
      "filename" => "ring.erl",
      "raw_url"  => "https://gist.github.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl"
    }

    GIST = {
      "url"          => "https://api.github.com/gists/#{SecureRandom.hex(10)}",
      "id"           => "1",
      "description"  => "description of gist",
      "public"       => true,
      "user"         => USER,
      "files"        => { "ring.erl" => GIST_FILE },
      "comments"     => 0,
      "comments_url" => "https://api.github.com/gists/#{SecureRandom.hex(10)}/comments/",
      "html_url"     => "https://gist.github.com/1",
      "git_pull_url" => "git://gist.github.com/1.git",
      "git_push_url" => "git@gist.github.com:1.git",
      "created_at"   => "2010-04-14T02:15:15Z"
    }

    FULL_GIST = GIST.merge(GIST_FORKS).merge(GIST_HISTORY)
    FULL_GIST['files'].merge('ring.erl' => GIST_FILE.merge('content' => 'contents of gist'))

    GIST_COMMENT = {
      "id"         => 1,
      "url"        => "https://api.github.com/gists/#{SecureRandom.hex(10)}/comments/1",
      "body"       => "Just commenting for the sake of commenting",
      "user"       => USER,
      "created_at" => "2011-04-18T23:23:56Z"
    }

    TREE = {
      "sha"  => "9fb037999f264ba9a7fc6274d15fa3ae2ab98312",
      "url"  => "https://api.github.com/repos/octocat/Hello-World/trees/9fb037999f264ba9a7fc6274d15fa3ae2ab98312",
      "tree"  => [
        { "path" => "file.rb",
          "mode" => "100644",
          "type" => "blob",
          "size" => 30,
          "sha"  => "44b4fc6d56897b048c772eb4087f854f46256132",
          "url"  => "https://api.github.com/repos/octocat/Hello-World/git/blobs/44b4fc6d56897b048c772eb4087f854f46256132",
        },
        { "path" => "subdir",
          "mode" => "040000",
          "type" => "tree",
          "sha"  => "f484d249c660418515fb01c2b9662073663c242e",
          "url"  => "https://api.github.com/repos/octocat/Hello-World/git/blobs/f484d249c660418515fb01c2b9662073663c242e"
        },
        { "path" => "exec_file",
          "mode" => "100755",
          "type" => "blob",
          "size" => 75,
          "sha"  => "45b983be36b73c0788dc9cbcb76cbb80fc7bb057",
          "url"  => "https://api.github.com/repos/octocat/Hello-World/git/blobs/45b983be36b73c0788dc9cbcb76cbb80fc7bb057",
        }
      ]
    }
    TREE_EXTRA = {
      "sha"  => "fc6274d15fa3ae2ab983129fb037999f264ba9a7",
      "url"  => "https://api.github.com/repo/octocat/Hello-World/trees/fc6274d15fa3ae2ab983129fb037999f264ba9a7",
      "tree" => [ {
          "path" => "subdir/file.txt",
          "mode" => "100644",
          "type" => "blob",
          "size" => 132,
          "sha"  => "7c258a9869f33c1e1e1f74fbb32f07c86cb5a75b",
          "url"  => "https://api.github.com/octocat/Hello-World/git/7c258a9869f33c1e1e1f74fbb32f07c86cb5a75b"
      } ]
    }
    TREE_NEW = {
      "sha"  => "cd8274d15fa3ae2ab983129fb037999f264ba9a7",
      "url"  => "https://api.github.com/repo/octocat/Hello-World/trees/cd8274d15fa3ae2ab983129fb037999f264ba9a7",
      "tree" => [ {
          "path" => "file.rb",
          "mode" => "100644",
          "type" => "blob",
          "size" => 132,
          "sha"  => "7c258a9869f33c1e1e1f74fbb32f07c86cb5a75b",
          "url"  => "https://api.github.com/octocat/Hello-World/git/blobs/7c258a9869f33c1e1e1f74fbb32f07c86cb5a75b"
      } ]
    }

    GIT_COMMIT = {
      "sha" => "7638417db6d59f3c431d3e1f261cc637155684cd",
      "url" => "https://api.github.com/repos/octocat/Hello-World/git/commits/7638417db6d59f3c431d3e1f261cc637155684cd",
      "author" => {
        "date" => "2010-04-10T14:10:01-07:00",
        "name" => "Scott Chacon",
        "email" => "schacon@gmail.com"
      },
      "committer" => {
        "date" => "2010-04-10T14:10:01-07:00",
        "name" => "Scott Chacon",
        "email" => "schacon@gmail.com"
      },
      "message" => "added readme, because im a good github citizen\n",
      "tree" => {
        "url" => "https://api.github.com/repos/octocat/Hello-World/git/trees/691272480426f78a0138979dd3ce63b77f706feb",
        "sha" => "691272480426f78a0138979dd3ce63b77f706feb"
      },
      "parents" => [
        {
          "url" => "https://api.github.com/repos/octocat/Hello-World/git/commits/1acc419d4d6a9ce985db7be48c6349a0475975b5",
          "sha" => "1acc419d4d6a9ce985db7be48c6349a0475975b5"
        }
      ]
    }

    NEW_COMMIT = {
      "sha" => "7638417db6d59f3c431d3e1f261cc637155684cd",
      "url" => "https://api.github.com/repos/octocat/Hello-World/git/commits/7638417db6d59f3c431d3e1f261cc637155684cd",
      "author" => {
        "date" => "2008-07-09T16:13:30+12:00",
        "name" => "Scott Chacon",
        "email" => "schacon@gmail.com"
      },
      "committer" => {
        "date" => "2008-07-09T16:13:30+12:00",
        "name" => "Scott Chacon",
        "email" => "schacon@gmail.com"
      },
      "message" => "my commit message",
      "tree" => {
        "url" => "https://api.github.com/repos/octocat/Hello-World/git/trees/827efc6d56897b048c772eb4087f854f46256132",
        "sha" => "827efc6d56897b048c772eb4087f854f46256132"
      },
      "parents" => [
        {
          "url" => "https://api.github.com/repos/octocat/Hello-World/git/commits/7d1b31e74ee336d15cbd21741bc88a537ed063a0",
          "sha" => "7d1b31e74ee336d15cbd21741bc88a537ed063a0"
        }
      ]
    }

    GITTAG = {
      "tag" => "v0.0.1",
      "sha" => "940bd336248efae0f9ee5bc7b2d5c985887b16ac",
      "url" => "https://api.github.com/repos/octocat/Hello-World/git/tags/940bd336248efae0f9ee5bc7b2d5c985887b16ac",
      "message" => "initial version\n",
      "tagger" => {
        "name" => "Scott Chacon",
        "email" => "schacon@gmail.com",
        "date" => "2011-06-17T14:53:35-07:00"
      },
      "object" => {
        "type" => "commit",
        "sha" => "c3d0be41ecbe669545ee3e94d31ed9a4bc91ee3c",
        "url" => "https://api.github.com/repos/octocat/Hello-World/git/commits/c3d0be41ecbe669545ee3e94d31ed9a4bc91ee3c"
      }
    }

    REF = {
      "ref" => "refs/heads/sc/featureA",
      "url" => "https://api.github.com/repos/octocat/Hello-World/git/refs/heads/sc/featureA",
      "object" => {
        "type" => "commit",
        "sha" => "aa218f56b14c9653891f9e74264a383fa43fefbd",
        "url" => "https://api.github.com/repos/octocat/Hello-World/git/commits/aa218f56b14c9653891f9e74264a383fa43fefbd"
      }
    }

    REFS = [
      {
        "ref" => "refs/heads/master",
        "url" => "https://api.github.com/repos/octocat/Hello-World/git/refs/heads/master",
        "object" => {
          "type" => "commit",
          "sha" => "aa218f56b14c9653891f9e74264a383fa43fefbd",
          "url" => "https://api.github.com/repos/octocat/Hello-World/git/commits/aa218f56b14c9653891f9e74264a383fa43fefbd"
        }
      },
      {
        "ref" => "refs/heads/gh-pages",
        "url" => "https://api.github.com/repos/octocat/Hello-World/git/refs/heads/gh-pages",
        "object" => {
          "type" => "commit",
          "sha" => "612077ae6dffb4d2fbd8ce0cccaa58893b07b5ac",
          "url" => "https://api.github.com/repos/octocat/Hello-World/git/commits/612077ae6dffb4d2fbd8ce0cccaa58893b07b5ac"
        }
      },
      {
        "ref" => "refs/tags/v0.0.1",
        "url" => "https://api.github.com/repos/octocat/Hello-World/git/refs/tags/v0.0.1",
        "object" => {
          "type" => "tag",
          "sha" => "940bd336248efae0f9ee5bc7b2d5c985887b16ac",
          "url" => "https://api.github.com/repos/octocat/Hello-World/git/tags/940bd336248efae0f9ee5bc7b2d5c985887b16ac"
        }
      }
    ]

    HOOK = {
      "url" => "https://api.github.com/repos/octocat/Hello-World/hooks/1",
      "updated_at" => "2011-09-06T20:39:23Z",
      "created_at" => "2011-09-06T17:26:27Z",
      "name" => "web",
      "events" => ["push", "pull_request"],
      "active" => true,
      "config" =>
        {'url' => 'http://example.com', 'content_type' => 'json'},
      "id" => 1
    }

    OAUTH_ACCESS = {
      "id" => 1,
      "url" => "https://api.github.com/authorizations/1",
      "scopes" => ["public_repo"],
      "token" => "abc123",
      "app" => {
        "url" => "http://my-github-app.com",
        "name" => "my github app",
        "client_id" => "abcde12345fghij67890"
      },
      "note" => "optional note",
      "note_url" => "http://optional/note/url",
      "updated_at" => "2011-09-06T20:39:23Z",
      "created_at" => "2011-09-06T17:26:27Z"
    }

    OAUTH_ACCESS_WITH_USER = OAUTH_ACCESS.merge(:user => USER)

    EVENT = {
      :type   => "Event",
      :public => true,
      :payload => {},
      :repo => {
        :id => 3,
        :name => "octocat/Hello-World",
        :url => "https://api.github.com/repos/octocat/Hello-World"
      },
      :actor => USER,
      :org => USER,
      :created_at => "2011-09-06T17:26:27Z",
      :id => "12345"
    }

    README_CONTENT = {
      "type" =>  "file",
      "encoding" =>  "base64",
      "size" =>  5362,
      "name" =>  "README.md",
      "path" =>  "README.md",
      "content" =>  "encoded content ...",
      "sha" =>  "3d21ec53a331a6f037a91c368710b99387d012c1",
      "url" => "https://api.github.com/repos/pengwynn/octokit/contents/README.md",
      "git_url" => "https://api.github.com/repos/pengwynn/octokit/git/blobs/3d21ec53a331a6f037a91c368710b99387d012c1",
      "html_url" => "https://github.com/pengwynn/octokit/blob/master/README.md",
      "_links" =>  {
        "git" =>  "https://api.github.com/repos/pengwynn/octokit/git/blobs/3d21ec53a331a6f037a91c368710b99387d012c1",
        "self" =>  "https://api.github.com/repos/pengwynn/octokit/contents/README.md",
        "html" =>  "https://github.com/pengwynn/octokit/blob/master/README.md"
      },
    }

    SYMLINK_CONTENT = {
      "type" => "symlink",
      "target" => "/path/to/symlink/target",
      "size" => 23,
      "name" => "some-symlink",
      "path" => "bin/some-symlink",
      "sha" => "452a98979c88e093d682cab404a3ec82babebb48",
      "url" => "https://api.github.com/repos/pengwynn/octokit/contents/bin/some-symlink",
      "git_url" => "https://api.github.com/repos/pengwynn/octokit/git/blobs/452a98979c88e093d682cab404a3ec82babebb48",
      "html_url" => "https://github.com/pengwynn/octokit/blob/master/bin/some-symlink",
      "_links" => {
        "git" => "https://api.github.com/repos/pengwynn/octokit/git/blobs/452a98979c88e093d682cab404a3ec82babebb48",
        "self" => "https://api.github.com/repos/pengwynn/octokit/contents/bin/some-symlink",
        "html" => "https://github.com/pengwynn/octokit/blob/master/bin/some-symlink"
      },
    }

    SUBMODULE_CONTENT = {
      "type" => "submodule",
      "submodule_git_url" => "git://github.com/jquery/qunit.git",
      "size" => 0,
      "name" => "qunit",
      "path" => "test/qunit",
      "sha" => "6ca3721222109997540bd6d9ccd396902e0ad2f9",
      "url" => "https://api.github.com/repos/jquery/jquery/contents/test/qunit?ref=master",
      "git_url" => "https://api.github.com/repos/jquery/qunit/git/trees/6ca3721222109997540bd6d9ccd396902e0ad2f9",
      "html_url" => "https://github.com/jquery/qunit/tree/6ca3721222109997540bd6d9ccd396902e0ad2f9",
      "_links" => {
        "git" => "https://api.github.com/repos/jquery/qunit/git/trees/6ca3721222109997540bd6d9ccd396902e0ad2f9",
        "self" => "https://api.github.com/repos/jquery/jquery/contents/test/qunit?ref=master",
        "html" => "https://github.com/jquery/qunit/tree/6ca3721222109997540bd6d9ccd396902e0ad2f9"
      }
    }

    DIRECTORY_CONTENT = [
      {
        "type" => "file",
        "size" => 625,
        "name" => "octokit.rb",
        "path" => "lib/octokit.rb",
        "sha" => "fff6fe3a23bf1c8ea0692b4a883af99bee26fd3b",
        "url" => "https://api.github.com/repos/pengwynn/octokit/contents/lib/octokit.rb",
        "git_url" => "https://api.github.com/repos/pengwynn/octokit/git/blobs/fff6fe3a23bf1c8ea0692b4a883af99bee26fd3b",
        "html_url" => "https://github.com/pengwynn/octokit/blob/master/lib/octokit.rb",
        "_links" => {
          "self" => "https://api.github.com/repos/pengwynn/octokit/contents/lib/octokit.rb",
          "git" => "https://api.github.com/repos/pengwynn/octokit/git/blobs/fff6fe3a23bf1c8ea0692b4a883af99bee26fd3b",
          "html" => "https://github.com/pengwynn/octokit/blob/master/lib/octokit.rb",
        },
      },
      {
        "type" => "dir",
        "size" => 0,
        "name" => "octokit",
        "path" => "lib/octokit",
        "sha" => "a84d88e7554fc1fa21bcbc4efae3c782a70d2b9d",
        "url" => "https://api.github.com/repos/pengwynn/octokit/contents/lib/octokit",
        "git_url" => "https://api.github.com/repos/pengwynn/octokit/git/trees/a84d88e7554fc1fa21bcbc4efae3c782a70d2b9d",
        "html_url" => "https://github.com/pengwynn/octokit/tree/master/lib/octokit",
        "_links" => {
          "self" => "https://api.github.com/repos/pengwynn/octokit/contents/lib/octokit",
          "git" => "https://api.github.com/repos/pengwynn/octokit/git/trees/a84d88e7554fc1fa21bcbc4efae3c782a70d2b9d",
          "html" => "https://github.com/pengwynn/octokit/tree/master/lib/octokit"
        },
      },
    ]

    STATUS = {
      "created_at" => "2012-07-20T01:19:13Z",
      "updated_at" => "2012-07-20T01:19:13Z",
      "state" => "success",
      "target_url" => "https://ci.example.com/1000/output",
      "description" => "Build has completed successfully",
      "id" => 1,
      "url" => "https://api.github.com/repos/octocat/example/statuses/1",
      "creator" => USER
    }

    META = {
      :hooks => ['127.0.0.1/32'],
      :git => ['127.0.0.1/32']
    }

    BLOB = {
      :content => "Content of the blob",
      :encoding => "utf-8",
      :sha => "3a0f86fb8db8eea7ccbb9a95f325ddbedfb25e15",
      :size => 100
    }

    CONTENT_CRUD = {
      "content" => {
        "name" => "hellothere",
        "path" => "hellothere",
        "sha" => "95b966ae1c166bd92f8ae7d1c313e738c731dfc3",
        "size" => 9,
        "url" => "https://api.github.com/repos/octocat/Hello-World/contents/hellothere",
        "html_url" => "https://github.com/octocat/Hello-World/blob/master/hellothere",
        "git_url" => "https://api.github.com/repos/octocat/Hello-World/git/blobs/95b966ae1c166bd92f8ae7d1c313e738c731dfc3",
        "type" => "file",
        "_links" => {
          "self" => "https://api.github.com/repos/octocat/Hello-World/contents/hellothere",
          "git" => "https://api.github.com/repos/octocat/Hello-World/git/blobs/95b966ae1c166bd92f8ae7d1c313e738c731dfc3",
          "html" => "https://github.com/octocat/Hello-World/blob/master/hellothere"
        }
      },
      "commit" => {
        "sha" => "7638417db6d59f3c431d3e1f261cc637155684cd",
        "url" => "https://api.github.com/repos/octocat/Hello-World/git/commits/7638417db6d59f3c431d3e1f261cc637155684cd",
        "html_url" => "https://github.com/octocat/Hello-World/git/commit/7638417db6d59f3c431d3e1f261cc637155684cd",
        "author" => {
          "date" => "2010-04-10T14:10:01-07:00",
          "name" => "Scott Chacon",
          "email" => "schacon@gmail.com"
        },
        "committer" => {
          "date" => "2010-04-10T14:10:01-07:00",
          "name" => "Scott Chacon",
          "email" => "schacon@gmail.com"
        },
        "message" => "my commit message",
        "tree" => {
          "url" => "https://api.github.com/repos/octocat/Hello-World/git/trees/691272480426f78a0138979dd3ce63b77f706feb",
          "sha" => "691272480426f78a0138979dd3ce63b77f706feb"
        },
        "parents" => [
          {
            "url" => "https://api.github.com/repos/octocat/Hello-World/git/commits/1acc419d4d6a9ce985db7be48c6349a0475975b5",
            "html_url" => "https://github.com/octocat/Hello-World/git/commit/1acc419d4d6a9ce985db7be48c6349a0475975b5",
            "sha" => "1acc419d4d6a9ce985db7be48c6349a0475975b5"
          }
        ]
      }
    }

    THREAD = {
      :id => 1,
      :repository => SIMPLE_REPO,
      :subject => {
        :title => "Greetings",
        :url => "https://api.github.com/repos/pengwynn/octokit/issues/123",
        :latest_comment_url => "https://api.github.com/repos/pengwynn/octokit/issues/comments/123",
        :type => "Issue"
      },
      :reason => 'subscribed',
      :unread => true,
      :updated_at => '2012-09-25T07:54:41-07:00',
      :last_read_at => '2012-09-25T07:54:41-07:00',
      :url => "https://api.github.com/notifications/threads/1"
    }

    SUBSCRIPTION = {
      :subscribed => true,
      :ignored => false,
      :reason => nil,
      :created_at => "2012-10-06T21:34:12Z",
      :url => "https://api.github.com/notifications/threads/1/subscription",
      :thread_url => "https://api.github.com/notifications/threads/1"
    }

    REPO_SUBSCRIPTION = SUBSCRIPTION.merge \
      :url => "https://api.github.com/repos/octocat/example/subscription",
      :repository_url => "https://api.github.com/repos/octocat/example"
    REPO_SUBSCRIPTION.delete :thread_url

    TEMPLATE = {
      :name => "C",
      :source => "# Object files\n*.o\n\n# Libraries\n*.lib\n*.a\n\n# Shared objects (inc. Windows DLLs)\n*.dll\n*.so\n*.so.*\n*.dylib\n\n# Executables\n*.exe\n*.out\n*.app\n"
    }

    TEMPLATES = [
      "Actionscript",
      "Android",
      "AppceleratorTitanium",
      "Autotools",
      "Bancha",
      "C",
      "C++"
    ]

    USER_EMAIL = {
      :email    => "octocat@github.com",
      :verified => true,
      :primary  => true
    }

    REPO_STATS_CONTRIBUTORS = [{
      :author => USER,
      :total => 135,
      :weeks => [
        {
          :w => "1367712000",
          :a => 6898,
          :d => 77,
          :c  => 10
        }
      ]
    }]

    REPO_STATS_COMMIT_ACTIVITY = [{
      :days => [0, 3, 26, 20, 39, 1, 0],
      :total => 89,
      :week => 1336280400
    }]

    REPO_STATS_CODE_FREQUENCY = [[
      1302998400,
      1124,
      -435
    ]]

    REPO_STATS_PARTICIPATION = {
      :all => [11,21,15,2,8,1,8,23,17,21,11,10,33,91,38,34,22,23,32,3,43,87,71,18,13,5,13,16,66,27,12,45,110,117,13,8,18,9,19,26,39,12,20,31,46,91,45,10,24,9,29,7],
      :owner => [3,2,3,0,2,0,5,14,7,9,1,5,0,48,19,2,0,1,10,2,23,40,35,8,8,2,10,6,30,0,2,9,53,104,3,3,10,4,7,11,21,4,4,22,26,63,11,2,14,1,10,3]
    }

    REPO_STATS_PUNCH_CARD = [
      [0,0,5],
      [0,1,43],
      [0,2,21]
    ]
  end
end

include GitHub::Resources::Helpers
