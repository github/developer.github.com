---
title: Deployment | GitHub API
---

# Deployments

* TOC
{:toc}

### Preview mode

<div class="alert">
  <p>
    The Deployments API is currently available for developers to preview.
    During the preview period, the API may change without advance notice.
    Please see the <a href="/changes/2013-12-02-preview-the-new-deployments-api">blog post</a> for full details.
  </p>

  <p>
    To access the API during the preview period, you must provide a custom <a href="/v3/media">media type</a> in the <code>Accept</code> header:
    <pre>application/vnd.github.preview</pre>
</div>

The deployments API is a request for a specific ref(branch,sha,tag) to be
deployed. GitHub then dispatches deployment events that external services can
listen for and act on. This enables developers and organizations to build
tooling around deployments without having to worry about implementation details
of delivering different types of applications (web,native).

Note that the `repo:deployment` [OAuth scope](/v3/oauth/#scopes) grants targeted
access to Deployments **without** also granting access to repo code, while the
`repo` scope grants permission to code as well.

## List Deployments for a Repository

Users with pull access can view deployments for a repository:

    GET /repos/:owner/:repo/deployments

### Response

<%= headers 200, :pagination => true %>
<%= json(:deployment) { |h| [h] } %>

## Create a Deployment

If your repository is taking advantage of [commit statuses](/v3/repos/statuses),
the API will reject requests that do not have a success status. (Your repository
is not required to use commit statuses. If no commit statuses are present, the
deployment will always be created.)

The `force` parameter can be used when you really just need a deployment to go
out. In these cases, all checks are bypassed and the deployment is created for
the ref.

The `auto_merge` parameter is used to ensure that the requested ref is not
behind the repository's default branch. If the ref *is* behind the default
branch for the repository, we will attempt to merge it for you. If the merge
succeeds, the API will return a successful merge commit. If merge conflicts
prevent the merge from succeeding, the API will return a failure response.

The `payload` parameter is available for any extra information that a
deployment system might need. It is a JSON text field that will be passed on
when a deployment event is dispatched.

Users with push access can create a deployment for a given ref:

    POST /repos/:owner/:repo/deployments

### Parameters

Name | Type | Description
-----|------|--------------
`ref`|`string`| Required ref to deploy. This can be a branch, tag, or sha.
`force`|`boolean`| Optional parameter to bypass any ahead/behind checks or commit status checks.
`payload`|`string` | Optional JSON payload with extra information about the deployment.
`auto_merge`|`boolean`| Optional parameter to merge the default branch into the requested deployment branch if necessary.
`description`|`string` | Optional short description

#### Example

<%= json \
  :ref           => "topic-branch",
  :payload       => "{\"environment\":\"production\",\"deploy_user\":\"atmos\",\"room_id\":123456}",
  :description   => "Deploying my sweet branch"
%>

<%= headers 201,
      :Location =>
'https://api.github.com/repos/octocat/example/deployments/1' %>
<%= json :deployment %>

## Updating a Deployment

Once a deployment is created it can not be updated. Information relating to the
success or failure of a deployment is handled through [Deployment Statuses](/v3/repos/deployment_statuses/).
