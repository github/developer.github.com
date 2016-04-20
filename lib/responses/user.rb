module GitHub
  module Resources
    module Responses
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

      USER_EMAIL ||= {
        :email    => "octocat@github.com",
        :verified => true,
        :primary  => true
      }
    end
  end
end
