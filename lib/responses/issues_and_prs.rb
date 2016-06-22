require_relative 'user'
require_relative 'repos'

module GitHub
  module Resources
    module Responses
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
    end
  end
end
