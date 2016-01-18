module GitHub
  module Resources
    module Responses
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
    end
  end
end
