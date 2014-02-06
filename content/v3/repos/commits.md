---
title: Commits | GitHub API
---

# Commits

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

Name | Type | Description 
-----|------|--------------
`sha`|`string` | SHA or branch to start listing commits from.
`path`|`string` | Only commits containing this file path will be returned.
`author`|`string` | GitHub login, name, or email by which to filter by commit author
`since`|`string` | Only commits after this date will be returned. This is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.
`until`|`string` | Only commits before this date will be returned. This is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.


### Response

<%=
  headers 200, :pagination => {
    :next => 'https://api.github.com/repositories/417862/commits?top=master&last_sha=4f9890864feb48296917c2fcf3682d8dc3adf16a'
  }
%>
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
    
## Compare two forks of a repository

It's possible to compare branch positions between forks
    
    GET /repos/:fork_owner/:repo/compare/:owner:base...:head

### Response

<%= json :commit_comparison %>

Pass the appropriate [media type](/v3/media/#commits-commit-comparison-and-pull-requests) to fetch diff and patch formats.

### Working with large comparisons

The response will include a comparison of up to 250 commits. If you are working with a larger commit range, you can use the [Commit List API](/v3/repos/commits/#list-commits-on-a-repository) to enumerate all commits in the range.

For comparisons with extremely large diffs, you may receive an error response indicating that the diff took too long to generate. You can typically resolve this error by using a smaller commit range.
