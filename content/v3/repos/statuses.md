---
title: Statuses | GitHub API
---

# Repo Statuses API

* TOC
{:toc}

The Status API allows external services to mark commits with a success,
failure, error, or pending `state`, which is then reflected in pull requests
involving those commits.

Statuses can also include an optional `description` and `target_url`, and
we highly recommend providing them as they make statuses much more
useful in the GitHub UI.

As an example, one common use is for continuous integration
services to mark commits as passing or failing builds using Status.  The
`target_url` would be the full url to the build output, and the
`description` would be the high level summary of what happened with the
build.

Note that the `repo:status` [OAuth scope](/v3/oauth/#scopes) grants targeted
access to Statuses **without** also granting access to repo code, while the
`repo` scope grants permission to code as well as statuses.

## List Statuses for a specific SHA

    GET /repos/:owner/:repo/statuses/:sha

### Parameters

sha
: _Required_ **string** - Sha to list the statuses from

### Response

<%= headers 200 %>
<%= json(:status) { |h| [h] } %>

## Create a Status

    POST /repos/:owner/:repo/statuses/:sha

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

<%= json \
  :state         => "success",
  :target_url      => "https://example.com/build/status",
  :description   => "The build succeeded!"
%>

### Response

<%= headers 201,
      :Location =>
'https://api.github.com/repos/octocat/example/statuses/1' %>
<%= json :status %>
