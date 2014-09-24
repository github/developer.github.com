---
kind: change
title: Deployment Webhook Payload Changes
created_at: 2014-09-24
author_name: atmos
---

Today, we’re introducing a few updates to the [DeploymentEvent][1] and [DeploymentStatusEvent][2] hook payloads. Instead of having all of the deployment and deployment status event's attributes as top-level keys we're moving them entirely into a named attribute. The payloads match up a lot closer to the payloads you'd receive from the API.

We'll continue sending payloads as before until October 15th. At that time we'll remove the top-level attributes and expect everyone to start using the new format.

## DeploymentEvent payloads

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
  "sender": {…}
}

</code></pre>

#### Updated

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

#### Existing

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

#### Updated

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
