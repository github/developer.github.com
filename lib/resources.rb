require 'pp'
require 'yajl/json_gem'
require 'stringio'
require 'cgi'
require 'securerandom'

module GitHub
  module Resources
    module Helpers

      STATUSES ||= {
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
        500 => '500 Server Error',
        502 => '502 Bad Gateway'
      }

      DefaultTimeFormat ||= "%B %-d, %Y".freeze

      def post_date(item)
        strftime item[:created_at]
      end

      def strftime(time, format = DefaultTimeFormat)
        return "" if time.nil?
        attribute_to_time(time).strftime(format)
      end

      def avatar_for(login)
        %(<img height="16" width="16" src="%s" alt="Avatar for #{login}" data-proofer-ignore/>) % avatar_url_for(login)
      end

      def avatar_url_for(login)
        "https://github.com/#{login}.png"
      end

      def headers(status, head = {})
        lines = ["Status: #{STATUSES[status]}"]
        head.each do |key, value|
          case key
            when :pagination
              lines << link_header(value)
            else
              lines << "#{key}: #{value}"
          end
        end

        lines << "X-RateLimit-Limit: 5000" unless head.has_key?('X-RateLimit-Limit')
        lines << "X-RateLimit-Remaining: 4999" unless head.has_key?('X-RateLimit-Remaining')

        %(<pre class="headers"><code>#{lines * "\n"}</code></pre>\n)
      end

      def link_header(rels)
        formatted_rels = rels.map { |name, url| link_header_rel(name, url) }

        lines = ["Link: #{formatted_rels.shift}"]
        while formatted_rels.any?
          lines.last << ","
          lines << "      #{formatted_rels.shift}"
        end

        lines
      end

      def link_header_rel(name, url)
        %Q{<#{url}>; rel="#{name}"}
      end

      def default_pagination_rels
        {
          :next => "https://api.github.com/resource?page=2",
          :last => "https://api.github.com/resource?page=5"
        }
      end

      def json(key)
        hash = get_resource(key)
        hash = yield hash if block_given?

        %(<pre class="body-response"><code class="language-javascript">) +
          JSON.pretty_generate(hash) + "</code></pre>"
      end

      def get_resource(key)
        hash = case key
          when Hash
            h = {}
            key.each { |k, v| h[k.to_s] = v }
            h
          when Array
            key
          else Resources.const_get(key.to_s.upcase)
        end
      end

      def text_html(response, status, head = {})
        hs = headers(status, head.merge('Content-Type' => 'text/html'))
        res = CGI.escapeHTML(response)
        hs + %(<pre class="body-response"><code>) + res + "</code></pre>"
      end

      def webhook_headers(event_name)
        "<pre><code>" + File.read("lib/webhooks/#{event_name}.headers.txt") + "</code></pre>"
      end

      def webhook_payload(event_name)
        "<pre><code class='language-javascript'>" + File.read("lib/webhooks/#{event_name}.payload.json") + "</code></pre>"
      end

      CONTENT ||= {
        'LATEST_ENTERPRISE_VERSION' => '2.4',
        'IF_SITE_ADMIN' => "If you are an [authenticated](/v3/#authentication) site administrator for your Enterprise instance,",
        "PUT_CONTENT_LENGTH" => "Note that you'll need to set `Content-Length` to zero when calling out to this endpoint. For more information, see \"[HTTP verbs](/v3/#http-verbs).\"",
        "OPTIONAL_PUT_CONTENT_LENGTH" => "Note that, if you choose not to pass any parameters, you'll need to set `Content-Length` to zero when calling out to this endpoint. For more information, see \"[HTTP verbs](/v3/#http-verbs).\"",
        "ORG_HOOK_CONFIG_HASH" =>
        '''
Name | Type | Description
-----|------|--------------
`url`          | `string` | **Required** The URL to which the payloads will be delivered.
`content_type` | `string` | The media type used to serialize the payloads. Supported values include `json` and `form`. The default is `form`.
`secret`       | `string` | If provided, payloads will be delivered with an `X-Hub-Signature` header. The value of this header is computed as the [HMAC hex digest of the body, using the `secret` as the key][hub-signature].
`insecure_ssl` | `string` | Determines whether the SSL certificate of the host for `url` will be verified when delivering payloads. Supported values include `"0"` (verification is performed) and `"1"` (verification is not performed). The default is `"0"`. **We strongly recommend not setting this to "1" as you are subject to man-in-the-middle and other attacks.**
''',
      "PRS_AS_ISSUES" =>
      '''
{{#tip}}

**Note**: In the past, pull requests and issues were more closely aligned than they are now. As far as the API is concerned, every pull request is an issue, but not every issue is a pull request.

This endpoint may also return pull requests in the response. If an issue *is* a pull request, the object will include a `pull_request` key.

{{/tip}}
'''
      }

      def fetch_content(key)
        CONTENT[key.to_s.upcase]
      end

    end

    USER ||= {
      "login"        => "octocat",
      "id"           => 1,
      "avatar_url"   => "https://github.com/images/error/octocat_happy.gif",
      "gravatar_id"  => "",
      "url"          => "https://api.github.com/users/octocat",
      "html_url"     => "https://github.com/octocat",
      "followers_url" => "https://api.github.com/users/octocat/followers",
      "following_url" => "https://api.github.com/users/octocat/following{/other_user}",
      "gists_url"    => "https://api.github.com/users/octocat/gists{/gist_id}",
      "starred_url"  => "https://api.github.com/users/octocat/starred{/owner}{/repo}",
      "subscriptions_url" => "https://api.github.com/users/octocat/subscriptions",
      "organizations_url" => "https://api.github.com/users/octocat/orgs",
      "repos_url"    => "https://api.github.com/users/octocat/repos",
      "events_url"   => "https://api.github.com/users/octocat/events{/privacy}",
      "received_events_url" => "https://api.github.com/users/octocat/received_events",
      "type"         => "User",
      "site_admin"   => false
    }

    CONTRIBUTOR ||= USER.merge({
      "contributions" => 32
    })

    COLLABORATOR ||= USER.merge({
      "permissions" => {
        "pull"  => true,
        "push"  => true,
        "admin" => false
      }
    })

    FULL_USER ||= USER.merge({
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
      "updated_at"   => "2008-01-14T04:33:35Z"
    })

    PRIVATE_USER ||= FULL_USER.merge({
      "total_private_repos" => 100,
      "owned_private_repos" => 100,
      "private_gists"       => 81,
      "disk_usage"          => 10000,
      "collaborators"       => 8,
      "plan"                => {
        "name"          => "Medium",
        "space"         => 400,
        "private_repos" => 20,
        "collaborators" => 0 # Plans now allow *unlimited* collaborators, so
                             # this attribute is deprecated. However, the beta
                             # and v3 media types need to continue to return an
                             # integer value for backwards compatibility.
      }
    })

    SIMPLE_PUBLIC_KEY ||= {
      "id"    => 1,
      "key"   => "ssh-rsa AAA..."
    }

    PUBLIC_KEY ||= SIMPLE_PUBLIC_KEY.merge \
      "url"        => "https://api.github.com/user/keys/1",
      "title"      => "octocat@octomac",
      "verified"   => true,
      "created_at" => "2014-12-10T15:53:42Z",
      "read_only"  => true

    PUBLIC_KEY_DETAIL ||= PUBLIC_KEY.merge \
      "user_id"        => 232,
      "repository_id"  => nil

    DEPLOY_KEY ||= SIMPLE_PUBLIC_KEY.merge \
      "url"        => "https://api.github.com/repos/octocat/Hello-World/keys/1",
      "title"      => "octocat@octomac",
      "verified"   => true,
      "created_at" => "2014-12-10T15:53:42Z",
      "read_only"  => true

    DEPLOY_KEY_DETAIL ||= PUBLIC_KEY.merge \
      "user_id"        => nil,
      "repository_id"  => 2333

    ALL_KEYS ||= [PUBLIC_KEY_DETAIL, DEPLOY_KEY_DETAIL]

    SIMPLE_REPO ||= {
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

    REPO_PERMISSIONS ||= {
      "admin"  => false,
      "push"   => false,
      "pull"   => true
    }

    REPO ||= SIMPLE_REPO.merge({
      "archive_url"       => "http://api.github.com/repos/octocat/Hello-World/{archive_format}{/ref}",
      "assignees_url"     => "http://api.github.com/repos/octocat/Hello-World/assignees{/user}",
      "blobs_url"         => "http://api.github.com/repos/octocat/Hello-World/git/blobs{/sha}",
      "branches_url"      => "http://api.github.com/repos/octocat/Hello-World/branches{/branch}",
      "clone_url"         => "https://github.com/octocat/Hello-World.git",
      "collaborators_url" => "http://api.github.com/repos/octocat/Hello-World/collaborators{/collaborator}",
      "comments_url"      => "http://api.github.com/repos/octocat/Hello-World/comments{/number}",
      "commits_url"       => "http://api.github.com/repos/octocat/Hello-World/commits{/sha}",
      "compare_url"       => "http://api.github.com/repos/octocat/Hello-World/compare/{base}...{head}",
      "contents_url"      => "http://api.github.com/repos/octocat/Hello-World/contents/{+path}",
      "contributors_url"  => "http://api.github.com/repos/octocat/Hello-World/contributors",
      "downloads_url"     => "http://api.github.com/repos/octocat/Hello-World/downloads",
      "events_url"        => "http://api.github.com/repos/octocat/Hello-World/events",
      "forks_url"         => "http://api.github.com/repos/octocat/Hello-World/forks",
      "git_commits_url"   => "http://api.github.com/repos/octocat/Hello-World/git/commits{/sha}",
      "git_refs_url"      => "http://api.github.com/repos/octocat/Hello-World/git/refs{/sha}",
      "git_tags_url"      => "http://api.github.com/repos/octocat/Hello-World/git/tags{/sha}",
      "git_url"           => "git:github.com/octocat/Hello-World.git",
      "hooks_url"         => "http://api.github.com/repos/octocat/Hello-World/hooks",
      "issue_comment_url" => "http://api.github.com/repos/octocat/Hello-World/issues/comments{/number}",
      "issue_events_url"  => "http://api.github.com/repos/octocat/Hello-World/issues/events{/number}",
      "issues_url"        => "http://api.github.com/repos/octocat/Hello-World/issues{/number}",
      "keys_url"          => "http://api.github.com/repos/octocat/Hello-World/keys{/key_id}",
      "labels_url"        => "http://api.github.com/repos/octocat/Hello-World/labels{/name}",
      "languages_url"     => "http://api.github.com/repos/octocat/Hello-World/languages",
      "merges_url"        => "http://api.github.com/repos/octocat/Hello-World/merges",
      "milestones_url"    => "http://api.github.com/repos/octocat/Hello-World/milestones{/number}",
      "mirror_url"        => "git:git.example.com/octocat/Hello-World",
      "notifications_url" => "http://api.github.com/repos/octocat/Hello-World/notifications{?since, all, participating}",
      "pulls_url"         => "http://api.github.com/repos/octocat/Hello-World/pulls{/number}",
      "releases_url"      => "http://api.github.com/repos/octocat/Hello-World/releases{/id}",
      "ssh_url"           => "git@github.com:octocat/Hello-World.git",
      "stargazers_url"    => "http://api.github.com/repos/octocat/Hello-World/stargazers",
      "statuses_url"      => "http://api.github.com/repos/octocat/Hello-World/statuses/{sha}",
      "subscribers_url"   => "http://api.github.com/repos/octocat/Hello-World/subscribers",
      "subscription_url"  => "http://api.github.com/repos/octocat/Hello-World/subscription",
      "svn_url"           => "https://svn.github.com/octocat/Hello-World",
      "tags_url"          => "http://api.github.com/repos/octocat/Hello-World/tags",
      "teams_url"         => "http://api.github.com/repos/octocat/Hello-World/teams",
      "trees_url"         => "http://api.github.com/repos/octocat/Hello-World/git/trees{/sha}",
      "homepage"          => "https://github.com",
      "language"          => nil,
      "forks_count"       => 9,
      "stargazers_count"  => 80,
      "watchers_count"    => 80,
      "size"              => 108,
      "default_branch"    => 'master',
      "open_issues_count" => 0,
      "has_issues"        => true,
      "has_wiki"          => true,
      "has_pages"         => false,
      "has_downloads"     => true,
      "pushed_at"         => "2011-01-26T19:06:43Z",
      "created_at"        => "2011-01-26T19:01:12Z",
      "updated_at"        => "2011-01-26T19:14:43Z",
      "permissions"       => REPO_PERMISSIONS
    })

    FULL_REPO ||= REPO.merge({
      "subscribers_count" => 42,
      "organization"      => USER.merge('type' => 'Organization'),
      "parent"            => REPO,
      "source"            => REPO
    })

    STARRED_REPO ||= {
      "starred_at" => "2011-01-16T19:06:43Z",
      "repo" => REPO
    }

    STARGAZER_WITH_TIMESTAMPS ||= {
      "starred_at" => "2011-01-16T19:06:43Z",
      "user" => USER
    }

    TAG ||= {
      "name"        => "v0.1",
      "commit"      => {
          "sha"     => "c5b97d5ae6c19d5c5df71a34c7fbeeda2479ccbc",
          "url"  => "https://api.github.com/repos/octocat/Hello-World/commits/c5b97d5ae6c19d5c5df71a34c7fbeeda2479ccbc"
      },
      "zipball_url" => "https://github.com/octocat/Hello-World/zipball/v0.1",
      "tarball_url" => "https://github.com/octocat/Hello-World/tarball/v0.1",
    }

    BRANCHES ||= [
      {
        "name"   => "master",
        "commit" => {
          "sha" => "6dcb09b5b57875f334f61aebed695e2e4193db5e",
          "url" => "https://api.github.com/repos/octocat/Hello-World/commits/c5b97d5ae6c19d5c5df71a34c7fbeeda2479ccbc"
        }
      }
    ]

    BRANCH ||= {"name"=>"master",
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
    {"gravatar_id"=>"",
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
    {"gravatar_id"=>"",
     "avatar_url"=>
      "https://secure.gravatar.com/avatar/7ad39074b0584bc555d0417ae3e7d974?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
     "url"=>"https://api.github.com/users/octocat",
     "id"=>583231,
     "login"=>"octocat"}},
 "_links"=>
  {"html"=>"https://github.com/octocat/Hello-World/tree/master",
   "self"=>"https://api.github.com/repos/octocat/Hello-World/branches/master"}}

 MERGE_COMMIT ||= {
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
  "html_url" => "https://github.com/octocat/Hello-World/commit/7fd1a60b01f91b314f59955a4e4d4e80d8edf11d",
  "comments_url" => "https://api.github.com/repos/octocat/Hello-World/commits/7fd1a60b01f91b314f59955a4e4d4e80d8edf11d/comments",
  "author" => {
    "login" => "octocat",
    "id" => 583231,
    "avatar_url" => "https://secure.gravatar.com/avatar/7ad39074b0584bc555d0417ae3e7d974?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png",
    "gravatar_id" => "",
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
    "gravatar_id" => "",
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

    MILESTONE ||= {
      "url" => "https://api.github.com/repos/octocat/Hello-World/milestones/1",
      "html_url"      => "https://github.com/octocat/Hello-World/milestones/v1.0",
      "labels_url"    => "https://api.github.com/repos/octocat/Hello-World/milestones/1/labels",
      "id"            => 1002604,
      "number"        => 1,
      "state"         => "open",
      "title"         => "v1.0",
      "description"   => "Tracking milestone for version 1.0",
      "creator"       => USER,
      "open_issues"   => 4,
      "closed_issues" => 8,
      "created_at"    => "2011-04-10T20:09:31Z",
      "updated_at"    => "2014-03-03T18:58:10Z",
      "closed_at"     => "2013-02-12T13:22:01Z",
      "due_on"        => "2012-10-09T23:39:01Z"
    }


    PULL ||= {
      "id"         => 1,
      "url"        => "https://api.github.com/repos/octocat/Hello-World/pulls/1347",
      "html_url"   => "https://github.com/octocat/Hello-World/pull/1347",
      "diff_url"   => "https://github.com/octocat/Hello-World/pull/1347.diff",
      "patch_url"  => "https://github.com/octocat/Hello-World/pull/1347.patch",
      "issue_url"  => "https://api.github.com/repos/octocat/Hello-World/issues/1347",
      "commits_url" => "https://api.github.com/repos/octocat/Hello-World/pulls/1347/commits",
      "review_comments_url" => "https://api.github.com/repos/octocat/Hello-World/pulls/1347/comments",
      "review_comment_url" => "https://api.github.com/repos/octocat/Hello-World/pulls/comments/{number}",
      "comments_url" => "https://api.github.com/repos/octocat/Hello-World/issues/1347/comments",
      "statuses_url" => "https://api.github.com/repos/octocat/Hello-World/statuses/6dcb09b5b57875f334f61aebed695e2e4193db5e",
      "number"     => 1347,
      "state"      => "open",
      "title"      => "new-feature",
      "body"       => "Please pull these awesome changes",
      "assignee"   => USER,
      "milestone"  => MILESTONE,
      "locked"     => false,
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
          "https://api.github.com/repos/octocat/Hello-World/pulls/1347"},
        "html" => {'href' =>
          "https://github.com/octocat/Hello-World/pull/1347"},
        "issue" => {'href' =>
          "https://api.github.com/repos/octocat/Hello-World/issues/1347"},
        "comments" => {'href' =>
          "https://api.github.com/repos/octocat/Hello-World/issues/1347/comments"},
        "review_comments" => {'href' =>
          "https://api.github.com/repos/octocat/Hello-World/pulls/1347/comments"},
        "review_comment" => {'href' =>
          "https://api.github.com/repos/octocat/Hello-World/pulls/comments/{number}"},
        "commits" => { 'href' =>
          "https://api.github.com/repos/octocat/Hello-World/pulls/1347/commits"},
        "statuses" => {'href' =>
          "https://api.github.com/repos/octocat/Hello-World/statuses/6dcb09b5b57875f334f61aebed695e2e4193db5e"}
      },
      "user" => USER
    }

    FULL_PULL ||= PULL.merge({
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

    COMMIT ||= {
      "url" => "https://api.github.com/repos/octocat/Hello-World/commits/6dcb09b5b57875f334f61aebed695e2e4193db5e",
      "sha" => "6dcb09b5b57875f334f61aebed695e2e4193db5e",
      "html_url" => "https://github.com/octocat/Hello-World/commit/6dcb09b5b57875f334f61aebed695e2e4193db5e",
      "comments_url" => "https://api.github.com/repos/octocat/Hello-World/commits/6dcb09b5b57875f334f61aebed695e2e4193db5e/comments",
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
        "comment_count" => 0,
      },
      "author" => USER,
      "committer" => USER,
      "parents" => [{
        "url" => "https://api.github.com/repos/octocat/Hello-World/commits/6dcb09b5b57875f334f61aebed695e2e4193db5e",
        "sha" => "6dcb09b5b57875f334f61aebed695e2e4193db5e",
      }]
    }

    FULL_COMMIT ||= COMMIT.merge({
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

    COMMIT_COMMENT ||= {
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

    FILE ||= {
      "sha"       => "bbcd538c8e72b8c175046e27cc8f907076331401",
      "filename"  => "file1.txt",
      "status"    => "added",
      "additions" => 103,
      "deletions" => 21,
      "changes"   => 124,
      "blob_url"  => "https://github.com/octocat/Hello-World/blob/6dcb09b5b57875f334f61aebed695e2e4193db5e/file1.txt",
      "raw_url"   => "https://github.com/octocat/Hello-World/raw/6dcb09b5b57875f334f61aebed695e2e4193db5e/file1.txt",
      "contents_url" => "https://api.github.com/repos/octocat/Hello-World/contents/file1.txt?ref=6dcb09b5b57875f334f61aebed695e2e4193db5e",
      "patch"     => "@@ -132,7 +132,7 @@ module Test @@ -1000,7 +1000,7 @@ module Test"
    }

    COMMIT_COMPARISON ||= {
      "url" => "https://api.github.com/repos/octocat/Hello-World/compare/master...topic",
      "html_url" => "https://github.com/octocat/Hello-World/compare/master...topic",
      "permalink_url" => "https://github.com/octocat/Hello-World/compare/octocat:bbcd538c8e72b8c175046e27cc8f907076331401...octocat:0328041d1152db8ae77652d1618a02e57f745f17",
      "diff_url" => "https://github.com/octocat/Hello-World/compare/master...topic.diff",
      "patch_url" => "https://github.com/octocat/Hello-World/compare/master...topic.patch",
      "base_commit" => COMMIT,
      "merge_base_commit" => COMMIT,
      "status" => "behind",
      "ahead_by" => 1,
      "behind_by" => 2,
      "total_commits" => 1,
      "commits" => [COMMIT],
      "files" => [FILE],
    }

  PULL_COMMENT ||= {
      "url"                => "https://api.github.com/repos/octocat/Hello-World/pulls/comments/1",
      "id"                 => 1,
      "diff_hunk"          => "@@ -16,33 +16,40 @@ public class Connection : IConnection...",
      "path"               => "file1.txt",
      "position"           => 1,
      "original_position"  => 4,
      "commit_id"          => "6dcb09b5b57875f334f61aebed695e2e4193db5e",
      "original_commit_id" => "9c48853fa3dc5c1c3d6f1f1cd1f2743e72652840",
      "user"               => USER,
      "body"               => "Great stuff",
      "created_at"         => "2011-04-14T16:00:49Z",
      "updated_at"         => "2011-04-14T16:00:49Z",
      "html_url"           => "https://github.com/octocat/Hello-World/pull/1#discussion-diff-1",
      "pull_request_url"   => "https://api.github.com/repos/octocat/Hello-World/pulls/1",
      "_links" => {
        "self" => {'href' =>
          "https://api.github.com/repos/octocat/Hello-World/pulls/comments/1"},
        "html" => {'href' =>
          "https://github.com/octocat/Hello-World/pull/1#discussion-diff-1"},
        "pull_request" => {'href' =>
          "https://api.github.com/repos/octocat/Hello-World/pulls/1"}
      }
    }

    RELEASE_ASSET ||= {
      "url"                  => "https://api.github.com/repos/octocat/Hello-World/releases/assets/1",
      "browser_download_url" => "https://github.com/octocat/Hello-World/releases/download/v1.0.0/example.zip",
      "id"                   => 1,
      "name"                 => "example.zip",
      "label"                => "short description",
      "state"                => "uploaded",
      "content_type"         => "application/zip",
      "size"                 => 1024,
      "download_count"       => 42,
      "created_at"           => "2013-02-27T19:35:32Z",
      "updated_at"           => "2013-02-27T19:35:32Z",
      "uploader"             => USER
    }

    RELEASE ||= {
      "url"              => "https://api.github.com/repos/octocat/Hello-World/releases/1",
      "html_url"         => "https://github.com/octocat/Hello-World/releases/v1.0.0",
      "assets_url"       => "https://api.github.com/repos/octocat/Hello-World/releases/1/assets",
      "upload_url"       => "https://uploads.github.com/repos/octocat/Hello-World/releases/1/assets{?name,label}",
      "tarball_url"      => "https://api.github.com/repos/octocat/Hello-World/tarball/v1.0.0",
      "zipball_url"      => "https://api.github.com/repos/octocat/Hello-World/zipball/v1.0.0",
      "id"               => 1,
      "tag_name"         => "v1.0.0",
      "target_commitish" => "master",
      "name"             => "v1.0.0",
      "body"             => "Description of the release",
      "draft"            => false,
      "prerelease"       => false,
      "created_at"       => "2013-02-27T19:35:32Z",
      "published_at"     => "2013-02-27T19:35:32Z",
      "author"           => USER,
      "assets"           => [RELEASE_ASSET]
    }

    CREATED_RELEASE ||= RELEASE.merge({
      "assets"         => []
    })

    DOWNLOAD ||= {
      "url"            => "https://api.github.com/repos/octocat/Hello-World/downloads/1",
      "html_url"       => "https://github.com/repos/octocat/Hello-World/downloads/new_file.jpg",
      "id"             => 1,
      "name"           => "new_file.jpg",
      "description"    => "Description of your download",
      "size"           => 1024,
      "download_count" => 40,
      "content_type"   => ".jpg"
    }

    CREATE_DOWNLOAD ||= DOWNLOAD.merge({
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

    PAGES ||= {
      "url" => "https://api.github.com/repos/github/developer.github.com/pages",
      "status" => "built",
      "cname" => "developer.github.com",
      "custom_404" => false
    }

    PAGES_BUILD ||= {
      "url" => "https://api.github.com/repos/github/developer.github.com/pages/builds/5472601",
      "status" => "built",
      "error" => {
        "message" => nil
      },
      "pusher" => USER,
      "commit" => "351391cdcb88ffae71ec3028c91f375a8036a26b",
      "duration" => 2104,
      "created_at" => "2014-02-10T19:00:49Z",
      "updated_at" => "2014-02-10T19:00:51Z"
    }

    ORG ||= {
      "login"      => "github",
      "id"         => 1,
      "url"        => "https://api.github.com/orgs/github",
      "avatar_url" => "https://github.com/images/error/octocat_happy.gif",
      "description" => "A great organization"
    }

    FULL_ORG ||= ORG.merge({
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

    PRIVATE_ORG ||= FULL_ORG.merge({
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

    TEAM ||= {
      "id" => 1,
      "url" => "https://api.github.com/teams/1",
      "name" => "Justice League",
      "slug" => "justice-league",
      "description" => "A great team.",
      "privacy" => "closed",
      "permission" => "admin",
      "members_url" => "https://api.github.com/teams/1/members{/member}",
      "repositories_url" => "https://api.github.com/teams/1/repos"
    }

    FULL_TEAM ||= TEAM.merge({
      "members_count" => 3,
      "repos_count" => 10,
      "organization" =>  ORG
    })

    TEAM_MEMBERSHIP ||= {
      "url" => "https://api.github.com/teams/1/memberships/octocat",
      "role" => "member"
    }

    ACTIVE_TEAM_MEMBERSHIP ||= TEAM_MEMBERSHIP.merge(
      "state" => "active"
    )

    PENDING_TEAM_MEMBERSHIP ||= TEAM_MEMBERSHIP.merge(
      "state" => "pending"
    )

    USER_FOR_ORG_MEMBERSHIP ||= {
      "login"        => "defunkt",
      "id"           => 3,
      "avatar_url"   => "https://github.com/images/error/octocat_happy.gif",
      "gravatar_id"  => "",
      "url"          => "https://api.github.com/users/defunkt",
      "html_url"     => "https://github.com/defunkt",
      "followers_url" => "https://api.github.com/users/defunkt/followers",
      "following_url" => "https://api.github.com/users/defunkt/following{/other_user}",
      "gists_url"    => "https://api.github.com/users/defunkt/gists{/gist_id}",
      "starred_url"  => "https://api.github.com/users/defunkt/starred{/owner}{/repo}",
      "subscriptions_url" => "https://api.github.com/users/defunkt/subscriptions",
      "organizations_url" => "https://api.github.com/users/defunkt/orgs",
      "repos_url"    => "https://api.github.com/users/defunkt/repos",
      "events_url"   => "https://api.github.com/users/defunkt/events{/privacy}",
      "received_events_url" => "https://api.github.com/users/defunkt/received_events",
      "type"         => "User",
      "site_admin"   => false
    }

    ORG_FOR_ACTIVE_ORG_MEMBERSHIP ||= {
      "login"              => "octocat",
      "url"                => "https://api.github.com/orgs/octocat",
      "id"                 => 1,
      "repos_url"          => "https://api.github.com/users/octocat/repos",
      "events_url"         => "https://api.github.com/users/octocat/events{/privacy}",
      "members_url"        => "https://api.github.com/users/octocat/members{/member}",
      "public_members_url" => "https://api.github/com/users/octocat/public_members{/member}",
      "avatar_url"         => "https://secure.gravatar.com/avatar/7ad39074b0584bc555d0417ae3e7d974?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png"
    }

    ORG_FOR_PENDING_ORG_MEMBERSHIP ||= {
      "login"              => "invitocat",
      "url"                => "https://api.github.com/orgs/invitocat",
      "id"                 => 2,
      "repos_url"          => "https://api.github.com/users/invitocat/repos",
      "events_url"         => "https://api.github.com/users/invitocat/events{/privacy}",
      "members_url"        => "https://api.github.com/users/invitocat/members{/member}",
      "public_members_url" => "https://api.github/com/users/invitocat/public_members{/member}",
      "avatar_url"         => "https://secure.gravatar.com/avatar/7ad39074b0584bc555d0417ae3e7d974?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-140.png"
    }

    ACTIVE_ADMIN_ORG_MEMBERSHIP ||= {
      "url"              => "https://api.github.com/orgs/octocat/memberships/defunkt",
      "state"            => "active",
      "role"             => "admin",
      "organization_url" => "https://api.github.com/orgs/octocat",
      "organization"     => ORG_FOR_ACTIVE_ORG_MEMBERSHIP,
      "user"             => USER_FOR_ORG_MEMBERSHIP
    }

    ACTIVE_LIMITED_ORG_MEMBERSHIP ||= {
      "url"              => "https://api.github.com/orgs/octocat/memberships/defunkt",
      "state"            => "active",
      "role"             => "limited_member",
      "organization_url" => "https://api.github.com/orgs/octocat",
      "organization"     => ORG_FOR_ACTIVE_ORG_MEMBERSHIP,
      "user"             => USER_FOR_ORG_MEMBERSHIP
    }

    PENDING_ADMIN_ORG_MEMBERSHIP ||= {
      "url"              => "https://api.github.com/orgs/invitocat/memberships/defunkt",
      "state"            => "pending",
      "role"             => "admin",
      "organization_url" => "https://api.github.com/orgs/invitocat",
      "organization"     => ORG_FOR_PENDING_ORG_MEMBERSHIP,
      "user"             => USER_FOR_ORG_MEMBERSHIP
    }

    PENDING_LIMITED_ORG_MEMBERSHIP ||= {
      "url"              => "https://api.github.com/orgs/invitocat/memberships/defunkt",
      "state"            => "pending",
      "role"             => "limited_member",
      "organization_url" => "https://api.github.com/orgs/invitocat",
      "organization"     => ORG_FOR_PENDING_ORG_MEMBERSHIP,
      "user"             => USER_FOR_ORG_MEMBERSHIP
    }

    ORG_MEMBERSHIPS         ||= [ACTIVE_ADMIN_ORG_MEMBERSHIP, PENDING_ADMIN_ORG_MEMBERSHIP]
    ACTIVE_ORG_MEMBERSHIPS  ||= [ACTIVE_ADMIN_ORG_MEMBERSHIP]
    PENDING_ORG_MEMBERSHIPS ||= [PENDING_ADMIN_ORG_MEMBERSHIP]

    MIGRATIONS ||= {
      "id" => 79,
      "guid" => "0b989ba4-242f-11e5-81e1-c7b6966d2516",
      "state" => "pending",
      "lock_repositories" => true,
      "exclude_attachments" => false,
      "url" => "https://api.github.com/orgs/octo-org/migrations/79",
      "created_at" => "2015-07-06T15:33:38-07:00",
      "updated_at" => "2015-07-06T15:33:38-07:00",
      "repositories" => [REPO]
    }

    LABEL ||= {
      "url"   => "https://api.github.com/repos/octocat/Hello-World/labels/bug",
      "name"  => "bug",
      "color" => "f29513"
    }

    ISSUE ||= {
      "id"         => 1,
      "url"        => "https://api.github.com/repos/octocat/Hello-World/issues/1347",
      "labels_url" => "https://api.github.com/repos/octocat/Hello-World/issues/1347/labels{/name}",
      "comments_url" => "https://api.github.com/repos/octocat/Hello-World/issues/1347/comments",
      "events_url" => "https://api.github.com/repos/octocat/Hello-World/issues/1347/events",
      "html_url"   => "https://github.com/octocat/Hello-World/issues/1347",
      "number"     => 1347,
      "state"      => "open",
      "title"      => "Found a bug",
      "body"       => "I'm having a problem with this.",
      "user"       => USER,
      "labels"     => [LABEL],
      "assignee"   => USER,
      "milestone"  => MILESTONE,
      "locked"     => false,
      "comments"   => 0,
      "pull_request" => {
        "url"       => "https://api.github.com/repos/octocat/Hello-World/pulls/1347",
        "html_url"  => "https://github.com/octocat/Hello-World/pull/1347",
        "diff_url"  => "https://github.com/octocat/Hello-World/pull/1347.diff",
        "patch_url" => "https://github.com/octocat/Hello-World/pull/1347.patch"
      },
      "closed_at"  => nil,
      "created_at" => "2011-04-22T13:33:48Z",
      "updated_at" => "2011-04-22T13:33:48Z"
    }

    FULL_ISSUE ||= ISSUE.merge({
      "closed_by" => USER
    })

    ISSUE_COMMENT ||= {
      "id"         => 1,
      "url"        => "https://api.github.com/repos/octocat/Hello-World/issues/comments/1",
      "html_url"   => "https://github.com/octocat/Hello-World/issues/1347#issuecomment-1",
      "body"       => "Me too",
      "user"       => USER,
      "created_at" => "2011-04-14T16:00:49Z",
      "updated_at" => "2011-04-14T16:00:49Z"
    }

    ISSUE_EVENT ||= {
      "id"         => 1,
      "url"        => "https://api.github.com/repos/octocat/Hello-World/issues/events/1",
      "actor"      => USER,
      "event"      => "closed",
      "commit_id"  => "6dcb09b5b57875f334f61aebed695e2e4193db5e",
      "created_at" => "2011-04-14T16:00:49Z"
    }

    FULL_ISSUE_EVENT ||= ISSUE_EVENT.merge('issue' => ISSUE)

    ISSUE_SEARCH_ITEM ||= {
      "gravatar_id" =>  "",
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

    ISSUE_SEARCH_RESULTS ||= {
      "issues" => [ISSUE_SEARCH_ITEM]
    }

    ISSUE_SEARCH_V3_RESULTS ||= {
      "total_count" => 280,
      "incomplete_results" => false,
      "items" => [
        {
          "url" => "https://api.github.com/repos/batterseapower/pinyin-toolkit/issues/132",
          "labels_url" => "https://api.github.com/repos/batterseapower/pinyin-toolkit/issues/132/labels{/name}",
          "comments_url" => "https://api.github.com/repos/batterseapower/pinyin-toolkit/issues/132/comments",
          "events_url" => "https://api.github.com/repos/batterseapower/pinyin-toolkit/issues/132/events",
          "html_url" => "https://github.com/batterseapower/pinyin-toolkit/issues/132",
          "id" => 35802,
          "number" => 132,
          "title" => "Line Number Indexes Beyond 20 Not Displayed",
          "user" => {
            "login" => "Nick3C",
            "id" => 90254,
            "avatar_url" => "https://secure.gravatar.com/avatar/934442aadfe3b2f4630510de416c5718?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
            "gravatar_id" => "",
            "url" => "https://api.github.com/users/Nick3C",
            "html_url" => "https://github.com/Nick3C",
            "followers_url" => "https://api.github.com/users/Nick3C/followers",
            "following_url" => "https://api.github.com/users/Nick3C/following{/other_user}",
            "gists_url" => "https://api.github.com/users/Nick3C/gists{/gist_id}",
            "starred_url" => "https://api.github.com/users/Nick3C/starred{/owner}{/repo}",
            "subscriptions_url" => "https://api.github.com/users/Nick3C/subscriptions",
            "organizations_url" => "https://api.github.com/users/Nick3C/orgs",
            "repos_url" => "https://api.github.com/users/Nick3C/repos",
            "events_url" => "https://api.github.com/users/Nick3C/events{/privacy}",
            "received_events_url" => "https://api.github.com/users/Nick3C/received_events",
            "type" => "User"
          },
          "labels" => [
            {
              "url" => "https://api.github.com/repos/batterseapower/pinyin-toolkit/labels/bug",
              "name" => "bug",
              "color" => "ff0000"
            }
          ],
          "state" => "open",
          "assignee" => nil,
          "milestone" => nil,
          "comments" => 15,
          "created_at" => "2009-07-12T20:10:41Z",
          "updated_at" => "2009-07-19T09:23:43Z",
          "closed_at" => nil,
          "pull_request" => {
            "html_url" => nil,
            "diff_url" => nil,
            "patch_url" => nil
          },
          "body" => "...",
          "score" => 1.3859273
        }
      ]
    }

    ISSUE_SEARCH_V3_RESULTS_HIGHLIGHTING ||= {
      "text_matches" => [
        {
          "object_url" => "https://api.github.com/repositories/215335/issues/132",
          "object_type" => "Issue",
          "property" => "body",
          "fragment" => "comprehensive windows font I know of).\n\nIf we can find a commonly distributed windows font that supports them then no problem (we can use html font tags) but otherwise the '(21)' style is probably better.\n",
          "matches" => [
            {
              "text" => "windows",
              "indices" => [
                14,
                21
              ]
            },
            {
              "text" => "windows",
              "indices" => [
                78,
                85
              ]
            }
          ]
        },
        {
          "object_url" => "https://api.github.com/repositories/215335/issues/comments/25688",
          "object_type" => "IssueComment",
          "property" => "body",
          "fragment" => " right after that are a bit broken IMHO :). I suppose we could have some hack that maxes out at whatever the font does...\n\nI'll check what the state of play is on Windows.\n",
          "matches" => [
            {
              "text" => "Windows",
              "indices" => [
                163,
                170
              ]
            }
          ]
        }
      ]
    }

    REPO_SEARCH_ITEM ||= {
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

    REPO_SEARCH_RESULTS ||= {
      "repositories" => [REPO_SEARCH_ITEM]
    }

    REPO_SEARCH_V3_RESULTS ||= {
      "total_count" => 40,
      "incomplete_results" => false,
      "items" => [
        {
          "id" => 3081286,
          "name" => "Tetris",
          "full_name" => "dtrupenn/Tetris",
          "owner" => {
            "login" => "dtrupenn",
            "id" => 872147,
            "avatar_url" => "https://secure.gravatar.com/avatar/e7956084e75f239de85d3a31bc172ace?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
            "gravatar_id" => "",
            "url" => "https://api.github.com/users/dtrupenn",
            "received_events_url" => "https://api.github.com/users/dtrupenn/received_events",
            "type" => "User"
          },
          "private" => false,
          "html_url" => "https://github.com/dtrupenn/Tetris",
          "description" => "A C implementation of Tetris using Pennsim through LC4",
          "fork" => false,
          "url" => "https://api.github.com/repos/dtrupenn/Tetris",
          "created_at" => "2012-01-01T00:31:50Z",
          "updated_at" => "2013-01-05T17:58:47Z",
          "pushed_at" => "2012-01-01T00:37:02Z",
          "homepage" => "",
          "size" => 524,
          "stargazers_count" => 1,
          "watchers_count" => 1,
          "language" => "Assembly",
          "forks_count" => 0,
          "open_issues_count" => 0,
          "master_branch" => "master",
          "default_branch" => "master",
          "score" => 10.309712
        }
      ]
    }

    REPO_SEARCH_V3_RESULTS_HIGHLIGHTING ||= {
      "text_matches" => [
        {
          "object_url" => "https://api.github.com/repositories/3081286",
          "object_type" => "Repository",
          "property" => "name",
          "fragment" => "Tetris",
          "matches" => [
            {
              "text" => "Tetris",
              "indices" => [
                0,
                6
              ]
            }
          ]
        },
        {
          "object_url" => "https://api.github.com/repositories/3081286",
          "object_type" => "Repository",
          "property" => "description",
          "fragment" => "A C implementation of Tetris using Pennsim through LC4",
          "matches" => [
            {
              "text" => "Tetris",
              "indices" => [
                22,
                28
              ]
            }
          ]
        }
      ]
    }

    CODE_SEARCH_V3_RESULTS ||= {
      "total_count" => 7,
      "incomplete_results" => false,
      "items" => [
        {
          "name" => "classes.js",
          "path" => "src/attributes/classes.js",
          "sha" => "d7212f9dee2dcc18f084d7df8f417b80846ded5a",
          "url" => "https://api.github.com/repositories/167174/contents/src/attributes/classes.js?ref=825ac3773694e0cd23ee74895fd5aeb535b27da4",
          "git_url" => "https://api.github.com/repositories/167174/git/blobs/d7212f9dee2dcc18f084d7df8f417b80846ded5a",
          "html_url" => "https://github.com/jquery/jquery/blob/825ac3773694e0cd23ee74895fd5aeb535b27da4/src/attributes/classes.js",
          "repository" => {
            "id" => 167174,
            "name" => "jquery",
            "full_name" => "jquery/jquery",
            "owner" => {
              "login" => "jquery",
              "id" => 70142,
              "avatar_url" => "https://0.gravatar.com/avatar/6906f317a4733f4379b06c32229ef02f?d=https%3A%2F%2Fidenticons.github.com%2Ff426f04f2f9813718fb806b30e0093de.png",
              "gravatar_id" => "",
              "url" => "https://api.github.com/users/jquery",
              "html_url" => "https://github.com/jquery",
              "followers_url" => "https://api.github.com/users/jquery/followers",
              "following_url" => "https://api.github.com/users/jquery/following{/other_user}",
              "gists_url" => "https://api.github.com/users/jquery/gists{/gist_id}",
              "starred_url" => "https://api.github.com/users/jquery/starred{/owner}{/repo}",
              "subscriptions_url" => "https://api.github.com/users/jquery/subscriptions",
              "organizations_url" => "https://api.github.com/users/jquery/orgs",
              "repos_url" => "https://api.github.com/users/jquery/repos",
              "events_url" => "https://api.github.com/users/jquery/events{/privacy}",
              "received_events_url" => "https://api.github.com/users/jquery/received_events",
              "type" => "Organization",
              "site_admin" => false
            },
            "private" => false,
            "html_url" => "https://github.com/jquery/jquery",
            "description" => "jQuery JavaScript Library",
            "fork" => false,
            "url" => "https://api.github.com/repos/jquery/jquery",
            "forks_url" => "https://api.github.com/repos/jquery/jquery/forks",
            "keys_url" => "https://api.github.com/repos/jquery/jquery/keys{/key_id}",
            "collaborators_url" => "https://api.github.com/repos/jquery/jquery/collaborators{/collaborator}",
            "teams_url" => "https://api.github.com/repos/jquery/jquery/teams",
            "hooks_url" => "https://api.github.com/repos/jquery/jquery/hooks",
            "issue_events_url" => "https://api.github.com/repos/jquery/jquery/issues/events{/number}",
            "events_url" => "https://api.github.com/repos/jquery/jquery/events",
            "assignees_url" => "https://api.github.com/repos/jquery/jquery/assignees{/user}",
            "branches_url" => "https://api.github.com/repos/jquery/jquery/branches{/branch}",
            "tags_url" => "https://api.github.com/repos/jquery/jquery/tags",
            "blobs_url" => "https://api.github.com/repos/jquery/jquery/git/blobs{/sha}",
            "git_tags_url" => "https://api.github.com/repos/jquery/jquery/git/tags{/sha}",
            "git_refs_url" => "https://api.github.com/repos/jquery/jquery/git/refs{/sha}",
            "trees_url" => "https://api.github.com/repos/jquery/jquery/git/trees{/sha}",
            "statuses_url" => "https://api.github.com/repos/jquery/jquery/statuses/{sha}",
            "languages_url" => "https://api.github.com/repos/jquery/jquery/languages",
            "stargazers_url" => "https://api.github.com/repos/jquery/jquery/stargazers",
            "contributors_url" => "https://api.github.com/repos/jquery/jquery/contributors",
            "subscribers_url" => "https://api.github.com/repos/jquery/jquery/subscribers",
            "subscription_url" => "https://api.github.com/repos/jquery/jquery/subscription",
            "commits_url" => "https://api.github.com/repos/jquery/jquery/commits{/sha}",
            "git_commits_url" => "https://api.github.com/repos/jquery/jquery/git/commits{/sha}",
            "comments_url" => "https://api.github.com/repos/jquery/jquery/comments{/number}",
            "issue_comment_url" => "https://api.github.com/repos/jquery/jquery/issues/comments/{number}",
            "contents_url" => "https://api.github.com/repos/jquery/jquery/contents/{+path}",
            "compare_url" => "https://api.github.com/repos/jquery/jquery/compare/{base}...{head}",
            "merges_url" => "https://api.github.com/repos/jquery/jquery/merges",
            "archive_url" => "https://api.github.com/repos/jquery/jquery/{archive_format}{/ref}",
            "downloads_url" => "https://api.github.com/repos/jquery/jquery/downloads",
            "issues_url" => "https://api.github.com/repos/jquery/jquery/issues{/number}",
            "pulls_url" => "https://api.github.com/repos/jquery/jquery/pulls{/number}",
            "milestones_url" => "https://api.github.com/repos/jquery/jquery/milestones{/number}",
            "notifications_url" => "https://api.github.com/repos/jquery/jquery/notifications{?since,all,participating}",
            "labels_url" => "https://api.github.com/repos/jquery/jquery/labels{/name}"
          },
          "score" => 0.5269679,
        }
      ]
    }

    CODE_SEARCH_V3_RESULTS_HIGHLIGHTING ||= {
      "text_matches" => [
        {
          "object_url" => "https://api.github.com/repositories/167174/contents/src/attributes/classes.js?ref=825ac3773694e0cd23ee74895fd5aeb535b27da4",
          "object_type" => "FileContent",
          "property" => "content",
          "fragment" => ";\n\njQuery.fn.extend({\n\taddClass: function( value ) {\n\t\tvar classes, elem, cur, clazz, j, finalValue",
          "matches" => [
            {
              "text" => "addClass",
              "indices" => [
                23,
                31
              ]
            }
          ]
        },
        {
          "object_url" => "https://api.github.com/repositories/167174/contents/src/attributes/classes.js?ref=825ac3773694e0cd23ee74895fd5aeb535b27da4",
          "object_type" => "FileContent",
          "property" => "content",
          "fragment" => ".isFunction( value ) ) {\n\t\t\treturn this.each(function( j ) {\n\t\t\t\tjQuery( this ).addClass( value.call( this",
          "matches" => [
            {
              "text" => "addClass",
              "indices" => [
                80,
                88
              ]
            }
          ]
        }
      ]
    }

    USER_SEARCH_ITEM ||= {
      "gravatar_id" => "",
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

    USER_SEARCH_RESULTS ||= {
      "users" => [USER_SEARCH_ITEM]
    }

    USER_SEARCH_V3_RESULTS ||= {
      "total_count" => 12,
      "incomplete_results" => false,
      "items" => [
        {
          "login" => "mojombo",
          "id" => 1,
          "avatar_url" => "https://secure.gravatar.com/avatar/25c7c18223fb42a4c6ae1c8db6f50f9b?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
          "gravatar_id" => "",
          "url" => "https://api.github.com/users/mojombo",
          "html_url" => "https://github.com/mojombo",
          "followers_url" => "https://api.github.com/users/mojombo/followers",
          "subscriptions_url" => "https://api.github.com/users/mojombo/subscriptions",
          "organizations_url" => "https://api.github.com/users/mojombo/orgs",
          "repos_url" => "https://api.github.com/users/mojombo/repos",
          "received_events_url" => "https://api.github.com/users/mojombo/received_events",
          "type" => "User",
          "score" => 105.47857
        }
      ]
    }


    USER_SEARCH_V3_RESULTS_HIGHLIGHTING ||= {
     "text_matches" => [
        {
          "object_url" => "https://api.github.com/users/mojombo",
          "object_type" => "User",
          "property" => "email",
          "fragment" => "tom@github.com",
          "matches" => [
            {
              "text" => "tom",
              "indices" => [
                0,
                3
              ]
            }
          ]
        },
        {
          "object_url" => "https://api.github.com/users/mojombo",
          "object_type" => "User",
          "property" => "name",
          "fragment" => "Tom Preston-Werner",
          "matches" => [
            {
              "text" => "Tom",
              "indices" => [
                0,
                3
              ]
            }
          ]
        }
      ]
    }

    EMAIL_SEARCH_RESULTS ||= {
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
        "gravatar_id"       => "",
      }
    }

    GIST_HISTORY ||= [
      {
        "url"     => "https://api.github.com/gists/aa5a315d61ae9438b18d/57a7f021a713b1c5a6a199b54cc514735d2d462f",
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


    GIST_FORKS ||= [
      {
        "user" => USER,
        "url" => "https://api.github.com/gists/dee9c42e4998ce2ea439",
        "id" => "dee9c42e4998ce2ea439",
        "created_at" => "2011-04-14T16:00:49Z",
        "updated_at" => "2011-04-14T16:00:49Z"
      }
    ]

    GIST_FILE ||= {
      "ring.erl" => {
        "size"      => 932,
        "raw_url"   => "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl",
        "type"      => "text/plain",
        "truncated" => false,
        "language"  => "Erlang"
      }
    }

    GIST_FILE_WITH_CONTENT ||= {
      "ring.erl" => {
        "size"      => 932,
        "raw_url"   => "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl",
        "type"      => "text/plain",
        "language"  => "Erlang",
        "truncated" => false,
        "content"   => "contents of gist"
      }
    }

    GIST ||= {
      "url"          => "https://api.github.com/gists/aa5a315d61ae9438b18d",
      "forks_url"    => "https://api.github.com/gists/aa5a315d61ae9438b18d/forks",
      "commits_url"  => "https://api.github.com/gists/aa5a315d61ae9438b18d/commits",
      "id"           => "aa5a315d61ae9438b18d",
      "description"  => "description of gist",
      "public"       => true,
      "owner"        => USER,
      "user"         => nil,
      "files"        => GIST_FILE,
      "comments"     => 0,
      "comments_url" => "https://api.github.com/gists/aa5a315d61ae9438b18d/comments/",
      "html_url"     => "https://gist.github.com/aa5a315d61ae9438b18d",
      "git_pull_url" => "https://gist.github.com/aa5a315d61ae9438b18d.git",
      "git_push_url" => "https://gist.github.com/aa5a315d61ae9438b18d.git",
      "created_at"   => "2010-04-14T02:15:15Z",
      "updated_at"   => "2011-06-20T11:34:15Z"
    }

    FULL_GIST ||= GIST.dup.update \
      "forks"   => GIST_FORKS,
      "history" => GIST_HISTORY,
      "files"   => GIST_FILE_WITH_CONTENT

    FULL_GIST_VERSION ||= FULL_GIST.dup.update \
      "url" => "https://api.github.com/gists/aa5a315d61ae9438b18d/57a7f021a713b1c5a6a199b54cc514735d2d462f"

    GIST_COMMENT ||= {
      "id"         => 1,
      "url"        => "https://api.github.com/gists/a6db0bec360bb87e9418/comments/1",
      "body"       => "Just commenting for the sake of commenting",
      "user"       => USER,
      "created_at" => "2011-04-18T23:23:56Z",
      "updated_at" => "2011-04-18T23:23:56Z"
    }

    TREE ||= {
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
      ],
      "truncated" => false
    }
    TREE_EXTRA ||= {
      "sha"  => "fc6274d15fa3ae2ab983129fb037999f264ba9a7",
      "url"  => "https://api.github.com/repos/octocat/Hello-World/trees/fc6274d15fa3ae2ab983129fb037999f264ba9a7",
      "tree" => [ {
          "path" => "subdir/file.txt",
          "mode" => "100644",
          "type" => "blob",
          "size" => 132,
          "sha"  => "7c258a9869f33c1e1e1f74fbb32f07c86cb5a75b",
          "url"  => "https://api.github.com/repos/octocat/Hello-World/git/7c258a9869f33c1e1e1f74fbb32f07c86cb5a75b"
      } ],
      "truncated" => false
    }
    TREE_NEW ||= {
      "sha"  => "cd8274d15fa3ae2ab983129fb037999f264ba9a7",
      "url"  => "https://api.github.com/repos/octocat/Hello-World/trees/cd8274d15fa3ae2ab983129fb037999f264ba9a7",
      "tree" => [ {
          "path" => "file.rb",
          "mode" => "100644",
          "type" => "blob",
          "size" => 132,
          "sha"  => "7c258a9869f33c1e1e1f74fbb32f07c86cb5a75b",
          "url"  => "https://api.github.com/repos/octocat/Hello-World/git/blobs/7c258a9869f33c1e1e1f74fbb32f07c86cb5a75b"
      } ]
    }

    GIT_COMMIT ||= {
      "sha" => "7638417db6d59f3c431d3e1f261cc637155684cd",
      "url" => "https://api.github.com/repos/octocat/Hello-World/git/commits/7638417db6d59f3c431d3e1f261cc637155684cd",
      "author" => {
        "date" => "2014-11-07T22:01:45Z",
        "name" => "Scott Chacon",
        "email" => "schacon@gmail.com"
      },
      "committer" => {
        "date" => "2014-11-07T22:01:45Z",
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

    NEW_COMMIT ||= {
      "sha" => "7638417db6d59f3c431d3e1f261cc637155684cd",
      "url" => "https://api.github.com/repos/octocat/Hello-World/git/commits/7638417db6d59f3c431d3e1f261cc637155684cd",
      "author" => {
        "date" => "2014-11-07T22:01:45Z",
        "name" => "Scott Chacon",
        "email" => "schacon@gmail.com"
      },
      "committer" => {
        "date" => "2014-11-07T22:01:45Z",
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

    GITTAG ||= {
      "tag" => "v0.0.1",
      "sha" => "940bd336248efae0f9ee5bc7b2d5c985887b16ac",
      "url" => "https://api.github.com/repos/octocat/Hello-World/git/tags/940bd336248efae0f9ee5bc7b2d5c985887b16ac",
      "message" => "initial version\n",
      "tagger" => {
        "name" => "Scott Chacon",
        "email" => "schacon@gmail.com",
        "date" => "2014-11-07T22:01:45Z"
      },
      "object" => {
        "type" => "commit",
        "sha" => "c3d0be41ecbe669545ee3e94d31ed9a4bc91ee3c",
        "url" => "https://api.github.com/repos/octocat/Hello-World/git/commits/c3d0be41ecbe669545ee3e94d31ed9a4bc91ee3c"
      }
    }

    REF ||= {
      "ref" => "refs/heads/featureA",
      "url" => "https://api.github.com/repos/octocat/Hello-World/git/refs/heads/featureA",
      "object" => {
        "type" => "commit",
        "sha" => "aa218f56b14c9653891f9e74264a383fa43fefbd",
        "url" => "https://api.github.com/repos/octocat/Hello-World/git/commits/aa218f56b14c9653891f9e74264a383fa43fefbd"
      }
    }

    REFS ||= [
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

    HOOK ||= {
      "id" => 1,
      "url" => "https://api.github.com/repos/octocat/Hello-World/hooks/1",
      "test_url" => "https://api.github.com/repos/octocat/Hello-World/hooks/1/test",
      "ping_url" => "https://api.github.com/repos/octocat/Hello-World/hooks/1/pings",
      "name" => "web",
      "events" => ["push", "pull_request"],
      "active" => true,
      "config" =>
        {'url' => 'http://example.com/webhook', 'content_type' => 'json'},
      "updated_at" => "2011-09-06T20:39:23Z",
      "created_at" => "2011-09-06T17:26:27Z",
    }

    ORG_HOOK ||= {
      "id" => 1,
      "url" => "https://api.github.com/orgs/octocat/hooks/1",
      "ping_url" => "https://api.github.com/orgs/octocat/hooks/1/pings",
      "name" => "web",
      "events" => ["push", "pull_request"],
      "active" => true,
      "config" =>
        {'url' => 'http://example.com', 'content_type' => 'json'},
      "updated_at" => "2011-09-06T20:39:23Z",
      "created_at" => "2011-09-06T17:26:27Z",
    }

    OAUTH_ACCESS ||= {
      "id" => 1,
      "url" => "https://api.github.com/authorizations/1",
      "scopes" => ["public_repo"],
      "token" => "abcdefgh12345678",
      "token_last_eight" => "12345678",
      "hashed_token" => "25f94a2a5c7fbaf499c665bc73d67c1c87e496da8985131633ee0a95819db2e8",
      "app" => {
        "url" => "http://my-github-app.com",
        "name" => "my github app",
        "client_id" => "abcde12345fghij67890"
      },
      "note" => "optional note",
      "note_url" => "http://optional/note/url",
      "updated_at" => "2011-09-06T20:39:23Z",
      "created_at" => "2011-09-06T17:26:27Z",
      "fingerprint" => "jklmnop12345678",
    }

    OAUTH_ACCESS_WITH_USER ||= OAUTH_ACCESS.merge(:user => USER)

    EVENT ||= {
      :type   => "Event",
      :public => true,
      :payload => {},
      :repo => {
        :id => 3,
        :name => "octocat/Hello-World",
        :url => "https://api.github.com/repos/octocat/Hello-World"
      },
      :actor => {
        :id => 1,
        :login => "octocat",
        :gravatar_id => "",
        :avatar_url => "https://github.com/images/error/octocat_happy.gif",
        :url => "https://api.github.com/users/octocat"
      },
      :org => {
        :id => 1,
        :login => "github",
        :gravatar_id => "",
        :url => "https://api.github.com/orgs/github",
        :avatar_url =>  "https://github.com/images/error/octocat_happy.gif"
      },
      :created_at => "2011-09-06T17:26:27Z",
      :id => "12345"
    }

    README_CONTENT ||= {
      "type" =>  "file",
      "encoding" =>  "base64",
      "size" =>  5362,
      "name" =>  "README.md",
      "path" =>  "README.md",
      "content" =>  "encoded content ...",
      "sha" =>  "3d21ec53a331a6f037a91c368710b99387d012c1",
      "url" => "https://api.github.com/repos/octokit/octokit.rb/contents/README.md",
      "git_url" => "https://api.github.com/repos/octokit/octokit.rb/git/blobs/3d21ec53a331a6f037a91c368710b99387d012c1",
      "html_url" => "https://github.com/octokit/octokit.rb/blob/master/README.md",
      "download_url"      => "https://raw.githubusercontent.com/octokit/octokit.rb/master/README.md",
      "_links" =>  {
        "git" =>  "https://api.github.com/repos/octokit/octokit.rb/git/blobs/3d21ec53a331a6f037a91c368710b99387d012c1",
        "self" =>  "https://api.github.com/repos/octokit/octokit.rb/contents/README.md",
        "html" =>  "https://github.com/octokit/octokit.rb/blob/master/README.md"
      },
    }

    SYMLINK_CONTENT ||= {
      "type" => "symlink",
      "target" => "/path/to/symlink/target",
      "size" => 23,
      "name" => "some-symlink",
      "path" => "bin/some-symlink",
      "sha" => "452a98979c88e093d682cab404a3ec82babebb48",
      "url" => "https://api.github.com/repos/octokit/octokit.rb/contents/bin/some-symlink",
      "git_url" => "https://api.github.com/repos/octokit/octokit.rb/git/blobs/452a98979c88e093d682cab404a3ec82babebb48",
      "html_url" => "https://github.com/octokit/octokit.rb/blob/master/bin/some-symlink",
      "download_url"      => "https://raw.githubusercontent.com/octokit/octokit.rb/master/bin/some-symlink",
      "_links" => {
        "git" => "https://api.github.com/repos/octokit/octokit.rb/git/blobs/452a98979c88e093d682cab404a3ec82babebb48",
        "self" => "https://api.github.com/repos/octokit/octokit.rb/contents/bin/some-symlink",
        "html" => "https://github.com/octokit/octokit.rb/blob/master/bin/some-symlink"
      },
    }

    SUBMODULE_CONTENT ||= {
      "type" => "submodule",
      "submodule_git_url" => "git://github.com/jquery/qunit.git",
      "size" => 0,
      "name" => "qunit",
      "path" => "test/qunit",
      "sha" => "6ca3721222109997540bd6d9ccd396902e0ad2f9",
      "url" => "https://api.github.com/repos/jquery/jquery/contents/test/qunit?ref=master",
      "git_url" => "https://api.github.com/repos/jquery/qunit/git/trees/6ca3721222109997540bd6d9ccd396902e0ad2f9",
      "html_url" => "https://github.com/jquery/qunit/tree/6ca3721222109997540bd6d9ccd396902e0ad2f9",
      "download_url"      => nil,
      "_links" => {
        "git" => "https://api.github.com/repos/jquery/qunit/git/trees/6ca3721222109997540bd6d9ccd396902e0ad2f9",
        "self" => "https://api.github.com/repos/jquery/jquery/contents/test/qunit?ref=master",
        "html" => "https://github.com/jquery/qunit/tree/6ca3721222109997540bd6d9ccd396902e0ad2f9"
      }
    }

    DIRECTORY_CONTENT ||= [
      {
        "type" => "file",
        "size" => 625,
        "name" => "octokit.rb",
        "path" => "lib/octokit.rb",
        "sha" => "fff6fe3a23bf1c8ea0692b4a883af99bee26fd3b",
        "url" => "https://api.github.com/repos/octokit/octokit.rb/contents/lib/octokit.rb",
        "git_url" => "https://api.github.com/repos/octokit/octokit.rb/git/blobs/fff6fe3a23bf1c8ea0692b4a883af99bee26fd3b",
        "html_url" => "https://github.com/octokit/octokit.rb/blob/master/lib/octokit.rb",
        "download_url"      => "https://raw.githubusercontent.com/octokit/octokit.rb/master/lib/octokit.rb",
        "_links" => {
          "self" => "https://api.github.com/repos/octokit/octokit.rb/contents/lib/octokit.rb",
          "git" => "https://api.github.com/repos/octokit/octokit.rb/git/blobs/fff6fe3a23bf1c8ea0692b4a883af99bee26fd3b",
          "html" => "https://github.com/octokit/octokit.rb/blob/master/lib/octokit.rb",
        },
      },
      {
        "type" => "dir",
        "size" => 0,
        "name" => "octokit",
        "path" => "lib/octokit",
        "sha" => "a84d88e7554fc1fa21bcbc4efae3c782a70d2b9d",
        "url" => "https://api.github.com/repos/octokit/octokit.rb/contents/lib/octokit",
        "git_url" => "https://api.github.com/repos/octokit/octokit.rb/git/trees/a84d88e7554fc1fa21bcbc4efae3c782a70d2b9d",
        "html_url" => "https://github.com/octokit/octokit.rb/tree/master/lib/octokit",
        "download_url"      => nil,
        "_links" => {
          "self" => "https://api.github.com/repos/octokit/octokit.rb/contents/lib/octokit",
          "git" => "https://api.github.com/repos/octokit/octokit.rb/git/trees/a84d88e7554fc1fa21bcbc4efae3c782a70d2b9d",
          "html" => "https://github.com/octokit/octokit.rb/tree/master/lib/octokit"
        },
      },
    ]

    DEPLOYMENT ||= {
      "url" => "https://api.github.com/repos/octocat/example/deployments/1",
      "id" => 1,
      "sha" => "a84d88e7554fc1fa21bcbc4efae3c782a70d2b9d",
      "ref" => "master",
      "task" => "deploy",
      "payload" => {:task => 'deploy:migrate'},
      "environment" => "production",
      "description" => "Deploy request from hubot",
      "creator" => USER,
      "created_at" => "2012-07-20T01:19:13Z",
      "updated_at" => "2012-07-20T01:19:13Z",
      "statuses_url" => "https://api.github.com/repos/octocat/example/deployments/1/statuses",
      "repository_url" => "https://api.github.com/repos/octocat/example"
    }

    DEPLOYMENT_STATUS ||= {
      "url" => "https://api.github.com/repos/octocat/example/deployments/42/statuses/1",
      "id" => 1,
      "state" => "success",
      "creator" => USER,
      "description" => "Deployment finished successfully.",
      "target_url" => "https://example.com/deployment/42/output",
      "created_at" => "2012-07-20T01:19:13Z",
      "updated_at" => "2012-07-20T01:19:13Z",
      "deployment_url" => "https://api.github.com/repos/octocat/example/deployments/42",
      "repository_url" => "https://api.github.com/repos/octocat/example",
      "deployment" => {
        "id" => 42,
        "ref" => "master",
        "sha" => "a84d88e7554fc1fa21bcbc4efae3c782a70d2b9d",
        "url" => "https://api.github.com/repos/octocat/example/deployments/42",
        "task" => "deploy",
        "creator" => USER,
        "environment" => "production",
        "payload" => {:task => 'deploy:migrate'},
        "created_at" => "2012-07-20T01:19:13Z",
        "updated_at" => "2012-07-20T01:19:13Z",
        "description" => "Deploy request from hubot",
        "statuses_url" => "https://api.github.com/repos/octocat/example/deployments/42/statuses"
      }
    }

    SIMPLE_STATUS ||= {
      "created_at" => "2012-07-20T01:19:13Z",
      "updated_at" => "2012-07-20T01:19:13Z",
      "state" => "success",
      "target_url" => "https://ci.example.com/1000/output",
      "description" => "Build has completed successfully",
      "id" => 1,
      "url" => "https://api.github.com/repos/octocat/Hello-World/statuses/1",
      "context" => "continuous-integration/jenkins"
    }

    OTHER_SIMPLE_STATUS ||= {
      "created_at" => "2012-08-20T01:19:13Z",
      "updated_at" => "2012-08-20T01:19:13Z",
      "state" => "success",
      "target_url" => "https://ci.example.com/2000/output",
      "description" => "Testing has completed successfully",
      "id" => 2,
      "url" => "https://api.github.com/repos/octocat/Hello-World/statuses/2",
      "context" => "security/brakeman"
    }

    STATUS ||= SIMPLE_STATUS.merge(
      "creator" => USER
    )

    COMBINED_STATUS ||= {
      "state" => "success",
      "sha"   => COMMIT["sha"],
      "total_count" => 2,
      "statuses" => [
        SIMPLE_STATUS,
        OTHER_SIMPLE_STATUS
      ],
      "repository" => SIMPLE_REPO,
      "commit_url" => "https://api.github.com/repos/octocat/Hello-World/#{COMMIT["sha"]}",
      "url" => "https://api.github.com/repos/octocat/Hello-World/#{COMMIT["sha"]}/status"
    }

    META ||= {
      :verifiable_password_authentication => true,
      :github_services_sha => "3a0f86fb8db8eea7ccbb9a95f325ddbedfb25e15",
      :hooks => ['127.0.0.1/32'],
      :git => ['127.0.0.1/32'],
      :pages => [
        "192.30.252.153/32",
        "192.30.252.154/32"
      ]
    }

    BLOB ||= {
      :content => "Q29udGVudCBvZiB0aGUgYmxvYg==\n",
      :encoding => "base64",
      :url      => "https://api.github.com/repos/octocat/example/git/blobs/3a0f86fb8db8eea7ccbb9a95f325ddbedfb25e15",
      :sha => "3a0f86fb8db8eea7ccbb9a95f325ddbedfb25e15",
      :size => 19
    }

    BLOB_AFTER_CREATE ||= {
       'url'      => "https://api.github.com/repos/octocat/example/git/blobs/3a0f86fb8db8eea7ccbb9a95f325ddbedfb25e15",
       'sha' => "3a0f86fb8db8eea7ccbb9a95f325ddbedfb25e15"
    }

    CONTENT_CRUD ||= {
      "content" => {
        "name" => "hello.txt",
        "path" => "notes/hello.txt",
        "sha" => "95b966ae1c166bd92f8ae7d1c313e738c731dfc3",
        "size" => 9,
        "url" => "https://api.github.com/repos/octocat/Hello-World/contents/notes/hello.txt",
        "html_url" => "https://github.com/octocat/Hello-World/blob/master/notes/hello.txt",
        "git_url" => "https://api.github.com/repos/octocat/Hello-World/git/blobs/95b966ae1c166bd92f8ae7d1c313e738c731dfc3",
        "download_url"      => "https://raw.githubusercontent.com/octocat/HelloWorld/master/notes/hello.txt",
        "type" => "file",
        "_links" => {
          "self" => "https://api.github.com/repos/octocat/Hello-World/contents/notes/hello.txt",
          "git" => "https://api.github.com/repos/octocat/Hello-World/git/blobs/95b966ae1c166bd92f8ae7d1c313e738c731dfc3",
          "html" => "https://github.com/octocat/Hello-World/blob/master/notes/hello.txt"
        }
      },
      "commit" => {
        "sha" => "7638417db6d59f3c431d3e1f261cc637155684cd",
        "url" => "https://api.github.com/repos/octocat/Hello-World/git/commits/7638417db6d59f3c431d3e1f261cc637155684cd",
        "html_url" => "https://github.com/octocat/Hello-World/git/commit/7638417db6d59f3c431d3e1f261cc637155684cd",
        "author" => {
          "date" => "2014-11-07T22:01:45Z",
          "name" => "Scott Chacon",
          "email" => "schacon@gmail.com"
        },
        "committer" => {
          "date" => "2014-11-07T22:01:45Z",
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

    THREAD ||= {
      :id => "1",
      :repository => SIMPLE_REPO,
      :subject => {
        :title => "Greetings",
        :url => "https://api.github.com/repos/octokit/octokit.rb/issues/123",
        :latest_comment_url => "https://api.github.com/repos/octokit/octokit.rb/issues/comments/123",
        :type => "Issue"
      },
      :reason => 'subscribed',
      :unread => true,
      :updated_at => '2014-11-07T22:01:45Z',
      :last_read_at => '2014-11-07T22:01:45Z',
      :url => "https://api.github.com/notifications/threads/1"
    }

    SUBSCRIPTION ||= {
      :subscribed => true,
      :ignored => false,
      :reason => nil,
      :created_at => "2012-10-06T21:34:12Z",
      :url => "https://api.github.com/notifications/threads/1/subscription",
      :thread_url => "https://api.github.com/notifications/threads/1"
    }

    REPO_SUBSCRIPTION ||= SUBSCRIPTION.merge \
      :url => "https://api.github.com/repos/octocat/example/subscription",
      :repository_url => "https://api.github.com/repos/octocat/example"
    REPO_SUBSCRIPTION.delete :thread_url

    TEMPLATE ||= {
      :name => "C",
      :source => "# Object files\n*.o\n\n# Libraries\n*.lib\n*.a\n\n# Shared objects (inc. Windows DLLs)\n*.dll\n*.so\n*.so.*\n*.dylib\n\n# Executables\n*.exe\n*.out\n*.app\n"
    }

    TEMPLATES ||= [
      "Actionscript",
      "Android",
      "AppceleratorTitanium",
      "Autotools",
      "Bancha",
      "C",
      "C++"
    ]

    USER_EMAIL ||= {
      :email    => "octocat@github.com",
      :verified => true,
      :primary  => true
    }

    REPO_STATS_CONTRIBUTORS ||= [{
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

    REPO_STATS_COMMIT_ACTIVITY ||= [{
      :days => [0, 3, 26, 20, 39, 1, 0],
      :total => 89,
      :week => 1336280400
    }]

    REPO_STATS_CODE_FREQUENCY ||= [[
      1302998400,
      1124,
      -435
    ]]

    REPO_STATS_PARTICIPATION ||= {
      :all => [11,21,15,2,8,1,8,23,17,21,11,10,33,91,38,34,22,23,32,3,43,87,71,18,13,5,13,16,66,27,12,45,110,117,13,8,18,9,19,26,39,12,20,31,46,91,45,10,24,9,29,7],
      :owner => [3,2,3,0,2,0,5,14,7,9,1,5,0,48,19,2,0,1,10,2,23,40,35,8,8,2,10,6,30,0,2,9,53,104,3,3,10,4,7,11,21,4,4,22,26,63,11,2,14,1,10,3]
    }

    REPO_STATS_PUNCH_CARD ||= [
      [0,0,5],
      [0,1,43],
      [0,2,21]
    ]

    FEEDS ||= {
      :timeline_url => "https://github.com/timeline",
      :user_url => "https://github.com/{user}",
      :current_user_public_url => "https://github.com/defunkt",
      :current_user_url => "https://github.com/defunkt.private?token=abc123",
      :current_user_actor_url => "https://github.com/defunkt.private.actor?token=abc123",
      :current_user_organization_url => "",
      :current_user_organization_urls => [
        "https://github.com/organizations/github/defunkt.private.atom?token=abc123"
      ],
      :_links => {
        :timeline => {
          :href => "https://github.com/timeline",
          :type => "application/atom+xml"
        },
        :user => {
          :href => "https://github.com/{user}",
          :type => "application/atom+xml"
        },
        :current_user_public => {
          :href => "https://github.com/defunkt",
          :type => "application/atom+xml"
        },
        :current_user => {
          :href => "https://github.com/defunkt.private?token=abc123",
          :type => "application/atom+xml"
        },
        :current_user_actor => {
          :href => "https://github.com/defunkt.private.actor?token=abc123",
          :type => "application/atom+xml"
        },
        :current_user_organization => {
          :href => "",
          :type => ""
        },
        :current_user_organizations => [
          {
            :href => "https://github.com/organizations/github/defunkt.private.atom?token=abc123",
            :type => "application/atom+xml"
          }
        ]
      }
    }

    EMOJIS ||= {
      "+1" => "https://github.global.ssl.fastly.net/images/icons/emoji/+1.png?v5",
      "-1" => "https://github.global.ssl.fastly.net/images/icons/emoji/-1.png?v5",
      "100" => "https://github.global.ssl.fastly.net/images/icons/emoji/100.png?v5",
      "1234" => "https://github.global.ssl.fastly.net/images/icons/emoji/1234.png?v5",
      "8ball" => "https://github.global.ssl.fastly.net/images/icons/emoji/8ball.png?v5",
      "a" => "https://github.global.ssl.fastly.net/images/icons/emoji/a.png?v5",
      "ab" => "https://github.global.ssl.fastly.net/images/icons/emoji/ab.png?v5"
    }

    ADMIN_STATS ||= {
      "repos" =>  {
        "total_repos" => 212,
        "root_repos" => 194,
        "fork_repos" => 18,
        "org_repos" => 51,
        "total_pushes" => 3082,
        "total_wikis" => 15
      },
      "hooks" =>  {
        "total_hooks" => 27,
        "active_hooks" => 23,
        "inactive_hooks" => 4
      },
      "pages" =>  {
        "total_pages" => 36
      },
      "orgs" =>  {
        "total_orgs" => 33,
        "disabled_orgs" => 0,
        "total_teams" => 60,
        "total_team_members" => 314
      },
      "users" =>  {
        "total_users" => 254,
        "admin_users" => 45,
        "suspended_users" => 21
      },
      "pulls" =>  {
        "total_pulls" => 86,
        "merged_pulls" => 60,
        "mergeable_pulls" => 21,
        "unmergeable_pulls" => 3,
      },
      "issues" =>  {
        "total_issues" => 179,
        "open_issues" => 83,
        "closed_issues" => 96
      },
      "milestones" =>  {
        "total_milestones" => 7,
        "open_milestones" => 6,
        "closed_milestones" => 1
      },
      "gists" =>  {
        "total_gists" => 178,
        "private_gists" => 151,
        "public_gists" => 25
      },
      "comments" =>  {
        "total_commit_comments" => 6,
        "total_gist_comments" => 28,
        "total_issue_comments" => 366,
        "total_pull_request_comments" => 30
      }
    }

    LICENSING ||= {
      "seats" => 1400,
      "seats_used" => 1316,
      "seats_available" => 84,
      "kind" => "standard",
      "days_until_expiration" => 365,
      "expire_at" => "2016/02/06 12:41:52 -0600"
    }

    INDEXING_SUCCESS ||= {
      "message" => "Repository 'kansaichris/japaning' has been added to the indexing queue"
    }

    CONFIG_STATUSES ||= {
      "status" => "running",
      "progress" => [
        {
          "status" =>  "DONE",
          "key" =>  "Appliance core components"
        },
        {
          "status" =>  "DONE",
          "key" =>  "GitHub utilities"
        },
        {
          "status" =>  "DONE",
          "key" =>  "GitHub applications"
        },
        {
          "status" =>  "CONFIGURING",
          "key" =>  "GitHub services"
        },
        {
          "status" =>  "PENDING",
          "key" =>  "Reloading appliance services"
        }
      ]
    }

    FETCH_SETTINGS ||= {
      "enterprise" => {
        "private_mode" => false,
        "github_hostname" => "ghe.local",
        "auth_mode" => "default",
        "storage_mode" => "rootfs",
        "admin_password" => nil,
        "configuration_id" => 1401777404,
        "configuration_run_count" => 4,
        "package_version" => "11.10.332",
        "avatar" => {
          "enabled" => false,
          "uri" => ""
        },
        "customer" => {
          "name" => "GitHub",
          "email" => "stannis@themannis.biz",
          "uuid" => "af6cac80-e4e1-012e-d822-1231380e52e9",
          "secret_key_data" => "-----BEGIN PGP PRIVATE KEY BLOCK-----\nVersion: GnuPG v1.4.10 (GNU/Linux)\n\nlQcYBE5TCgsBEACk4yHpUcapplebaumBMXYMiLF+nCQ0lxpx...\n-----END PGP PRIVATE KEY BLOCK-----\n",
          "public_key_data" => "-----BEGIN PGP PUBLIC KEY BLOCK-----\nVersion: GnuPG v1.4.10 (GNU/Linux)\n\nmI0ETqzZYgEEALSe6snowdenXyqvLfSQ34HWD6C7....\n-----END PGP PUBLIC KEY BLOCK-----\n"
        },
        "license" => {
          "seats" => 0,
          "evaluation" => false,
          "expire_at" => "2015-04-27T00:00:00-07:00",
          "perpetual" => false,
          "unlimited_seating" => true,
          "support_key" => "ssh-rsa AAAAB3N....",
          "ssh_allowed" => true
        },
        "github_ssl" => {
          "enabled" => false,
          "cert" => nil,
          "key" => nil
        },
        "ldap" => {
          "host" => "",
          "port" => "",
          "base" => [

          ],
          "uid" => "",
          "bind_dn" => "",
          "password" => "",
          "method" => "Plain",
          "user_groups" => [

          ],
          "admin_group" => ""
        },
        "cas" => {
          "url" => ""
        },
        "github_oauth" => {
          "client_id" => "12313412",
          "client_secret" => "kj123131132",
          "organization_name" => "Homestar Runners",
          "organization_team" => "homestarrunners/characters"
        },
        "smtp" => {
          "enabled" => true,
          "address" => "smtp.example.com",
          "authentication" => "plain",
          "port" => "1234",
          "domain" => "blah",
          "username" => "foo",
          "user_name" => "mr_foo",
          "enable_starttls_auto" => true,
          "password" => "bar",
          "support_address" => "enterprise@github.com",
          "noreply_address" => "noreply@github.com"
        },
        "dns" => {
          "primary_nameserver" => "8.8.8.8",
          "secondary_nameserver" => "8.8.4.4"
        },
        "ntp" => {
          "primary_server" => "0.ubuntu.pool.ntp.org",
          "secondary_server" => "1.ubuntu.pool.ntp.org"
        },
        "timezone" => {
          "identifier" => "UTC"
        },
        "device" => {
          "path" => "/dev/xyz"
        },
        "snmp" => {
          "enabled" => false,
          "community" => ""
        },
        "rsyslog" => {
          "enabled" => false,
          "server" => "",
          "protocol_name" => "TCP"
        },
        "assets" => {
          "storage" => "file",
          "bucket" => nil,
          "host_name" => nil,
          "key_id" => nil,
          "access_key" => nil
        },
        "pages" => {
          "enabled" => true
        },
        "collectd" => {
          "enabled" => false,
          "server" => "",
          "port" => "",
          "encryption" => "",
          "username" => "foo",
          "password" => "bar"
        }
      },
      "run_list" => [
        "role[configure]"
      ]
    }

    CHECK_MAINTENANCE_STATUS ||= {
      "status" =>  "scheduled",
      "scheduled_time" =>  "Tuesday, January 22 at 15 => 34 -0800",
      "connection_services" =>  [
        {
          "name" =>  "git operations", "number" =>  0
        },
        {
          "name" =>  "mysql queries", "number" =>  233
        },
        {
          "name" =>  "resque jobs", "number" =>  54
        }
      ]
    }

    SET_MAINTENANCE_STATUS ||= {
      "status" =>  "scheduled",
      "scheduled_time" =>  "Tuesday, January 22 at 15 => 34 -0800",
      "connection_services" =>  [
        {
          "name" =>  "git operations", "number" =>  0
        },
        {
          "name" =>  "mysql queries", "number" =>  233
        },
        {
          "name" =>  "resque jobs", "number" =>  54
        }
      ]
    }

    GET_AUTHORIZED_SSH_KEYS ||= [
      {
        "key" => "ssh-rsa AAAAB3NzaC1yc2EAAAAB...",
        "pretty-print" => "ssh-rsa 01:14:0f:f2:0f:e2:fe:e8:f4:72:62:af:75:f7:1a:88:3e:04:92:64"
      },
      {
        "key" => "ssh-rsa AAAAB3NzaC1yc2EAAAAB...",
        "pretty-print" => "ssh-rsa 01:14:0f:f2:0f:e2:fe:e8:f4:72:62:af:75:f7:1a:88:3e:04:92:64"
      }
    ]

    LDAP_USER_UPDATE ||= {
      'ldap_dn' => 'uid=asdf,ou=users,dc=github,dc=com'
    }.merge(USER)

    LDAP_TEAM_UPDATE ||= {
      'ldap_dn' => 'cn=Enterprise Ops,ou=teams,dc=github,dc=com'
    }.merge(TEAM)

    LDAP_SYNC_CONFIRM ||= {
      'status' => 'queued'
    }

    LICENSES ||= [
      {"key"=>"agpl-3.0", "name"=>"GNU Affero GPL v3.0", "url"=>"https://api.github.com/licenses/agpl-3.0"},
      {"key"=>"apache-2.0", "name"=>"Apache License 2.0", "url"=>"https://api.github.com/licenses/apache-2.0"},
      {"key"=>"artistic-2.0", "name"=>"Artistic License 2.0", "url"=>"https://api.github.com/licenses/artistic-2.0"},
      {"key"=>"bsd-2-clause", "name"=>"Simplified BSD", "url"=>"https://api.github.com/licenses/bsd-2-clause"},
      {"key"=>"bsd-3-clause", "name"=>"New BSD", "url"=>"https://api.github.com/licenses/bsd-3-clause"},
      {"key"=>"cc0", "name"=>"CC0 1.0 Universal", "url"=>"https://api.github.com/licenses/cc0"},
      {"key"=>"epl-1.0", "name"=>"Eclipse Public License v1.0", "url"=>"https://api.github.com/licenses/epl-1.0"},
      {"key"=>"gpl-2.0", "name"=>"GNU GPL v2.0", "url"=>"https://api.github.com/licenses/gpl-2.0"},
      {"key"=>"gpl-3.0", "name"=>"GNU GPL v3.0", "url"=>"https://api.github.com/licenses/gpl-3.0"},
      {"key"=>"isc", "name"=>"ISC license", "url"=>"https://api.github.com/licenses/isc"},
      {"key"=>"lgpl-2.1", "name"=>"GNU LGPL v2.1", "url"=>"https://api.github.com/licenses/lgpl-2.1"},
      {"key"=>"lgpl-3.0", "name"=>"GNU LGPL v3.0", "url"=>"https://api.github.com/licenses/lgpl-3.0"},
      {"key"=>"mit", "name"=>"MIT License", "url"=>"https://api.github.com/licenses/mit"},
      {"key"=>"mpl-2.0", "name"=>"Mozilla Public License 2.0", "url"=>"https://api.github.com/licenses/mpl-2.0"},
      {"key"=>"unlicense", "name"=>"Public Domain (Unlicense)", "url"=>"https://api.github.com/licenses/unlicense"}
    ]

    MIT ||= {
      "key"=>"mit",
      "name"=>"MIT License",
      "url"=>"https://api.github.com/licenses/mit",
      "html_url"=>"http://choosealicense.com/licenses/mit/",
      "featured"=>true,
      "description"=>"A permissive license that is short and to the point. It lets people do anything with your code with proper attribution and without warranty.",
      "category"=>"MIT",
      "implementation"=>
      "Create a text file (typically named LICENSE or LICENSE.txt) in the root of your source code and copy the text of the license into the file. Replace [year] with the current year and [fullname] with the name (or names) of the copyright holders.",
      "required"=>["include-copyright"],
      "permitted"=>["commercial-use", "modifications", "distribution", "sublicense", "private-use"],
      "forbidden"=>["no-liability"],
      "body"=>
      "\n\nThe MIT License (MIT)\n\nCopyright (c) [year] [fullname]\n\nPermission is hereby granted, free of charge, to any person obtaining a copy\nof this software and associated documentation files (the \"Software\"), to deal\nin the Software without restriction, including without limitation the rights\nto use, copy, modify, merge, publish, distribute, sublicense, and/or sell\ncopies of the Software, and to permit persons to whom the Software is\nfurnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all\ncopies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\nIMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\nFITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\nAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\nLIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\nOUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE\nSOFTWARE.\n"
    }

    LICENSEE ||= {
      "id"=>23022377,
      "name"=>"licensee",
      "full_name"=>"benbalter/licensee",
      "owner"=>{
        "login"=>"benbalter",
        "id"=>282759,
        "avatar_url"=>"https://avatars.githubusercontent.com/u/282759?v=3",
        "gravatar_id"=>"",
        "url"=>"https://api.github.com/users/benbalter",
        "html_url"=>"https://github.com/benbalter",
        "followers_url"=>"https://api.github.com/users/benbalter/followers",
        "following_url"=>"https://api.github.com/users/benbalter/following{/other_user}",
        "gists_url"=>"https://api.github.com/users/benbalter/gists{/gist_id}",
        "starred_url"=>"https://api.github.com/users/benbalter/starred{/owner}{/repo}",
        "subscriptions_url"=>"https://api.github.com/users/benbalter/subscriptions",
        "organizations_url"=>"https://api.github.com/users/benbalter/orgs",
        "repos_url"=>"https://api.github.com/users/benbalter/repos",
        "events_url"=>"https://api.github.com/users/benbalter/events{/privacy}",
        "received_events_url"=>"https://api.github.com/users/benbalter/received_events",
        "type"=>"User",
        "site_admin"=>true
      },
      "private"=>false,
      "html_url"=>"https://github.com/benbalter/licensee",
      "description"=>"A Ruby Gem to detect under what license a project is distributed.",
      "fork"=>false, "url"=>"https://api.github.com/repos/benbalter/licensee",
      "forks_url"=>"https://api.github.com/repos/benbalter/licensee/forks",
      "keys_url"=>"https://api.github.com/repos/benbalter/licensee/keys{/key_id}",
      "collaborators_url"=>"https://api.github.com/repos/benbalter/licensee/collaborators{/collaborator}",
      "teams_url"=>"https://api.github.com/repos/benbalter/licensee/teams",
      "hooks_url"=>"https://api.github.com/repos/benbalter/licensee/hooks",
      "issue_events_url"=>"https://api.github.com/repos/benbalter/licensee/issues/events{/number}",
      "events_url"=>"https://api.github.com/repos/benbalter/licensee/events",
      "assignees_url"=>"https://api.github.com/repos/benbalter/licensee/assignees{/user}",
      "branches_url"=>"https://api.github.com/repos/benbalter/licensee/branches{/branch}",
      "tags_url"=>"https://api.github.com/repos/benbalter/licensee/tags",
      "blobs_url"=>"https://api.github.com/repos/benbalter/licensee/git/blobs{/sha}",
      "git_tags_url"=>"https://api.github.com/repos/benbalter/licensee/git/tags{/sha}",
      "git_refs_url"=>"https://api.github.com/repos/benbalter/licensee/git/refs{/sha}",
      "trees_url"=>"https://api.github.com/repos/benbalter/licensee/git/trees{/sha}",
      "statuses_url"=>"https://api.github.com/repos/benbalter/licensee/statuses/{sha}",
      "languages_url"=>"https://api.github.com/repos/benbalter/licensee/languages",
      "stargazers_url"=>"https://api.github.com/repos/benbalter/licensee/stargazers",
      "contributors_url"=>"https://api.github.com/repos/benbalter/licensee/contributors",
      "subscribers_url"=>"https://api.github.com/repos/benbalter/licensee/subscribers",
      "subscription_url"=>"https://api.github.com/repos/benbalter/licensee/subscription",
      "commits_url"=>"https://api.github.com/repos/benbalter/licensee/commits{/sha}",
      "git_commits_url"=>"https://api.github.com/repos/benbalter/licensee/git/commits{/sha}",
      "comments_url"=>"https://api.github.com/repos/benbalter/licensee/comments{/number}",
      "issue_comment_url"=>"https://api.github.com/repos/benbalter/licensee/issues/comments{/number}",
      "contents_url"=>"https://api.github.com/repos/benbalter/licensee/contents/{+path}",
      "compare_url"=>"https://api.github.com/repos/benbalter/licensee/compare/{base}...{head}",
      "merges_url"=>"https://api.github.com/repos/benbalter/licensee/merges",
      "archive_url"=>"https://api.github.com/repos/benbalter/licensee/{archive_format}{/ref}",
      "downloads_url"=>"https://api.github.com/repos/benbalter/licensee/downloads",
      "issues_url"=>"https://api.github.com/repos/benbalter/licensee/issues{/number}",
      "pulls_url"=>"https://api.github.com/repos/benbalter/licensee/pulls{/number}",
      "milestones_url"=>"https://api.github.com/repos/benbalter/licensee/milestones{/number}",
      "notifications_url"=>"https://api.github.com/repos/benbalter/licensee/notifications{?since,all,participating}",
      "labels_url"=>"https://api.github.com/repos/benbalter/licensee/labels{/name}",
      "releases_url"=>"https://api.github.com/repos/benbalter/licensee/releases{/id}",
      "created_at"=>"2014-08-16T16:39:56Z",
      "updated_at"=>"2015-02-26T18:58:36Z",
      "pushed_at"=>"2015-02-26T19:09:18Z",
      "git_url"=>"git://github.com/benbalter/licensee.git",
      "ssh_url"=>"git@github.com:benbalter/licensee.git",
      "clone_url"=>"https://github.com/benbalter/licensee.git",
      "svn_url"=>"https://github.com/benbalter/licensee",
      "homepage"=>"",
      "size"=>687,
      "stargazers_count"=>20,
      "watchers_count"=>20,
      "language"=>"Ruby",
      "has_issues"=>true,
      "has_downloads"=>true,
      "has_wiki"=>false,
      "has_pages"=>false,
      "forks_count"=>6,
      "mirror_url"=>nil,
      "open_issues_count"=>2,
      "forks"=>6,
      "open_issues"=>2,
      "watchers"=>20,
      "default_branch"=>"master",
      "master_branch"=>"master",
      "license"=> {
        "key"=>"mit",
        "name"=>"MIT License",
        "url"=>"https://api.github.com/licenses/mit"
      },
      "network_count"=>6,
      "subscribers_count"=>6
    }

    LICENSE_CONTENTS ||= {
        "name"         => "LICENSE",
        "path"         => "LICENSE",
        "sha"          => "401c59dcc4570b954dd6d345e76199e1f4e76266",
        "size"         => 1077,
        "url"          => "https://api.github.com/repos/benbalter/gman/contents/LICENSE?ref=master",
        "html_url"     => "https://github.com/benbalter/gman/blob/master/LICENSE",
        "git_url"      => "https://api.github.com/repos/benbalter/gman/git/blobs/401c59dcc4570b954dd6d345e76199e1f4e76266",
        "download_url" => "https://raw.githubusercontent.com/benbalter/gman/master/LICENSE?lab=true",
        "type"         => "file",
        "content"      => "VGhlIE1JVCBMaWNlbnNlIChNSVQpCgpDb3B5cmlnaHQgKGMpIDIwMTMgQmVu\nIEJhbHRlcgoKUGVybWlzc2lvbiBpcyBoZXJlYnkgZ3JhbnRlZCwgZnJlZSBv\nZiBjaGFyZ2UsIHRvIGFueSBwZXJzb24gb2J0YWluaW5nIGEgY29weSBvZgp0\naGlzIHNvZnR3YXJlIGFuZCBhc3NvY2lhdGVkIGRvY3VtZW50YXRpb24gZmls\nZXMgKHRoZSAiU29mdHdhcmUiKSwgdG8gZGVhbCBpbgp0aGUgU29mdHdhcmUg\nd2l0aG91dCByZXN0cmljdGlvbiwgaW5jbHVkaW5nIHdpdGhvdXQgbGltaXRh\ndGlvbiB0aGUgcmlnaHRzIHRvCnVzZSwgY29weSwgbW9kaWZ5LCBtZXJnZSwg\ncHVibGlzaCwgZGlzdHJpYnV0ZSwgc3VibGljZW5zZSwgYW5kL29yIHNlbGwg\nY29waWVzIG9mCnRoZSBTb2Z0d2FyZSwgYW5kIHRvIHBlcm1pdCBwZXJzb25z\nIHRvIHdob20gdGhlIFNvZnR3YXJlIGlzIGZ1cm5pc2hlZCB0byBkbyBzbywK\nc3ViamVjdCB0byB0aGUgZm9sbG93aW5nIGNvbmRpdGlvbnM6CgpUaGUgYWJv\ndmUgY29weXJpZ2h0IG5vdGljZSBhbmQgdGhpcyBwZXJtaXNzaW9uIG5vdGlj\nZSBzaGFsbCBiZSBpbmNsdWRlZCBpbiBhbGwKY29waWVzIG9yIHN1YnN0YW50\naWFsIHBvcnRpb25zIG9mIHRoZSBTb2Z0d2FyZS4KClRIRSBTT0ZUV0FSRSBJ\nUyBQUk9WSURFRCAiQVMgSVMiLCBXSVRIT1VUIFdBUlJBTlRZIE9GIEFOWSBL\nSU5ELCBFWFBSRVNTIE9SCklNUExJRUQsIElOQ0xVRElORyBCVVQgTk9UIExJ\nTUlURUQgVE8gVEhFIFdBUlJBTlRJRVMgT0YgTUVSQ0hBTlRBQklMSVRZLCBG\nSVRORVNTCkZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRSBBTkQgTk9OSU5GUklO\nR0VNRU5ULiBJTiBOTyBFVkVOVCBTSEFMTCBUSEUgQVVUSE9SUyBPUgpDT1BZ\nUklHSFQgSE9MREVSUyBCRSBMSUFCTEUgRk9SIEFOWSBDTEFJTSwgREFNQUdF\nUyBPUiBPVEhFUiBMSUFCSUxJVFksIFdIRVRIRVIKSU4gQU4gQUNUSU9OIE9G\nIENPTlRSQUNULCBUT1JUIE9SIE9USEVSV0lTRSwgQVJJU0lORyBGUk9NLCBP\nVVQgT0YgT1IgSU4KQ09OTkVDVElPTiBXSVRIIFRIRSBTT0ZUV0FSRSBPUiBU\nSEUgVVNFIE9SIE9USEVSIERFQUxJTkdTIElOIFRIRSBTT0ZUV0FSRS4K\n",
        "encoding"     => "base64",
        "_links"       => {
          "self" => "https://api.github.com/repos/benbalter/gman/contents/LICENSE?ref=master",
          "git"  => "https://api.github.com/repos/benbalter/gman/git/blobs/401c59dcc4570b954dd6d345e76199e1f4e76266",
          "html" => "https://github.com/benbalter/gman/blob/master/LICENSE"
        },
        "license"      => {
          "key"      => "mit",
          "name"     => "MIT License",
          "url"      => "https://api.github.com/licenses/mit",
          "featured" => true
        }
      }
  end
end

include GitHub::Resources::Helpers
