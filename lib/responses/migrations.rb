require_relative 'repos'

module GitHub
  module Resources
    module Responses
      MIGRATIONS ||= {
        "id" => 79,
        "guid" => "0b989ba4-242f-11e5-81e1-c7b6966d2516",
        "state" => "pending",
        "lock_repositories" => true,
        "exclude_attachments" => false,
        "url" => "https://api.github.com/orgs/octo-org/migrations/79",
        "created_at" => "2015-07-06T15:33:38-07:00",
        "updated_at" => "2015-07-06T15:33:38-07:00",
        "repositories" => [REPO]
      }
    end
  end
end
