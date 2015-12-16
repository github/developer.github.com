require_relative 'user'

module GitHub
  module Resources
    module Responses
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
        "truncated"    => false,
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
    end
  end
end
