module GitHub
  module Resources
    module Responses
      SIMPLE_PUBLIC_KEY ||= {
        "id"    => 1,
        "key"   => "ssh-rsa AAA..."
      }

      PUBLIC_KEY ||= SIMPLE_PUBLIC_KEY.merge \
        "url"        => "https://api.github.com/user/keys/1",
        "title"      => "octocat@octomac",
        "verified"   => true,
        "created_at" => "2014-12-10T15:53:42Z",
        "read_only"  => true

      PUBLIC_KEY_DETAIL ||= PUBLIC_KEY.merge \
        "user_id"        => 232,
        "repository_id"  => nil

      DEPLOY_KEY ||= SIMPLE_PUBLIC_KEY.merge \
        "url"        => "https://api.github.com/repos/octocat/Hello-World/keys/1",
        "title"      => "octocat@octomac",
        "verified"   => true,
        "created_at" => "2014-12-10T15:53:42Z",
        "read_only"  => true

      DEPLOY_KEY_DETAIL ||= PUBLIC_KEY.merge \
        "user_id"        => nil,
        "repository_id"  => 2333

      ALL_KEYS ||= [PUBLIC_KEY_DETAIL, DEPLOY_KEY_DETAIL]
    end
  end
end
