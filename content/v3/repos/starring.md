---
title: Repository Starring | GitHub API
---

# Repository Starring API

Repository Starring is a feature that lets users bookmark repositories.  Stars
are shown next to repositories to show an approximate level of interest.  Stars
have no effect on notifications or the activity feed.  For that, see [Repository
Watching](/v3/repos/watching).

We recently [changed the way watching
works](https://github.com/blog/1204-notifications-stars) on GitHub.  Many 3rd
party applications may be using the "watcher" endpoints for accessing these.
Starting today, you can start changing these to the new "star" endpoints.  See
below.

## List Stargazers

    # Using github.v3 media type.
    GET /repos/:user/:repo/stargazers

    # Legacy, using github.beta media type..
    GET /repos/:user/:repo/watchers

### Response

<%= headers 200, :pagination => true %>
<%= json(:user) { |h| [h] } %>

## List repositories being starred

List repositories being starred by a user.

    # Using github.v3 media type.
    GET /users/:user/starred

    # Legacy, using github.beta media type.
    GET /users/:user/watched

List repositories being watched by the authenticated user.

    # Using github.v3 media type.
    GET /user/starred

    # Legacy, using github.beta media type.
    GET /user/watched

### Response

<%= headers 200, :pagination => true %>
<%= json(:repo) { |h| [h] } %>

## Check if you are starring a repository

Requires for the user to be authenticated.

    # Using github.v3 media type.
    GET /user/starred/:user/:repo

    # Legacy, using github.beta media type.
    GET /user/watched/:user/:repo

### Response if this repository is watched by you

<%= headers 204 %>

### Response if this repository is not watched by you

<%= headers 404 %>

## Star a repository

Requires for the user to be authenticated.

    # Using github.v3 media type.
    PUT /user/starred/:user/:repo

    # Legacy, using github.beta media type.
    PUT /user/watched/:user/:repo

### Response

<%= headers 204 %>

## Unstar a repository

Requires for the user to be authenticated.

    # Using github.v3 media type.
    DELETE /user/starred/:user/:repo

    # Legacy, using github.beta media type.
    DELETE /user/watched/:user/:repo

### Response

<%= headers 204 %>
