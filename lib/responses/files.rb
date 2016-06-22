module GitHub
  module Resources
    module Responses
      FILE ||= {
        "sha"       => "bbcd538c8e72b8c175046e27cc8f907076331401",
        "filename"  => "file1.txt",
        "status"    => "added",
        "additions" => 103,
        "deletions" => 21,
        "changes"   => 124,
        "blob_url"  => "https://github.com/octocat/Hello-World/blob/6dcb09b5b57875f334f61aebed695e2e4193db5e/file1.txt",
        "raw_url"   => "https://github.com/octocat/Hello-World/raw/6dcb09b5b57875f334f61aebed695e2e4193db5e/file1.txt",
        "contents_url" => "https://api.github.com/repos/octocat/Hello-World/contents/file1.txt?ref=6dcb09b5b57875f334f61aebed695e2e4193db5e",
        "patch"     => "@@ -132,7 +132,7 @@ module Test @@ -1000,7 +1000,7 @@ module Test"
      }

      README_CONTENT ||= {
        "type" =>  "file",
        "encoding" =>  "base64",
        "size" =>  5362,
        "name" =>  "README.md",
        "path" =>  "README.md",
        "content" =>  "encoded content ...",
        "sha" =>  "3d21ec53a331a6f037a91c368710b99387d012c1",
        "url" => "https://api.github.com/repos/octokit/octokit.rb/contents/README.md",
        "git_url" => "https://api.github.com/repos/octokit/octokit.rb/git/blobs/3d21ec53a331a6f037a91c368710b99387d012c1",
        "html_url" => "https://github.com/octokit/octokit.rb/blob/master/README.md",
        "download_url"      => "https://raw.githubusercontent.com/octokit/octokit.rb/master/README.md",
        "_links" =>  {
          "git" =>  "https://api.github.com/repos/octokit/octokit.rb/git/blobs/3d21ec53a331a6f037a91c368710b99387d012c1",
          "self" =>  "https://api.github.com/repos/octokit/octokit.rb/contents/README.md",
          "html" =>  "https://github.com/octokit/octokit.rb/blob/master/README.md"
        },
      }

      SYMLINK_CONTENT ||= {
        "type" => "symlink",
        "target" => "/path/to/symlink/target",
        "size" => 23,
        "name" => "some-symlink",
        "path" => "bin/some-symlink",
        "sha" => "452a98979c88e093d682cab404a3ec82babebb48",
        "url" => "https://api.github.com/repos/octokit/octokit.rb/contents/bin/some-symlink",
        "git_url" => "https://api.github.com/repos/octokit/octokit.rb/git/blobs/452a98979c88e093d682cab404a3ec82babebb48",
        "html_url" => "https://github.com/octokit/octokit.rb/blob/master/bin/some-symlink",
        "download_url"      => "https://raw.githubusercontent.com/octokit/octokit.rb/master/bin/some-symlink",
        "_links" => {
          "git" => "https://api.github.com/repos/octokit/octokit.rb/git/blobs/452a98979c88e093d682cab404a3ec82babebb48",
          "self" => "https://api.github.com/repos/octokit/octokit.rb/contents/bin/some-symlink",
          "html" => "https://github.com/octokit/octokit.rb/blob/master/bin/some-symlink"
        },
      }

      SUBMODULE_CONTENT ||= {
        "type" => "submodule",
        "submodule_git_url" => "git://github.com/jquery/qunit.git",
        "size" => 0,
        "name" => "qunit",
        "path" => "test/qunit",
        "sha" => "6ca3721222109997540bd6d9ccd396902e0ad2f9",
        "url" => "https://api.github.com/repos/jquery/jquery/contents/test/qunit?ref=master",
        "git_url" => "https://api.github.com/repos/jquery/qunit/git/trees/6ca3721222109997540bd6d9ccd396902e0ad2f9",
        "html_url" => "https://github.com/jquery/qunit/tree/6ca3721222109997540bd6d9ccd396902e0ad2f9",
        "download_url"      => nil,
        "_links" => {
          "git" => "https://api.github.com/repos/jquery/qunit/git/trees/6ca3721222109997540bd6d9ccd396902e0ad2f9",
          "self" => "https://api.github.com/repos/jquery/jquery/contents/test/qunit?ref=master",
          "html" => "https://github.com/jquery/qunit/tree/6ca3721222109997540bd6d9ccd396902e0ad2f9"
        }
      }

      DIRECTORY_CONTENT ||= [
        {
          "type" => "file",
          "size" => 625,
          "name" => "octokit.rb",
          "path" => "lib/octokit.rb",
          "sha" => "fff6fe3a23bf1c8ea0692b4a883af99bee26fd3b",
          "url" => "https://api.github.com/repos/octokit/octokit.rb/contents/lib/octokit.rb",
          "git_url" => "https://api.github.com/repos/octokit/octokit.rb/git/blobs/fff6fe3a23bf1c8ea0692b4a883af99bee26fd3b",
          "html_url" => "https://github.com/octokit/octokit.rb/blob/master/lib/octokit.rb",
          "download_url"      => "https://raw.githubusercontent.com/octokit/octokit.rb/master/lib/octokit.rb",
          "_links" => {
            "self" => "https://api.github.com/repos/octokit/octokit.rb/contents/lib/octokit.rb",
            "git" => "https://api.github.com/repos/octokit/octokit.rb/git/blobs/fff6fe3a23bf1c8ea0692b4a883af99bee26fd3b",
            "html" => "https://github.com/octokit/octokit.rb/blob/master/lib/octokit.rb",
          },
        },
        {
          "type" => "dir",
          "size" => 0,
          "name" => "octokit",
          "path" => "lib/octokit",
          "sha" => "a84d88e7554fc1fa21bcbc4efae3c782a70d2b9d",
          "url" => "https://api.github.com/repos/octokit/octokit.rb/contents/lib/octokit",
          "git_url" => "https://api.github.com/repos/octokit/octokit.rb/git/trees/a84d88e7554fc1fa21bcbc4efae3c782a70d2b9d",
          "html_url" => "https://github.com/octokit/octokit.rb/tree/master/lib/octokit",
          "download_url"      => nil,
          "_links" => {
            "self" => "https://api.github.com/repos/octokit/octokit.rb/contents/lib/octokit",
            "git" => "https://api.github.com/repos/octokit/octokit.rb/git/trees/a84d88e7554fc1fa21bcbc4efae3c782a70d2b9d",
            "html" => "https://github.com/octokit/octokit.rb/tree/master/lib/octokit"
          },
        },
      ]

      BLOB ||= {
        :content => "Q29udGVudCBvZiB0aGUgYmxvYg==\n",
        :encoding => "base64",
        :url      => "https://api.github.com/repos/octocat/example/git/blobs/3a0f86fb8db8eea7ccbb9a95f325ddbedfb25e15",
        :sha => "3a0f86fb8db8eea7ccbb9a95f325ddbedfb25e15",
        :size => 19
      }

      BLOB_AFTER_CREATE ||= {
         'url'      => "https://api.github.com/repos/octocat/example/git/blobs/3a0f86fb8db8eea7ccbb9a95f325ddbedfb25e15",
         'sha' => "3a0f86fb8db8eea7ccbb9a95f325ddbedfb25e15"
      }

      CONTENT_CRUD ||= {
        "content" => {
          "name" => "hello.txt",
          "path" => "notes/hello.txt",
          "sha" => "95b966ae1c166bd92f8ae7d1c313e738c731dfc3",
          "size" => 9,
          "url" => "https://api.github.com/repos/octocat/Hello-World/contents/notes/hello.txt",
          "html_url" => "https://github.com/octocat/Hello-World/blob/master/notes/hello.txt",
          "git_url" => "https://api.github.com/repos/octocat/Hello-World/git/blobs/95b966ae1c166bd92f8ae7d1c313e738c731dfc3",
          "download_url"      => "https://raw.githubusercontent.com/octocat/HelloWorld/master/notes/hello.txt",
          "type" => "file",
          "_links" => {
            "self" => "https://api.github.com/repos/octocat/Hello-World/contents/notes/hello.txt",
            "git" => "https://api.github.com/repos/octocat/Hello-World/git/blobs/95b966ae1c166bd92f8ae7d1c313e738c731dfc3",
            "html" => "https://github.com/octocat/Hello-World/blob/master/notes/hello.txt"
          }
        },
        "commit" => {
          "sha" => "7638417db6d59f3c431d3e1f261cc637155684cd",
          "url" => "https://api.github.com/repos/octocat/Hello-World/git/commits/7638417db6d59f3c431d3e1f261cc637155684cd",
          "html_url" => "https://github.com/octocat/Hello-World/git/commit/7638417db6d59f3c431d3e1f261cc637155684cd",
          "author" => {
            "date" => "2014-11-07T22:01:45Z",
            "name" => "Scott Chacon",
            "email" => "schacon@gmail.com"
          },
          "committer" => {
            "date" => "2014-11-07T22:01:45Z",
            "name" => "Scott Chacon",
            "email" => "schacon@gmail.com"
          },
          "message" => "my commit message",
          "tree" => {
            "url" => "https://api.github.com/repos/octocat/Hello-World/git/trees/691272480426f78a0138979dd3ce63b77f706feb",
            "sha" => "691272480426f78a0138979dd3ce63b77f706feb"
          },
          "parents" => [
            {
              "url" => "https://api.github.com/repos/octocat/Hello-World/git/commits/1acc419d4d6a9ce985db7be48c6349a0475975b5",
              "html_url" => "https://github.com/octocat/Hello-World/git/commit/1acc419d4d6a9ce985db7be48c6349a0475975b5",
              "sha" => "1acc419d4d6a9ce985db7be48c6349a0475975b5"
            }
          ]
        }
      }
    end
  end
end
