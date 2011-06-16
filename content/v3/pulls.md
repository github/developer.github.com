---
title: Pull Request API v3 | developer.github.com
---

# Pull Request API

## List pull requests

    GET /repo/:user/:repo/pulls

### Response

<%= headers 200 %>
<%= json(:pull) { |h| [h] } %>

## Get a single pull request

    GET /repo/:user/:repo/pulls/:id

### Response

<%= headers 200 %>
<%= json :full_pull %>

## Create a pull request

    POST /repo/:user/:repo/pulls

### Input

title
: _Optional_ **string** title for this Pull Request. This will default
to the branch name if no value is specified.

body
: _Optional_ **string** describing this Pull Request.

base
: _Required_ **string** specifying the branch you want your changes
pulled into.

head
: _Required_ **string** specifying the branch where your changes are implemented.

NOTE: `head` and `base` can be either a sha or a branch name. Typically you
would namespace `head` with a user like this: `username:branch`.

#### Example

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
: _Required_ **number** of an issue in this repository to turn into a
Pull Request.

#### Example

<%= json \
  :issue => "5",
  :head  => "ocotocat:new-feature",
  :base  => "master",
%>

### Response

<%= headers 201, :Location => "https://api.github.com/user/repo/pulls/1" %>
<%= json :pull %>

## Update a pull request

    PATCH /repo/:user/:repo/pulls/:id

### Input

title
: _Optional_ **string** title for this Pull Request. This will default
to the branch name if no value is specified.

body
: _Optional_ **string** describing this Pull Request.

state
: _Optional_ **string** to update the state of this Pull Request. Valid
values are `open` and `closed`.

#### Example

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

    GET /repo/:user/:repo/pulls/:id/files

### Response

<%= headers 200 %>
<%= json(:file) { |h| [h] } %>

## Get if a pull request has been merged

    GET /repo/:user/:repo/pulls/:id/merge

### Response if pull request has been merged

<%= headers 204 %>

### Response if pull request has not been merged

<%= headers 404 %>

## Merge a pull request (Merge Button™)

    PUT /repo/:user/:repo/pulls/:id/merge

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
