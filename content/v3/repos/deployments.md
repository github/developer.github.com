---
title: Deployments | GitHub API
---

# Deployments

* TOC
{:toc}

Deployments are a request for a specific ref(branch,sha,tag) to be deployed.
GitHub then dispatches deployment events that external services can listen for
and act on. This enables developers and organizations to build loosely-coupled
tooling around deployments, without having to worry about implementation
details of delivering different types of applications (e.g., web, native).

Deployment Statuses allow external services to mark deployments with a
'success', 'failure', 'error', or 'pending' state, which can then be consumed
by any system listening for `deployment_status` events.

Deployment Statuses can also include an optional `description` and `target_url`, and
we highly recommend providing them as they make deployment statuses much more
useful. The `target_url` would be the full URL to the deployment output, and
the `description` would be the high level summary of what happened with the
deployment.

Deployments and Deployment Statuses both have associated
[repository events](/v3/activity/events/types/#deploymentevent) when
they're created. This allows webhooks and 3rd party integrations to respond to
deployment requests as well as update the status of a deployment as progress is
made.

Below is a simple sequence diagram for how these interactions would work.

<pre>
+---------+             +--------+            +-----------+        +-------------+
| Tooling |             | GitHub |            | 3rd Party |        | Your Server |
+---------+             +--------+            +-----------+        +-------------+
     |                      |                       |                     |
     |  Create Deployment   |                       |                     |
     |--------------------->|                       |                     |
     |                      |                       |                     |
     |  Deployment Created  |                       |                     |
     |<---------------------|                       |                     |
     |                      |                       |                     |
     |                      |   Deployment Event    |                     |
     |                      |---------------------->|                     |
     |                      |                       |     SSH+Deploys     |
     |                      |                       |-------------------->|
     |                      |                       |                     |
     |                      |   Deployment Status   |                     |
     |                      |<----------------------|                     |
     |                      |                       |                     |
     |                      |                       |   Deploy Completed  |
     |                      |                       |<--------------------|
     |                      |                       |                     |
     |                      |   Deployment Status   |                     |
     |                      |<----------------------|                     |
     |                      |                       |                     |
</pre>

Keep in mind that GitHub is never actually accessing your servers. It's up to
your 3rd party integration to interact with deployment events.  This allows for
[github-services](https://github.com/github/github-services) integrations as
well as running your own systems depending on your use case.  Multiple systems
can listen for deployment events, and it's up to each of those systems to
decide whether or not they're responsible for pushing the code out to your
servers, building native code, etc.

Note that the `repo_deployment` [OAuth scope](/v3/oauth/#scopes) grants
targeted access to Deployments and Deployment Statuses **without**
granting access to repository code, while the `repo` scope grants permission to code
as well.

## List Deployments

Simple filtering of deployments is available via query parameters:

    GET /repos/:owner/:repo/deployments

Name | Type | Description
-----|------|--------------
`sha`|`string` | The short or long sha that was recorded at creation time. Default: `none`
`ref`|`string` | The name of the ref. This can be a branch, tag, or sha. Default: `none`
`task`|`string` | The name of the task for the deployment. e.g. `deploy` or `deploy:migrations`. Default: `none`
`environment`|`string` | The name of the environment that was deployed to. e.g. `staging` or `production`. Default: `none`

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:deployment) { |h| [h] } %>

## Create a Deployment

Deployments offer a few configurable parameters with sane defaults.

The `ref` parameter can be any named branch, tag, or sha. At GitHub we often
deploy branches and verify them before we merge a pull request.

The `environment` parameter allows deployments to be issued to different
runtime environments. Teams often have multiple environments for verifying
their applications, like 'production', 'staging', and 'qa'. This allows for
easy tracking of which environments had deployments requested. The default
environment is 'production'.

The `auto_merge` parameter is used to ensure that the requested ref is not
behind the repository's default branch. If the ref *is* behind the default
branch for the repository, we will attempt to merge it for you. If the merge
succeeds, the API will return a successful merge commit. If merge conflicts
prevent the merge from succeeding, the API will return a failure response.

By default, [commit statuses](/v3/repos/statuses) for every submitted context
must be in a 'success' state. The `required_contexts` parameter allows you to
specify a subset of contexts that must be "success", or to specify contexts
that have not yet been submitted. You are not required to use commit statuses
to deploy. If you do not require any contexts or create any commit statuses,
the deployment will always succeed.

The `payload` parameter is available for any extra information that a
deployment system might need. It is a JSON text field that will be passed on
when a deployment event is dispatched.

The `task` parameter is used by the deployment system to allow different
execution paths. In the web world this might be 'deploy:migrations' to run
schema changes on the system. In the compiled world this could be a flag to
compile an application with debugging enabled.

Users with `repo` or `repo_deployment` scopes can create a deployment for a given ref:

    POST /repos/:owner/:repo/deployments

### Parameters

Name | Type | Description
-----|------|--------------
`ref`|`string`| **Required**. The ref to deploy. This can be a branch, tag, or sha.
`task`|`string`| Optional parameter to specify a task to execute, e.g. `deploy` or `deploy:migrations`. Default: `deploy`
`auto_merge`|`boolean`| Optional parameter to merge the default branch into the requested ref if it is behind the default branch. Default: `true`
`required_contexts`|`Array`| Optional array of status contexts verified against commit status checks. If this parameter is omitted from the parameters then all unique contexts will be verified before a deployment is created. To bypass checking entirely pass an empty array. Defaults to all unique contexts.
`payload`|`string` | Optional JSON payload with extra information about the deployment. Default: `""`
`environment`|`string` | Optional name for the target deployment environment (e.g., production, staging, qa). Default: `"production"`
`description`|`string` | Optional short description. Default: `""`

#### Simple Example

A simple example putting the user and room into the payload to notify back to
chat networks.

<%= json \
  :ref           => "topic-branch",
  :payload       => "{\"user\":\"atmos\",\"room_id\":123456}",
  :description   => "Deploying my sweet branch"
%>

<%= headers 201, :Location => get_resource(:deployment)['url'] %>
<%= json :deployment %>

#### Advanced Example

A more advanced example specifying required commit statuses and bypassing auto-merging.

<%= json \
  :ref               => "topic-branch",
  :auto_merge        => false,
  :payload           => "{\"user\":\"atmos\",\"room_id\":123456}",
  :description       => "Deploying my sweet branch",
  :required_contexts => ["ci/janky", "security/brakeman"]
%>

<%= headers 201, :Location => get_resource(:deployment)['url'] %>
<%= json :deployment %>

## Update a Deployment

Once a deployment is created, it cannot be updated. Information relating to the
success or failure of a deployment is handled through Deployment Statuses.

# Deployment Statuses

## List Deployment Statuses

Users with pull access can view deployment statuses for a deployment:

    GET /repos/:owner/:repo/deployments/:id/statuses

### Parameters

Name | Type | Description
-----|------|--------------
`id` |`integer`| **Required**. The Deployment ID to list the statuses from.


### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:deployment_status) { |h| h.delete("deployment"); [h] } %>

## Create a Deployment Status

Users with push access can create deployment statuses for a given deployment:

    POST /repos/:owner/:repo/deployments/:id/statuses

### Parameters

Name | Type | Description
-----|------|--------------
`state`|`string` | **Required**. The state of the status. Can be one of `pending`, `success`, `error`, or `failure`.
`target_url`|`string` | The target URL to associate with this status.  This URL should contain output to keep the user updated while the task is running or serve as historical information for what happened in the deployment. Default: `""`
`description`|`string` | A short description of the status. Default: `""`

#### Example

<%= json \
  :state       => "success",
  :target_url  => "https://example.com/deployment/42/output",
  :description => "Deployment finished successfully."
%>

### Response

<%= headers 201, :Location => get_resource(:deployment_status)['url'] %>
<%= json :deployment_status %>
