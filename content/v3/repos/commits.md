---
title: Repo Commits | GitHub API
---

# Repo Commits API

* TOC
{:toc}

The Repo Commits API supports listing, viewing, and comparing commits in a repository.

## List commits on a repository

    GET /repos/:owner/:repo/commits

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

author
: _Optional_ **string** - GitHub login, name, or email by which to filter by
commit author

since
: _Optional_ **ISO 8601 Date** - Only commits after this date will be returned

until
: _Optional_ **ISO 8601 Date** - Only commits before this date will be returned

### Response

<%= headers 200 %>
<%= json(:commit) { |h| [h] } %>

## Get a single commit

    GET /repos/:owner/:repo/commits/:sha

### Response

<%= headers 200 %>
<%= json(:full_commit) %>

Note: Diffs with binary data will have no 'patch' property. Pass the
appropriate [media type](/v3/media/#commits-commit-comparison-and-pull-requests) to fetch diff and
patch formats.

## Compare two commits

    GET /repos/:owner/:repo/compare/:base...:head

### Response

<%= json :commit_comparison %>

Pass the appropriate [media type](/v3/media/#commits-commit-comparison-and-pull-requests) to fetch diff and patch formats.
