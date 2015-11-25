---
title: Commits | GitHub API
---

# Commits

* TOC
{:toc}

The Repo Commits API supports listing, viewing, and comparing commits in a repository.

## List commits on a repository

    GET /repos/:owner/:repo/commits

### Parameters

Name | Type | Description
-----|------|--------------
`sha`|`string` | SHA or branch to start listing commits from. Default: the repository’s default branch (usually `master`).
`path`|`string` | Only commits containing this file path will be returned.
`author`|`string` | GitHub login or email address by which to filter by commit author.
`since`|`string` | Only commits after this date will be returned. This is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
`until`|`string` | Only commits before this date will be returned. This is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.


### Response

<%=
  headers 200, :pagination => { :next => 'https://api.github.com/resource?page=2' }
%>
<%= json(:commit) { |h| [h] } %>

## Get a single commit

    GET /repos/:owner/:repo/commits/:sha

### Response

Diffs with binary data will have no 'patch' property. Pass the
appropriate [media type](/v3/media/#commits-commit-comparison-and-pull-requests) to fetch diff and
patch formats.

<%= headers 200 %>
<%= json(:full_commit) %>

## Compare two commits

    GET /repos/:owner/:repo/compare/:base...:head

Both `:base` and `:head` must be branch names in `:repo`. To compare branches across other repositories in the same network as `:repo`, use the format `<USERNAME>:branch`. For example:

    GET /repos/:owner/:repo/compare/hubot:branchname...octocat:branchname

### Response

The response from the API is equivalent to running the `git log base..head` command; however, commits are returned in reverse chronological order.

Pass the appropriate [media type](/v3/media/#commits-commit-comparison-and-pull-requests) to fetch diff and patch formats.

<%= json :commit_comparison %>

### Working with large comparisons

The response will include a comparison of up to 250 commits. If you are working with a larger commit range, you can use the [Commit List API](/v3/repos/commits/#list-commits-on-a-repository) to enumerate all commits in the range.

For comparisons with extremely large diffs, you may receive an error response indicating that the diff took too long to generate. You can typically resolve this error by using a smaller commit range.
