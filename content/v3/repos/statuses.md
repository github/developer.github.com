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
`target_url` would be the full URL to the build output, and the
`description` would be the high level summary of what happened with the
build.

Note that the `repo:status` [OAuth scope](/v3/oauth/#scopes) grants targeted
access to Statuses **without** also granting access to repo code, while the
`repo` scope grants permission to code as well as statuses.

## List Statuses for a specific Ref

Users with pull access can view commit statuses for a given ref:

    GET /repos/:owner/:repo/statuses/:ref

### Parameters

Name | Type | Description | Default
-----|------|-------------|---------
`ref`|`string` | **Required**. Ref to list the statuses from. It can be a SHA, a branch name, or a tag name.|


### Response

<%= headers 200 %>
<%= json(:status) { |h| [h] } %>

## Create a Status

Users with push access can create commit statuses for a given ref:

    POST /repos/:owner/:repo/statuses/:sha

### Parameters

Name | Type | Description | Default
-----|------|-------------|---------
`state`|`string` | **Required**. The state of the status. Can be one of `pending`, `success`, `error`, or `failure`.|
`target_url`|`string` | The target URL to associate with this status.  This URL will be linked from the GitHub UI to allow users to easily see the 'source' of the Status.<br/>For example, if your Continuous Integration system is posting build status, you would want to provide the deep link for the build output for this specific SHA:<br/>`http://ci.example.com/user/repo/build/sha`.|
`description`|`string` | A short description of the status|


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
