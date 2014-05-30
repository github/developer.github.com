---
title: Search indexing | GitHub API
---

# Search indexing

* TOC
{:toc}

You can queue up a variety of search indexing tasks using these API endpoints.

Note: only admin users can access Enterprise API endpoints. Normal users will receive a `404` response if they try to access it.

## Request an indexing job to be queued

    POST /api/v3/staff/indexing_jobs


### Parameters

Name | Type | Description
-----|------|--------------
`target`|`string` | **Required**. A string representing the item to index.

The job is expressed as a "target" consisting of a user, repository, and a job. The fields given will determine the type of indexing job performed.

For example, if the target is `:user/:repository`, then the repository is indexed. If the target is just `:user`, then only the user is indexed.

The following targets are available:

    :user                    - index the "user"
    :user/:repository        - index the repository
    :user/:repository/issues - index the issues for the repository
    :user/:repository/code   - index the source code for the repository

You can also use a wildcard (*) in the `repository` field. If you do this, then the indexing action is performed for all repositories belonging to the user. For example:

    :user/*        - indexes all of the user's repositories
    :user/*/issues - indexes all the issues for all of the user's repositories
    :user/*/code   - indexes the source code for all of the user's repositories

You can also replace the user field with an organization to queue up reindex jobs for repositories belonging to that organization.

### Response

<%= headers 202 %>
<%= json(:indexing_success)  %>


### Example

<pre class="terminal">
$ curl -u jwatson -X POST "http://[hostname]/api/v3/staff/indexing_jobs?target=jwatson%2Flaughing-robot"
{
  "message": "Repository \"jwatson/laughing-robot\" has been added to the indexing queue"
}
</pre>
