---
title: Repository Watching | GitHub API
---

# Repository Watching API

* TOC
{:toc}

Watching a Repository registers the user to receive notifications on new
discussions, as well as events in the user's activity feed.  See [Repository
Starring](/v3/activity/starring) for simple repository bookmarks.

We recently [changed the way watching
works](https://github.com/blog/1204-notifications-stars) on GitHub.  Until 3rd
party applications stop using the "watcher" endpoints for the current Starring
API, the Watching API will use the below "subscription" endpoints.  Check the
[Watcher API Change post](/changes/2012-9-5-watcher-api/) for more.

## List watchers

    GET /repos/:owner/:repo/subscribers

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

## Get a Repository Subscription

    GET /repos/:owner/:repo/subscription

### Response

<%= headers 200 %>
<%= json :repo_subscription %>

## Set a Repository Subscription

    PUT /repos/:owner/:repo/subscription

### Input

subscribed
: **boolean** Determines if notifications should be received from this
repository.

ignored
: **boolean** Determines if all notifications should be blocked from this
repository.

### Response

<%= headers 200 %>
<%= json :repo_subscription %>

## Delete a Repository Subscription

    DELETE /repos/:owner/:repo/subscription

### Response

<%= headers 204 %>

## Check if you are watching a repository (LEGACY)

Requires for the user to be authenticated.

    GET /user/subscriptions/:owner/:repo

### Response if this repository is watched by you

<%= headers 204 %>

### Response if this repository is not watched by you

<%= headers 404 %>

## Watch a repository (LEGACY)

Requires for the user to be authenticated.

    PUT /user/subscriptions/:owner/:repo

### Response

<%= headers 204 %>

## Stop watching a repository (LEGACY)

Requires for the user to be authenticated.

    DELETE /user/subscriptions/:owner/:repo

### Response

<%= headers 204 %>
