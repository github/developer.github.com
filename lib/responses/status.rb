module GitHub
  module Resources
    module Responses
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
    end
  end
end
