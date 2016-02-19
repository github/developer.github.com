
module GitHub
  module Resources
    module Responses
      SOURCE_IMPORT ||= {
        "vcs" => "subversion",
        "vcs_url" => "http://svn.mycompany.com/svn/myproject",
        "status" => "importing",
        "status_text" => "Importing...",
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
        "vcs_url" => "http://svn.mycompany.com/svn/myproject",
        "status" => "complete",
        "status_text" => "Done",
        "authors_count" => 4,
        "url" => "https://api.github.com/repos/octocat/socm/import",
        "html_url" => "https://import.github.com/octocat/socm/import",
        "authors_url" => "https://api.github.com/repos/octocat/socm/import/authors",
        "repository_url" => "https://api.github.com/repos/octocat/socm"
      }

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
    end
  end
end
