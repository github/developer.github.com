---
title: Repo Commits | GitHub API
---

# Repo Commits API

## List commits on a repository

    GET /repos/:user/:repo/commits

### Parameters

sha
: _Optional_ **string** - Sha or branch to start listing commits from.

path
: _Optional_ **string** - Only commits containing this file path
will be returned.

### Response

<%= headers 200 %>
<%= json(:commit) { |h| [h] } %>

## Get a single commit

    GET /repos/:user/:repo/commits/:sha

### Response

<%= headers 200 %>
<%= json(:full_commit) %>

Note: Diffs with binary data will have no 'patch' property.

## Compare two commits

    GET /repos/:user/:repo/compare/:base...:head

### Response

<%= json :commit_comparison %>
