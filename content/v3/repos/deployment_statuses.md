---
title: Deployment Statuses | GitHub API
---

# Deployment Statuses

* TOC
{:toc}

The Deployment Status API allows external services to mark deployments with a
success, failure, error, or pending `state`, which can then be consumed by any
system listening for `deployment_status` events.

Deployment Statuses can also include an optional `description` and `target_url`, and
we highly recommend providing them as they make deployment statuses much more
useful.

As an example, one common use is for deployment systems to mark commits as
succeeding or failing using Deployment Status.  The `target_url` would be the
full URL to the deployment output, and the `description` would be the high
level summary of what happened with the deployment.

Note that the `repo:deployment` [OAuth scope](/v3/oauth/#scopes) grants
targeted access to Deployment Statuses **without** also granting access to repo
code, while the `repo` scope grants permission to code as well.

## List Deployment Statuses

Users with pull access can view deployment statuses for a deployment:

    GET /repos/:owner/:repo/deployments/:id/statuses

### Parameters

Name | Type | Description
-----|------|--------------
`id` |`integer`| **Required**. The Deployment id to list the statuses from.


### Response

<%= headers 200, :pagination => true %>
<%= json(:deployment_status) { |h| [h] } %>

## Create a Deployment Status

Users with push access can create deployment statuses for a given deployment:

    POST /repos/:owner/:repo/deployments/:id/statuses

### Parameters

Name | Type | Description
-----|------|--------------
`state`|`string` | **Required**. The state of the status. Can be one of `pending`, `success`, `error`, or `failure`.
`target_url`|`string` | The target URL to associate with this status.  This URL should contain output to keep the user updated while the task is running or serve as historical information for what happened in the deployment.
`description`|`string` | A short description of the status.

#### Example

<%= json \
  :state       => "success",
  :target_url  => "https://example.com/deployment/42/output",
  :description => "Deployment finished successfully."
%>

### Response

<%= headers 201,
      :Location =>
'https://api.github.com/repos/octocat/example/deployments/42/statuses/1' %>
<%= json :deployment_status %>
