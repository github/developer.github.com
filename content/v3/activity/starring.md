---
title: Starring | GitHub API
---

# Starring

* TOC
{:toc}

Repository Starring is a feature that lets users bookmark repositories.  Stars
are shown next to repositories to show an approximate level of interest.  Stars
have no effect on notifications or the activity feed.  For that, see [Repository
Watching](/v3/activity/watching).

### Starring vs. Watching

In August 2012, we [changed the way watching
works](https://github.com/blog/1204-notifications-stars) on GitHub.  Many API
client applications may be using the original "watcher" endpoints for accessing
this data. You can now start using the "star" endpoints instead (described
below). Check out the [Watcher API Change post](/changes/2012-9-5-watcher-api/)
for more details.

## List Stargazers

    GET /repos/:owner/:repo/stargazers

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:user) { |h| [h] } %>

## List repositories being starred

List repositories being starred by a user.

    GET /users/:username/starred

List repositories being starred by the authenticated user.

    GET /user/starred

### Parameters

Name | Type | Description
-----|------|--------------
`sort`|`string` | One of `created` (when the repository was starred) or `updated` (when it was last pushed to). Default: `created`
`direction`|`string` | One of `asc` (ascending) or `desc` (descending). Default: `desc`


### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:repo) { |h| [h] } %>

## Check if you are starring a repository

Requires for the user to be authenticated.

    GET /user/starred/:owner/:repo

### Response if this repository is starred by you

<%= headers 204 %>

### Response if this repository is not starred by you

<%= headers 404 %>

## Star a repository

Requires for the user to be authenticated.

    PUT /user/starred/:owner/:repo

### Response

<%= headers 204 %>

## Unstar a repository

Requires for the user to be authenticated.

    DELETE /user/starred/:owner/:repo

### Response

<%= headers 204 %>
