---
title: Pull Requests | GitHub API
---

# Pull Request API

* TOC
{:toc}

The Pull Request API allows you to list, view, edit, create, and even merge
pull requests. Comments on pull requests can be managed via the [Issue
Comments API](/v3/issues/comments/).

Pull Requests use [these custom media types](#custom-media-types). You
can read more about the use of media types in the API
[here](/v3/media/).

## Link Relations

Pull Requests have these possible link relations:

`self`
: The API location of this Pull Request.

`html`
: The HTML location of this Pull Request.

`comments`
: The API location of this Pull Request's Issue comments.

`review_comments`
: The API location of this Pull Request's Review comments.

## List pull requests

    GET /repos/:owner/:repo/pulls

### Parameters

state
: _Optional_ **string** - `open` or `closed` to filter by state. Default
is `open`.

head
: _Optional_ **string** - Filter pulls by head user and branch name in the format
of: `user:ref-name`. Example: `github:new-script-format`.

base
: _Optional_ **string** - Filter pulls by base branch name. Example:
`gh-pages`.

### Response

<%= headers 200 %>
<%= json(:pull) { |h| [h] } %>

## Get a single pull request

    GET /repos/:owner/:repo/pulls/:number

### Response

<%= headers 200 %>
<%= json :full_pull %>

### Mergability

Each time the pull request receives new commits, GitHub creates a merge commit
to _test_ whether the pull request can be automatically merged into the base
branch. (This _test_ commit is not added to the base branch or the head branch.)
The `merge_commit_sha` attribute holds the SHA of the _test_ merge commit;
however, this attribute is [deprecated](/#expected-changes) and is scheduled for
removal in the next version of the API. The Boolean `mergeable` attribute will
remain to indicate whether the pull request can be automatically merged.

### Alternative Response Formats

Pass the appropriate [media type](/v3/media/#commits-commit-comparison-and-pull-requests) to fetch diff and patch formats.

## Create a pull request

    POST /repos/:owner/:repo/pulls

### Input

title
: _Required_ **string**

body
: _Optional_ **string**

base
: _Required_ **string** - The branch (or git ref) you want your changes pulled into.
This should be an existing branch on the current repository.  You cannot
submit a pull request to one repo that requests a merge to a base of
another repo.

head
: _Required_ **string** - The branch (or git ref) where your changes are implemented.

NOTE: `head` and `base` can be either a sha or a branch name. Typically you
would namespace `head` with a user like this: `username:branch`.

<%= json \
  :title     => "Amazing new feature",
  :body      => "Please pull this in!",
  :head      => "octocat:new-feature",
  :base      => "master"
%>

### Alternative Input

You can also create a Pull Request from an existing Issue by passing an
Issue number instead of `title` and `body`.

issue
: _Required_ **number** - Issue number in this repository to turn into a
Pull Request.

<%= json \
  :issue => "5",
  :head  => "octocat:new-feature",
  :base  => "master"
%>

### Response

<%= headers 201, :Location => "https://api.github.com/user/repo/pulls/1" %>
<%= json :pull %>

## Update a pull request

    PATCH /repos/:owner/:repo/pulls/:number

### Input

title
: _Optional_ **string**

body
: _Optional_ **string**

state
: _Optional_ **string** - State of this Pull Request. Valid values are
`open` and `closed`.

<%= json \
  :title     => "new title",
  :body      => "updated body",
  :state     => "open"
%>

### Response

<%= headers 200 %>
<%= json :pull %>

## List commits on a pull request

    GET /repos/:owner/:repo/pulls/:number/commits

### Response

<%= headers 200 %>
<%= json(:commit) { |h| [h] } %>

## List pull requests files

    GET /repos/:owner/:repo/pulls/:number/files

### Response

<%= headers 200 %>
<%= json(:file) { |h| [h] } %>

## Get if a pull request has been merged

    GET /repos/:owner/:repo/pulls/:number/merge

### Response if pull request has been merged

<%= headers 204 %>

### Response if pull request has not been merged

<%= headers 404 %>

## Merge a pull request (Merge Button&trade;)

    PUT /repos/:owner/:repo/pulls/:number/merge

### Input

commit\_message
: _Optional_ **string**  - The message that will be used for the merge commit

### Response if merge was successful

<%= headers 200 %>
<%= json \
  :sha     => '6dcb09b5b57875f334f61aebed695e2e4193db5e',
  :merged  => true,
  :message => 'Pull Request successfully merged'
%>

### Response if merge cannot be performed

<%= headers 405 %>
<%= json \
  :sha     => nil,
  :merged  => false,
  :message => 'Failure reason'
%>

## Custom media types

These are the supported media types for pull requests. You can read more about the
use of media types in the API [here](/v3/media/).

    application/vnd.github.VERSION.raw+json
    application/vnd.github.VERSION.text+json
    application/vnd.github.VERSION.html+json
    application/vnd.github.VERSION.full+json
