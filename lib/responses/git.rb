require_relative 'user'

module GitHub
  module Resources
    module Responses
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
          },
          "protection" => {
            "enabled" => false,
            "required_status_checks" => {
              "enforcement_level" => "off",
              "contexts" => []
            }
          }
        }
      ]

      BRANCH ||= {"name"=>"master",
        "protection" => {
          "enabled" => false,
          "required_status_checks" => {
            "enforcement_level" => "off",
            "contexts" => []
          }
        },
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
    end
  end
end
