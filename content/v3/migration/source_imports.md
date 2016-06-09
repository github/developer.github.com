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

The Source Import API lets you start an import from a Git, Subversion, Mercurial, or Team Foundation Server source repository. This is the same functionality as [the GitHub Importer](https://help.github.com/articles/importing-from-other-version-control-systems-to-github/).

A typical source import would [start the import](#start-an-import) and then (optionally) [update the authors](#map-a-commit-author) and/or [set the preference](#set-git-lfs-preference) for using Git LFS if large files exist in the import. A more detailed example can be seen in this diagram:

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
     |  Get large files             |                                              |
     |----------------------------->|                                              |
     |                              |                                              |
     |  opt_in to Git LFS           |                                              |
     |----------------------------->|                                              |
     |                              |  Rewrite commits for large files             |
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
`vcs_url`|`url`|**Required** The URL of the originating repository.
`vcs`|`string`|The originating VCS type. Can be one of `subversion`, `git`, `mercurial`, or `tfvc`. Please be aware that without this parameter, the import job will take additional time to detect the VCS type before beginning the import. This detection step will be reflected in the response.
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

* `detecting` - the "detection" step of the import is in progress because the request did not include a `vcs` parameter. The import is identifying the type of source control present at the URL.
* `importing` - the "raw" step of the import is in progress. This is where commit data is fetched from the original repository. The import progress response will include `commit_count` (the total number of raw commits that will be imported) and `percent` (0 - 100, the current progress through the import).
* `mapping` - the "rewrite" step of the import is in progress. This is where SVN branches are converted to Git branches, and where author updates are applied. The import progress response does not include progress information.
* `pushing` - the "push" step of the import is in progress. This is where the importer updates the repository on GitHub. The import progress response will include `push_percent`, which is the percent value reported by `git push` when it is "Writing objects".
* `complete` - the import is complete, and the repository is ready on GitHub.

If there are problems, you will see one of these in the `status` field:

* `auth_failed` - the import requires authentication in order to connect to the original repository. To update authentication for the import, please see the [Update Existing Import](#update-existing-import) section.
* `error` - the import encountered an error. The import progress response will include the `failed_step` and an error message. [Contact support](https://github.com/contact?form%5Bsubject%5D=Source+Import+API+error) for more information.
* `detection_needs_auth` - the importer requires authentication for the originating repository to continue detection. To update authentication for the import, please see the [Update Existing Import](#update-existing-import) section.
* `detection_found_nothing` - the importer didn't recognize any source control at the URL. To resolve, [Cancel the import](#cancel-an-import) and [retry](#start-an-import) with the correct URL.
* `detection_found_multiple` - the importer found several projects or repositories at the provided URL. When this is the case, the Import Progress response will also include a `project_choices` field with the possible project choices as values. To update project choice, please see the [Update Existing Import](#update-existing-import) section.

### The `project_choices` field

When multiple projects are found at the provided URL, the response hash will include a `project_choices` field, the value of which is an array of hashes each representing a project choice. The exact key/value pairs of the project hashes will differ depending on the version control type.

<%= json :source_import_project_choices %>

### Git LFS related fields

This section includes details about Git LFS related fields that may be present in the Import Progress response.

* `use_lfs` - describes whether the import has been opted in or out of using Git LFS. The value can be `opt_in`, `opt_out`, or `undecided` if no action has been taken.
* `has_large_files` - the boolean value describing whether files larger than 100MB were found during the `importing` step.
* `large_files_size` - the total size in gigabytes of files larger than 100MB found in the originating repository.
* `large_files_count` - the total number of files larger than 100MB found in the originating repository. To see a list of these files, make a "Get Large Files" request.

## Update existing import

An import can be updated with credentials or a project choice by passing in the appropriate parameters in this API request. If no parameters are provided, the import will be restarted.

    PATCH /repos/:owner/:repo/import

### Parameters for updating authentication

Name | Type | Description
-----|------|--------------
`vcs_username`|`string`|The username to provide to the originating repository.
`vcs_password`|`string`|The password to provide to the originating repository.

### Example

<%= json \
  :vcs_username => "octocat",
  :vcs_password => "secret"
%>

### Response

<%= headers 200 %>
<%= json :source_import_update_auth %>

### Parameters for updating project choice

Some servers (e.g. TFS servers) can have several projects at a single URL. In those cases the import progress will have the status `detection_found_multiple` and the Import Progress response will include a `project_choices` array. You can select the project to import by providing one of the objects in the `project_choices` array in the update request.

The following example demonstrates the workflow for updating an import with "project1" as the project choice. Given a `project_choices` array like such:

<%= json :source_import_project_choices %>

### Example

<%= json\
  "vcs": "tfvc",
  "tfvc_project": "project1",
  "human_name": "project1 (tfs)"
%>

### Response

<%= headers 200 %>
<%= json :source_import_update_project_choice %>

### Parameters for restarting import

To restart an import, no parameters are provided in the update request.

### Response

<%= headers 200, :Location => "https://api.github.com/repos/spraints/socm/import" %>
<%= json :source_import %>

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

## Set Git LFS preference

You can import repositories from Subversion, Mercurial, and TFS that include files larger than 100MB. This ability is powered by [Git LFS](https://git-lfs.github.com). You can learn more about our LFS feature and working with large files [on our help site](https://help.github.com/articles/versioning-large-files/).

    PATCH /:owner/:name/import/lfs

### Parameters

Name | Type | Description
-----|------|--------------
`use_lfs`|`string`|**Required** Can be one of `opt_in` (large files will be stored using Git LFS) or `opt_out` (large files will be removed during the import).

### Example

<%= json \
  :use_lfs => "opt_in"
%>

### Response

<%= headers 200 %>
<%= json :source_import_complete %>

## Get large files

List files larger than 100MB found during the import

    GET /:owner/:name/import/large_files

### Response

<%= headers 200 %>
<%= json :source_import_large_files %>

## Cancel an import

Stop an import for a repository.

    DELETE /repos/:owner/:repo/import

### Response

<%= headers 204 %>
