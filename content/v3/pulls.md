---
title: Pull Request API v3 | developer.github.com
---

# Pull Request API

Pull Requests leverage [these](#custom-mime-types) custom mime types. You
can read more about the use of mimes types in the API
[here](/v3/mimes/).

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
: _Required_ **string** - The branch you want your changes pulled into.

head
: _Required_ **string** - The branch where your changes are implemented.

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
: _Required_ **string**

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

These are the support mime types for pull requests. You can read more about the
use of mimes types in the API [here](/v3/mimes/).

    application/vnd.github-pull.raw+json
    application/vnd.github-pull.text+json
    application/vnd.github-pull.html+json
    application/vnd.github-pull.full+json
