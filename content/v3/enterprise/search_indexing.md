---
title: Search Indexing | GitHub API
---

# Search Indexing

* TOC
{:toc}

The Search Indexing API allows you to queue up a variety of search indexing tasks. *It is only available to site admins.* Normal users will receive a `404` response if they try to access it.

## Queue an indexing job

    POST /api/v3/staff/indexing_jobs

### Parameters

Name    | Type    | Description
--------|---------|--------------
`target`|`string` | **Required**. A string representing the item to index.

You can index the following targets (replace `:account` with the name of a user or organization account and `:repository` with the name of a repository):

Target                     | Description
---------------------------|-------
`:account`                    | A user or organization account
`:account/:repository`        | A repository
`:account/*`                  | All of a user or organization's repositories
`:account/:repository/issues` | All the issues in a repository
`:account/*/issues`           | All the issues in all of a user or organization's repositories
`:account/:repository/code`   | All the source code in a repository
`:account/*/code`             | All the source code in all of a user or organization's repositories

### Response

<%= headers 202 %>
<%= json(:indexing_success)  %>

### Example

<pre class="terminal">
$ curl -u jwatson -X POST "http://<em>hostname</em>/api/v3/staff/indexing_jobs?target=jwatson%2Flaughing-robot"
{
  "message": "Repository \"jwatson/laughing-robot\" has been added to the indexing queue"
}
</pre>
