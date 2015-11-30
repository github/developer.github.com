module GitHub
  module Resources
    module Responses
      META ||= {
        :verifiable_password_authentication => true,
        :github_services_sha => "3a0f86fb8db8eea7ccbb9a95f325ddbedfb25e15",
        :hooks => ['127.0.0.1/32'],
        :git => ['127.0.0.1/32'],
        :pages => [
          "192.30.252.153/32",
          "192.30.252.154/32"
        ]
      }

      TEMPLATE ||= {
        :name => "C",
        :source => "# Object files\n*.o\n\n# Libraries\n*.lib\n*.a\n\n# Shared objects (inc. Windows DLLs)\n*.dll\n*.so\n*.so.*\n*.dylib\n\n# Executables\n*.exe\n*.out\n*.app\n"
      }

      TEMPLATES ||= [
        "Actionscript",
        "Android",
        "AppceleratorTitanium",
        "Autotools",
        "Bancha",
        "C",
        "C++"
      ]

      FEEDS ||= {
        :timeline_url => "https://github.com/timeline",
        :user_url => "https://github.com/{user}",
        :current_user_public_url => "https://github.com/defunkt",
        :current_user_url => "https://github.com/defunkt.private?token=abc123",
        :current_user_actor_url => "https://github.com/defunkt.private.actor?token=abc123",
        :current_user_organization_url => "",
        :current_user_organization_urls => [
          "https://github.com/organizations/github/defunkt.private.atom?token=abc123"
        ],
        :_links => {
          :timeline => {
            :href => "https://github.com/timeline",
            :type => "application/atom+xml"
          },
          :user => {
            :href => "https://github.com/{user}",
            :type => "application/atom+xml"
          },
          :current_user_public => {
            :href => "https://github.com/defunkt",
            :type => "application/atom+xml"
          },
          :current_user => {
            :href => "https://github.com/defunkt.private?token=abc123",
            :type => "application/atom+xml"
          },
          :current_user_actor => {
            :href => "https://github.com/defunkt.private.actor?token=abc123",
            :type => "application/atom+xml"
          },
          :current_user_organization => {
            :href => "",
            :type => ""
          },
          :current_user_organizations => [
            {
              :href => "https://github.com/organizations/github/defunkt.private.atom?token=abc123",
              :type => "application/atom+xml"
            }
          ]
        }
      }

      EMOJIS ||= {
        "+1" => "https://github.global.ssl.fastly.net/images/icons/emoji/+1.png?v5",
        "-1" => "https://github.global.ssl.fastly.net/images/icons/emoji/-1.png?v5",
        "100" => "https://github.global.ssl.fastly.net/images/icons/emoji/100.png?v5",
        "1234" => "https://github.global.ssl.fastly.net/images/icons/emoji/1234.png?v5",
        "8ball" => "https://github.global.ssl.fastly.net/images/icons/emoji/8ball.png?v5",
        "a" => "https://github.global.ssl.fastly.net/images/icons/emoji/a.png?v5",
        "ab" => "https://github.global.ssl.fastly.net/images/icons/emoji/ab.png?v5"
      }
    end
  end
end
