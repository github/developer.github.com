---
title: Repo Forks | GitHub API
---

# Repo Forks API

## List forks

    GET /repos/:user/:repo/forks

### Response

<%= headers 200 %>
<%= json(:repo) { |h| [h] } %>

## Create a fork

Create a fork for the authenticated user.

    POST /repos/:user/:repo/forks

### Parameters

org
: _Optional_ **String** - Organization login. The repository will be
forked into this organization.

### Response

<%= headers 201 %>
<%= json :repo %>
