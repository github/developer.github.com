module GitHub
  module Resources
    module Responses
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
    end
  end
end
