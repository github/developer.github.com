---
title: Pull Requests | GitHub API
---

# Pull Request API

Pull Requests leverage [these](#custom-mime-types) custom mime types. You
can read more about the use of mime types in the API
[here](/v3/mime/).

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

    GET /repos/:user/:repo/pulls

### Parameters

state
: _Optional_ **string** - `open` or `closed` to filter by state. Default
is `open`.

### Response

<%= headers 200 %>
<%= json(:pull) { |h| [h] } %>

## Get a single pull request

    GET /repos/:user/:repo/pulls/:id

### Response

<%= headers 200 %>
<%= json :full_pull %>

## Create a pull request

    POST /repos/:user/:repo/pulls

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
  :base      => "master",
%>

### Alternative Input

You can also create a Pull Request from an existing Issue by passing an
Issue number instead of `title` and `body`.

issue
: _Required_ **number** - Issue number in this repository to turn into a
Pull Request.

<%= json \
  :issue => "5",
  :head  => "ocotocat:new-feature",
  :base  => "master",
%>

### Response

<%= headers 201, :Location => "https://api.github.com/user/repo/pulls/1" %>
<%= json :pull %>

## Update a pull request

    PATCH /repos/:user/:repo/pulls/:id

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
  :state     => "open",
%>

### Response

<%= headers 200 %>
<%= json :pull %>

## List commits on a pull request

    GET /repos/:user/:repo/pulls/:id/commits

### Response

<%= headers 200 %>
<%= json(:commit) { |h| [h] } %>

## List pull requests files

    GET /repos/:user/:repo/pulls/:id/files

### Response

<%= headers 200 %>
<%= json(:file) { |h| [h] } %>

## Get if a pull request has been merged

    GET /repos/:user/:repo/pulls/:id/merge

### Response if pull request has been merged

<%= headers 204 %>

### Response if pull request has not been merged

<%= headers 404 %>

## Merge a pull request (Merge Button™)

    PUT /repos/:user/:repo/pulls/:id/merge
    
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
  :message => 'Failure reason',
%>

## Custom Mime Types

These are the supported mime types for pull requests. You can read more about the
use of mime types in the API [here](/v3/mime/).

    application/vnd.github.VERSION.raw+json
    application/vnd.github.VERSION.text+json
    application/vnd.github.VERSION.html+json
    application/vnd.github.VERSION.full+json
