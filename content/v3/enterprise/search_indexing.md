---
title: Search Indexing
---

# Search Indexing

{:toc}

The Search Indexing API allows you to queue up a variety of search indexing tasks. *It is only available to [authenticated](/v3/#authentication) site administrators.* Normal users will receive a `404` response if they try to access it.

Prefix all the endpoints for this API with the following URL:

``` command-line
http(s)://<em>hostname</em>/api/v3
```

## Queue an indexing job

    POST /staff/indexing_jobs

### Input

Name    | Type    | Description
--------|---------|--------------
`target`|`string` | **Required**. A string representing the item to index.

You can index the following targets (replace `:owner` with the name of a user or organization account and `:repository` with the name of a repository):

Target                      | Description
----------------------------|---------------------------------------------------------------------
`:owner`                    | A user or organization account.
`:owner/:repository`        | A repository.
`:owner/*`                  | All of a user or organization's repositories.
`:owner/:repository/issues` | All the issues in a repository.
`:owner/*/issues`           | All the issues in all of a user or organization's repositories.
`:owner/:repository/code`   | All the source code in a repository.
`:owner/*/code`             | All the source code in all of a user or organization's repositories.

### Example

``` command-line
$ curl -u jwatson -X POST -H "Content-Type: application/json" -d '{"target": "kansaichris/japaning"}' "http://<em>hostname</em>/api/v3/staff/indexing_jobs"
```

### Response

<%= headers 202 %>
<%= json(:indexing_success)  %>
