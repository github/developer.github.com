require_relative 'user'

module GitHub
  module Resources
    module Responses
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
    end
  end
end
