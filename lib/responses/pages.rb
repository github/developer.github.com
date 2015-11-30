require_relative 'user'

module GitHub
  module Resources
    module Responses
      PAGES ||= {
        "url" => "https://api.github.com/repos/github/developer.github.com/pages",
        "status" => "built",
        "cname" => "developer.github.com",
        "custom_404" => false
      }

      PAGES_BUILD ||= {
        "url" => "https://api.github.com/repos/github/developer.github.com/pages/builds/5472601",
        "status" => "built",
        "error" => {
          "message" => nil
        },
        "pusher" => USER,
        "commit" => "351391cdcb88ffae71ec3028c91f375a8036a26b",
        "duration" => 2104,
        "created_at" => "2014-02-10T19:00:49Z",
        "updated_at" => "2014-02-10T19:00:51Z"
      }
    end
  end
end
