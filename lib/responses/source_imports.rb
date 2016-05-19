
module GitHub
  module Resources
    module Responses
      SOURCE_IMPORT ||= {
        "vcs" => "subversion",
        "use_lfs" => "undecided",
        "vcs_url" => "http://svn.mycompany.com/svn/myproject",
        "status" => "importing",
        "status_text" => "Importing...",
        "has_large_files" => false,
        "large_files_size" => 0,
        "large_files_count" => 0,
        "authors_count" => 0,
        "percent" => 42,
        "commit_count" => 1042,
        "url" => "https://api.github.com/repos/octocat/socm/import",
        "html_url" => "https://import.github.com/octocat/socm/import",
        "authors_url" => "https://api.github.com/repos/octocat/socm/import/authors",
        "repository_url" => "https://api.github.com/repos/octocat/socm"
      }

      SOURCE_IMPORT_COMPLETE ||= {
        "vcs" => "subversion",
        "use_lfs" => "opt_in",
        "vcs_url" => "http://svn.mycompany.com/svn/myproject",
        "status" => "complete",
        "status_text" => "Done",
        "has_large_files" => true,
        "large_files_size" => 132331036,
        "large_files_count" => 1,
        "authors_count" => 4,
        "url" => "https://api.github.com/repos/octocat/socm/import",
        "html_url" => "https://import.github.com/octocat/socm/import",
        "authors_url" => "https://api.github.com/repos/octocat/socm/import/authors",
        "repository_url" => "https://api.github.com/repos/octocat/socm"
      }

      SOURCE_IMPORT_UPDATE_AUTH ||= {
        "vcs": "subversion",
        "use_lfs": "undecided",
        "vcs_url": "http://svn.mycompany.com/svn/myproject",
        "status": "detecting",
        "url" => "https://api.github.com/repos/octocat/socm/import",
        "html_url" => "https://import.github.com/octocat/socm/import",
        "authors_url" => "https://api.github.com/repos/octocat/socm/import/authors",
        "repository_url" => "https://api.github.com/repos/octocat/socm"
      }

      SOURCE_IMPORT_UPDATE_PROJECT_CHOICE ||= {
        "vcs" => "tfvc",
        "use_lfs": "undecided",
        "vcs_url" => "http://tfs.mycompany.com/tfs/myproject",
        "tfvc_project": "project1",
        "status" => "importing",
        "status_text" => "Importing...",
        "has_large_files" => false,
        "large_files_size" => 0,
        "large_files_count" => 0,
        "authors_count" => 0,
        "percent" => 42,
        "commit_count" => 1042,
        "url" => "https://api.github.com/repos/octocat/socm/import",
        "html_url" => "https://import.github.com/octocat/socm/import",
        "authors_url" => "https://api.github.com/repos/octocat/socm/import/authors",
        "repository_url" => "https://api.github.com/repos/octocat/socm"
      }

      SOURCE_IMPORT_PROJECT_CHOICES ||= [
        {
          "vcs": "tfvc",
          "tfvc_project": "project0",
          "human_name": "project0 (tfs)"
        },
        {
          "vcs": "tfvc",
          "tfvc_project": "project1",
          "human_name": "project1 (tfs)"
        },
        {
          "vcs": "tfvc",
          "tfvc_project": "project2",
          "human_name": "project2 (tfs)"
        },
        {
          "vcs": "tfvc",
          "tfvc_project": "project3",
          "human_name": "project3 (tfs)"
        }
      ]

      SOURCE_IMPORT_AUTHOR ||= {
        "id" => 2268557,
        "remote_id" => "nobody@fc7da526-431c-80fe-3c8c-c148ff18d7ef",
        "remote_name" => "nobody",
        "email" => "hubot@github.com",
        "name" => "Hubot",
        "url" => "https://api.github.com/repos/octocat/socm/import/authors/2268557",
        "import_url" => "https://api.github.com/repos/octocat/socm/import"
      }

      SOURCE_IMPORT_AUTHORS ||= [
        SOURCE_IMPORT_AUTHOR,
        {
          "id" => 2268558,
          "remote_id" => "svner@fc7da526-431c-80fe-3c8c-c148ff18d7ef",
          "remote_name" => "svner",
          "email" => "svner@fc7da526-431c-80fe-3c8c-c148ff18d7ef",
          "name" => "svner",
          "url" => "https://api.github.com/repos/octocat/socm/import/authors/2268558",
          "import_url" => "https://api.github.com/repos/octocat/socm/import"
        },
        {
          "id" => 2268559,
          "remote_id" => "svner@example.com@fc7da526-431c-80fe-3c8c-c148ff18d7ef",
          "remote_name" => "svner@example.com",
          "email" => "svner@example.com@fc7da526-431c-80fe-3c8c-c148ff18d7ef",
          "name" => "svner@example.com",
          "url" => "https://api.github.com/repos/octocat/socm/import/authors/2268559",
          "import_url" => "https://api.github.com/repos/octocat/socm/import"
        }
      ]

      SOURCE_IMPORT_LARGE_FILES ||= [
        {
          "ref_name": "refs/heads/master",
          "path": "foo/bar/1",
          "oid": "d3d9446802a44259755d38e6d163e820",
          "size": 10485760
        },
        {
          "ref_name": "refs/heads/master",
          "path": "foo/bar/2",
          "oid": "6512bd43d9caa6e02c990b0a82652dca",
          "size": 11534336
        },
        {
          "ref_name": "refs/heads/master",
          "path": "foo/bar/3",
          "oid": "c20ad4d76fe97759aa27a0c99bff6710",
          "size": 12582912
        }
      ]
    end
  end
end
