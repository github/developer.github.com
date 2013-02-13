---
title: Repository Starring | GitHub API
---

# Repository Starring API

* TOC
{:toc}

Repository Starring is a feature that lets users bookmark repositories.  Stars
are shown next to repositories to show an approximate level of interest.  Stars
have no effect on notifications or the activity feed.  For that, see [Repository
Watching](/v3/activity/watching).

We recently [changed the way watching
works](https://github.com/blog/1204-notifications-stars) on GitHub.  Many 3rd
party applications may be using the "watcher" endpoints for accessing these.
Starting today, you can start changing these to the new "star" endpoints.  See
below.  Check the [Watcher API Change post](/changes/2012-9-5-watcher-api/) for
more.


## List Stargazers

    GET /repos/:owner/:repo/stargazers

    # Legacy, using github.beta media type.
    GET /repos/:owner/:repo/watchers

### Response

<%= headers 200, :pagination => true %>
<%= json(:user) { |h| [h] } %>

## List repositories being starred

List repositories being starred by a user.

    GET /users/:user/starred

    # Legacy, using github.beta media type.
    GET /users/:user/watched

List repositories being watched by the authenticated user.

    GET /user/starred

    # Legacy, using github.beta media type.
    GET /user/watched

### Parameters

sort
: _Optional_ **String** One of `created` (when the repository was starred) or
`updated` (when it was last pushed to). Default: `created`.

direction
: _Optional_ **String** One of `asc` or `desc`. Default: `desc`.


### Response

<%= headers 200, :pagination => true %>
<%= json(:repo) { |h| [h] } %>

## Check if you are starring a repository

Requires for the user to be authenticated.

    GET /user/starred/:owner/:repo

    # Legacy, using github.beta media type.
    GET /user/watched/:owner/:repo

### Response if this repository is watched by you

<%= headers 204 %>

### Response if this repository is not watched by you

<%= headers 404 %>

## Star a repository

Requires for the user to be authenticated.

    PUT /user/starred/:owner/:repo

    # Legacy, using github.beta media type.
    PUT /user/watched/:owner/:repo

### Response

<%= headers 204 %>

## Unstar a repository

Requires for the user to be authenticated.

    DELETE /user/starred/:owner/:repo

    # Legacy, using github.beta media type.
    DELETE /user/watched/:owner/:repo

### Response

<%= headers 204 %>
