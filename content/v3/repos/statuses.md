---
title: Statuses | GitHub API
---

# Repo Statuses API

## List Statuses for a specific SHA

    GET /repos/:user/:repo/statuses/:sha

### Parameters

sha
: _Required_ **string** - Sha to list the statuses from

### Response

<%= headers 200 %>
<%= json(:status) { |h| [h] } %>

## Create a Status

    POST /repos/:user/:repo/statuses/:sha

### Parameters

state
: _Required_ **string** State of the status - can be one of `pending`,
`success`, `error`, or `failure`.

target_url
: _Optional_ **string** Target url to associate with this status.  This
URL will be linked from the GitHub UI to allow users to easily see the
'source' of the Status.  

: For example, if your Continuous Integration system is posting build
status, you would want to provide the deep link for the build output for
this specific sha - `http://ci.example.com/johndoe/my-repo/builds/sha`.

description
: _Optional_ **string** Short description of the status

### Response

<%= headers 201,
      :Location =>
'https://api.github.com/repos/octocat/example/statuses/1' %>
<%= json :status %>
