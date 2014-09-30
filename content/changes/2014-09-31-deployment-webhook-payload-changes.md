---
kind: change
title: Deployment webhook payload changes
created_at: 2014-09-24
author_name: atmos
---

Today, we’re introducing a few updates to the [DeploymentEvent][1] and [DeploymentStatusEvent][2] hook payloads. Instead of having deployment and deployment status attributes as top-level keys, we will now nest them under deployment and deployment_status keys. This change brings the payloads for these events more inline with the responses you'd receive from the API.

We'll send payloads including both the new nested format as well as the existing top-level attributes until October 22nd.  At that time we'll remove the top-level attributes and expect everyone to start using the new format.

## DeploymentEvent payloads

#### Previously

<pre><code class="language-javascript">
{
  "id": 42,
  "sha": "deadbeef",
  "ref": "master",
  "task": "deploy",
  "name": "my-org/our-app",
  "environment": "production",
  "payload": {…},
  "description": "Deploying master",
  "repository": {…},
  "sender": {…}
}

</code></pre>

#### Existing

<pre><code class="language-javascript">
{
  "id": 42,
  "sha": "deadbeef",
  "ref": "master",
  "task": "deploy",
  "name": "my-org/our-app",
  "environment": "production",
  "payload": {…},
  "description": "Deploying master",
  "repository": {…},
  "deployment": {
    "url": "https://api.github.com/repos/my-org/our-app/deployments/42",
    "id": 42,
    "sha": "deadbeef",
    "ref": "master",
    "task": "deploy",
    "name": "my-org/our-app",
    "environment": "production",
    "payload": {…},
    "description": "Deploying master",
    "creator": {…},
    "created_at": "2014-09-23T16:37:49Z",
    "updated_at": "2014-09-23T16:37:49Z",
    "statuses_url": "https://api.github.com/repos/my-org/our-app/deployments/42/statuses"
  },
  "sender": {…}
}

</code></pre>

#### Planned

<pre><code class="language-javascript">
{
  "deployment": {
    "url": "https://api.github.com/repos/my-org/our-app/deployments/42",
    "id": 42,
    "sha": "deadbeef",
    "ref": "master",
    "task": "deploy",
    "name": "my-org/our-app",
    "environment": "production",
    "payload": {…},
    "description": "Deploying master",
    "creator": {…},
    "created_at": "2014-09-23T16:37:49Z",
    "updated_at": "2014-09-23T16:37:49Z",
    "statuses_url": "https://api.github.com/repos/my-org/our-app/deployments/42/statuses"
  },
  "repository": {…},
  "sender": {…}
}
</code></pre>

## DeploymentStatusEvent payloads

#### Previously

<pre><code class="language-javascript">
{
  "id": 2600,
  "state": "success",
  "deployment": {…},
  "target_url": "https://gist.github.com/deadbeef",
  "description": "Deployment was successful",
  "repository": {…},
  "sender": {…}
}
</code></pre>

#### Existing

<pre><code class="language-javascript">
{
  "id": 2600,
  "state": "success",
  "target_url": "https://gist.github.com/deadbeef",
  "description": "Deployment was successful",
  "repository": {…},
  "deployment_status": {
    "url": "https://api.github.com/repos/my-org/our-app/deployments/42/statuses2600",
    "id": 2600,
    "state": "success",
    "creator": {…},
    "target_url": "https://gist.github.com/deadbeef",
    "description": "Deployment was successful",
    "created_at": "2014-09-23T16:45:49Z",
    "updated_at": "2014-09-23T16:45:49Z",
    "deployment_url": "https://api.github.com/repos/my-org/our-app/deployments/42",
    "repository_url": "https://api.github.com/repos/my-org/our-app"
  },
  "deployment": {…},
  "sender": {…}
}
</code></pre>

#### Planned

<pre><code class="language-javascript">
{
  "deployment_status": {
    "url": "https://api.github.com/repos/my-org/our-app/deployments/42/statuses2600",
    "id": 2600,
    "state": "success",
    "creator": {…},
    "target_url": "https://gist.github.com/deadbeef",
    "description": "Deployment was successful",
    "created_at": "2014-09-23T16:45:49Z",
    "updated_at": "2014-09-23T16:45:49Z",
    "deployment_url": "https://api.github.com/repos/my-org/our-app/deployments/42",
    "repository_url": "https://api.github.com/repos/my-org/our-app"
  },
  "deployment": {…},
  "repository": {…},
  "sender": {…}
}
</code></pre>

If you have any questions or feedback, please [get in touch][get-in-touch].

[1]: https://developer.github.com/v3/activity/events/types/#deploymentevent
[2]: https://developer.github.com/v3/activity/events/types/#deploymentstatusevent
[get-in-touch]: https://github.com/contact?form[subject]=Deployments+API
