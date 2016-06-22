require_relative 'user'

module GitHub
  module Resources
    module Responses
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
    end
  end
end
