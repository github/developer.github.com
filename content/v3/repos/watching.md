---
title: Repo Watching | GitHub API
---

# Repo Watching API

## List watchers

    GET /repos/:user/:repo/watchers

### Response

<%= headers 200, :pagination => true %>
<%= json(:user) { |h| [h] } %>

## List repos being watched

List repos being watched by a user

    GET /users/:user/watched

List repos being watched by the authenticated user

    GET /user/watched

### Response

<%= headers 200, :pagination => true %>
<%= json(:repo) { |h| [h] } %>

## Check if you are watching a repo

    GET /user/watched/:user/:repo

### Response if this repo is watched by you

<%= headers 204 %>

### Response if this repo is not watched by you

<%= headers 404 %>

## Watch a repo

    PUT /user/watched/:user/:repo

### Response

<%= headers 204 %>

## Stop watching a repo

    DELETE /user/watched/:user/:repo

### Response

<%= headers 204 %>
