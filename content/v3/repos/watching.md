---
title: Repository Watching | GitHub API
---

# Repository Watching API

Watching a Repository registers the user to receive notificactions on new
discussions, as well as events in the user's activity feed.  See [Repository
Starring](/v3/repos/starring) for simple repository bookmarks.

We recently [changed the way watching
works](https://github.com/blog/1204-notifications-stars) on GitHub.  Until 3rd
party applications stop using the "watcher" endpoints for the current Starring
API, the Watching API will use the below "subscription" endpoints.

## List watchers

    GET /repos/:user/:repo/subscribers

### Response

<%= headers 200, :pagination => true %>
<%= json(:user) { |h| [h] } %>

## List repositories being watched

List repositories being watched by a user.

    GET /users/:user/subscriptions

List repositories being watched by the authenticated user.

    GET /user/subscriptions

### Response

<%= headers 200, :pagination => true %>
<%= json(:repo) { |h| [h] } %>

## Check if you are watching a repository

Requires for the user to be authenticated.

    GET /user/subscriptions/:user/:repo

### Response if this repository is watched by you

<%= headers 204 %>

### Response if this repository is not watched by you

<%= headers 404 %>

## Watch a repository

Requires for the user to be authenticated.

    PUT /user/subscriptions/:user/:repo

### Response

<%= headers 204 %>

## Stop watching a repository

Requires for the user to be authenticated.

    DELETE /user/subscriptions/:user/:repo

### Response

<%= headers 204 %>
