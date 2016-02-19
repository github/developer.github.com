---
title: Source Imports | GitHub API
---

# Source Imports

{:toc}

{% if page.version != 'dotcom' %}

{{#warning}}

This API is not currently available on GitHub Enterprise.

{{/warning}}

{% endif %}

{{#tip}}

  The source import APIs are currently in public preview. During this period, the APIs may change in a backwards-incompatible way.  To access the API during the preview period, you must provide a custom [media type](/v3/media) in the `Accept` header:

      application/vnd.github.barred-rock-preview

{{/tip}}

The Source Import API lets you start an import from a Git, Subversion, Mercurial, or Team Foundation Server source repository. This is the same functionality as [the GitHub Importer](https://import.github.com/).

A typical source import would [start the import](#start-an-import) and then (optionally) [update the authors](#map-a-commit-author). A more detailed example can be seen in this diagram:

```
+---------+                     +--------+                              +---------------------+
| Tooling |                     | GitHub |                              | Original Repository |
+---------+                     +--------+                              +---------------------+
     |                              |                                              |
     |  Start import                |                                              |
     |----------------------------->|                                              |
     |                              |                                              |
     |                              |  Download source data                        |
     |                              |--------------------------------------------->|
     |                              |                        Begin streaming data  |
     |                              |<---------------------------------------------|
     |                              |                                              |
     |  Get import progress         |                                              |
     |----------------------------->|                                              |
     |       "status": "importing"  |                                              |
     |<-----------------------------|                                              |
     |                              |                                              |
     |  Get commit authors          |                                              |
     |----------------------------->|                                              |
     |                              |                                              |
     |  Map a commit author         |                                              |
     |----------------------------->|                                              |
     |                              |                                              |
     |                              |                                              |
     |                              |                       Finish streaming data  |
     |                              |<---------------------------------------------|
     |                              |                                              |
     |                              |  Rewrite commits with mapped authors         |
     |                              |------+                                       |
     |                              |      |                                       |
     |                              |<-----+                                       |
     |                              |                                              |
     |                              |  Update repository on GitHub                 |
     |                              |------+                                       |
     |                              |      |                                       |
     |                              |<-----+                                       |
     |                              |                                              |
     |  Map a commit author         |                                              |
     |----------------------------->|                                              |
     |                              |  Rewrite commits with mapped authors         |
     |                              |------+                                       |
     |                              |      |                                       |
     |                              |<-----+                                       |
     |                              |                                              |
     |                              |  Update repository on GitHub                 |
     |                              |------+                                       |
     |                              |      |                                       |
     |                              |<-----+                                       |
     |                              |                                              |
     |  Get import progress         |                                              |
     |----------------------------->|                                              |
     |        "status": "complete"  |                                              |
     |<-----------------------------|                                              |
     |                              |                                              |
     |                              |                                              |
```

## Start an import

Start a source import to a GitHub repository using GitHub Importer.

    PUT /repos/:owner/:repo/import

### Parameters

Name | Type | Description
-----|------|--------------
`vcs`|`string`|**Required** The originating VCS type. Can be one of "subversion", "git", "mercurial", or "tfvc".
`vcs_url`|`url`|**Required** The URL of the originating repository.
`vcs_username`|`string`|If authentication is required, the username to provide to `vcs_url`.
`vcs_password`|`string`|If authentication is required, the password to provide to `vcs_url`.
`tfvc_project`|`string`|For a tfvc import, the name of the project that is being imported.

#### Example

<%= json \
  :vcs          => "subversion",
  :vcs_url      => "http://svn.mycompany.com/svn/myproject",
  :vcs_username => "octocat",
  :vcs_password => "secret"
%>

### Response

<%= headers 201, :Location => "https://api.github.com/repos/spraints/socm/import" %>
<%= json :source_import %>

## Get import progress

View the progress of an import.

    GET /repos/:owner/:repo/import
    
### Response

<%= headers 200 %>
<%= json :source_import_complete %>

### Import `status`

This section includes details about the possible values of the `status` field of the Import Progress response.

An import that does not have errors will progress through these steps:

* `importing` - the "raw" step of the import is in progress. This is where commit data is fetched from the original repository. The import progress response will include `commit_count` (the total number of raw commits that will be imported) and `percent` (0 - 100, the current progress through the import).
* `mapping` - the "rewrite" step of the import is in progress. This is where SVN branches are converted to Git branches, and where author updates are applied. The import progress response does not include progress information.
* `pushing` - the "push" step of the import is in progress. This is where the importer updates the repository on GitHub. The import progress response will include `push_percent`, which is the percent value reported by `git push` when it is "Writing objects".
* `complete` - the import is complete, and the repository is ready on GitHub.

If there are problems, you will see one of these in the `status` field:

* `auth_failed` - the import requires authentication in order to connect to the original repository. Make another "Start Import" request, and include `vcs_username` and `vcs_password`.
* `error` - the import encountered an error. The import progress response will include the `failed_step` and an error message. [Contact support](https://github.com/contact?form%5Bsubject%5D=Source+Import+API+error) for more information.

If you query import status for an import started via the web UI, you may also see these states:

* `detecting` - you've entered a URL via the web UI, and the importer is figuring out what type of source control is present at the URL.
* `detection_needs_auth` - you've entered a URL via the web UI, and the importer needs you to enter authentication credentials in the web UI in order to continue detection.
* `detection_found_nothing` - the importer didn't recognize any source control at the URL entered via the web UI.
* `detection_found_multiple` - the importer found several projects or repositories at the provided URL.
* `waiting_to_push` - the raw and rewrite steps are complete, but a destination GitHub repository hasn't been created yet.

## Get commit authors

Each type of source control system represents authors in a different way. For example, a Git commit author has a display name and an email address, but a Subversion commit author just has a username. The GitHub Importer will make the author information valid, but the author might not be correct. For example, it will change the bare Subversion username `hubot` into something like `hubot <hubot@12341234-abab-fefe-8787-fedcba987654>`.

This API method and the "Map a commit author" method allow you to provide correct Git author information.

    GET /repos/:owner/:repo/import/authors
    
### Parameters

Name | Type | Description
-----|------|------------
`since`|`string`|Only authors found after this id are returned. Provide the highest author ID you've seen so far. New authors may be added to the list at any point while the importer is performing the `raw` step.

### Response

<%= headers 200 %>
<%= json :source_import_authors %>

## Map a commit author

Update an author's identity for the import. Your application can continue updating authors any time before you push new commits to the repository.

    PATCH /repos/:owner/:repo/import/authors/:author_id
    
### Parameters

Name | Type | Description
-----|------|--------------
`email`|`string`|The new Git author email.
`name`|`string`|The new Git author name.

### Example

<%= json \
  :email => "hubot@github.com",
  :name => "Hubot the Robot"
%>

### Response

<%= headers 200 %>
<%= json :source_import_author %>

## Cancel an import

Stop an import for a repository.

    DELETE /repos/:owner/:repo/import

### Response

<%= headers 204 %>
