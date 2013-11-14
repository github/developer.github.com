---
title: Deployment | GitHub API
---

# Deployments API

* TOC
{:toc}

The deployments API allows external services to integrate with requests to
deploy a specific GitHub repository. Deployments define a flexible API that
accomodates releasing both web and native applications. It also complements our
existing releases API when deployments have distributable targets.

The deployments API is a request for a specific ref(branch,sha,tag) to be
deployed. GitHub then dispatches deployment events that external services can
listen for and act on.

Deployments require a successful commit status if your repository is taking
advantage of them and will fail with an error message if the ref does not have
a successful status. Your repo is not required to use commit statuses, if no
commit statuses are present the deployment will be created.

The `force` parameter can be used to bypass all checks. There are times when
you really just need a deployment to go out. In these cases we bypass all
checks and create the Deployment if the ref exists.

The `auto_merge` parameter can be passed in to ensure that the requested ref is
not behind the current default branch. If the deployment ref *is* behind the
default branch for the repository we will attempt to merge it for you.
Returning a successful merge commit or a failure if there are any merge
conflicts.

The `payload` parameter is available for any extra information that a
deployment system might need. It is a JSON text field that will be passed on
when a Deployment event is dispatched.

## List Deployments for a Repository

Users with pull access can view deployments for a repository:

    GET /repos/:owner/:repo/deployments


### Response

<%= headers 200 %>
<%= json(:deployment) { |h| [h] } %>

## Create a Deployment

Users with push access can create a Deployment for a given ref:

    POST /repos/:owner/:repo/deployments

### Parameters

Name | Type | Description 
-----|------|--------------
`ref`|`string`| The ref to deploy. This can be a branch, tag, or sha
`description`|`string` | A short description of the deployment
`payload`|`string` | A JSON payload that is stored and passed on to external services in the event
`auto_merge`|`boolean`| Optional parameter to merge the default branch into the requested deployment branch if it is behind the default branch.
`force`|`boolean`| Optional parameter to bypass any ahead/behind or commit status checks.

#### Example

<%= json \
  :ref           => "topic-branch",
  :payload       => "{\"environment\":\"production\",\"deploy_user\":\"atmos\",\"room_id\":123456}"
  :description   => "Deploying my sweet branch",
%>

<%= headers 201,
      :Location =>
'https://api.github.com/repos/octocat/example/deployments/1' %>
<%= json :deployment %>
