require_relative 'user'

module GitHub
  module Resources
    module Responses
      RELEASE_ASSET ||= {
        "url"                  => "https://api.github.com/repos/octocat/Hello-World/releases/assets/1",
        "browser_download_url" => "https://github.com/octocat/Hello-World/releases/download/v1.0.0/example.zip",
        "id"                   => 1,
        "name"                 => "example.zip",
        "label"                => "short description",
        "state"                => "uploaded",
        "content_type"         => "application/zip",
        "size"                 => 1024,
        "download_count"       => 42,
        "created_at"           => "2013-02-27T19:35:32Z",
        "updated_at"           => "2013-02-27T19:35:32Z",
        "uploader"             => USER
      }

      RELEASE ||= {
        "url"              => "https://api.github.com/repos/octocat/Hello-World/releases/1",
        "html_url"         => "https://github.com/octocat/Hello-World/releases/v1.0.0",
        "assets_url"       => "https://api.github.com/repos/octocat/Hello-World/releases/1/assets",
        "upload_url"       => "https://uploads.github.com/repos/octocat/Hello-World/releases/1/assets{?name,label}",
        "tarball_url"      => "https://api.github.com/repos/octocat/Hello-World/tarball/v1.0.0",
        "zipball_url"      => "https://api.github.com/repos/octocat/Hello-World/zipball/v1.0.0",
        "id"               => 1,
        "tag_name"         => "v1.0.0",
        "target_commitish" => "master",
        "name"             => "v1.0.0",
        "body"             => "Description of the release",
        "draft"            => false,
        "prerelease"       => false,
        "created_at"       => "2013-02-27T19:35:32Z",
        "published_at"     => "2013-02-27T19:35:32Z",
        "author"           => USER,
        "assets"           => [RELEASE_ASSET]
      }

      CREATED_RELEASE ||= RELEASE.merge({
        "assets"         => []
      })

      DOWNLOAD ||= {
        "url"            => "https://api.github.com/repos/octocat/Hello-World/downloads/1",
        "html_url"       => "https://github.com/repos/octocat/Hello-World/downloads/new_file.jpg",
        "id"             => 1,
        "name"           => "new_file.jpg",
        "description"    => "Description of your download",
        "size"           => 1024,
        "download_count" => 40,
        "content_type"   => ".jpg"
      }

      CREATE_DOWNLOAD ||= DOWNLOAD.merge({
        "policy"         => "ewogICAg...",
        "signature"      => "mwnFDC...",
        "bucket"         => "github",
        "accesskeyid"    => "1ABCDEFG...",
        "path"           => "downloads/octocat/Hello-World/new_file.jpg",
        "acl"            => "public-read",
        "expirationdate" => "2011-04-14T16:00:49Z",
        "prefix"         => "downloads/octocat/Hello-World/",
        "mime_type"      => "image/jpeg",
        "redirect"       => false,
        "s3_url"         => "https://github.s3.amazonaws.com/"
      })
    end
  end
end
