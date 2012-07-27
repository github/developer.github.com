---
title: Repo Commits | GitHub API
---

# Repo Commits API

The Repo Commits API supports listing, viewing, and comparing commits in a repository.

## List commits on a repository

    GET /repos/:user/:repo/commits

_A special note on pagination:_ Due to the way Git works, commits are paginated
based on SHA instead of page number. Please follow the link headers as outlined
in the [pagination overview](http://developer.github.com/v3/#pagination)
instead of constructing page links yourself.

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
