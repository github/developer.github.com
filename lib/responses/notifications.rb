require_relative 'repos'

module GitHub
  module Resources
    module Responses
      THREAD ||= {
        :id => "1",
        :repository => SIMPLE_REPO,
        :subject => {
          :title => "Greetings",
          :url => "https://api.github.com/repos/octokit/octokit.rb/issues/123",
          :latest_comment_url => "https://api.github.com/repos/octokit/octokit.rb/issues/comments/123",
          :type => "Issue"
        },
        :reason => 'subscribed',
        :unread => true,
        :updated_at => '2014-11-07T22:01:45Z',
        :last_read_at => '2014-11-07T22:01:45Z',
        :url => "https://api.github.com/notifications/threads/1"
      }

      SUBSCRIPTION ||= {
        :subscribed => true,
        :ignored => false,
        :reason => nil,
        :created_at => "2012-10-06T21:34:12Z",
        :url => "https://api.github.com/notifications/threads/1/subscription",
        :thread_url => "https://api.github.com/notifications/threads/1"
      }

      REPO_SUBSCRIPTION ||= SUBSCRIPTION.merge \
        :url => "https://api.github.com/repos/octocat/example/subscription",
        :repository_url => "https://api.github.com/repos/octocat/example"
      REPO_SUBSCRIPTION.delete :thread_url
    end
  end
end
