module GitHub
  module Resources
    module Responses
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
    end
  end
end
