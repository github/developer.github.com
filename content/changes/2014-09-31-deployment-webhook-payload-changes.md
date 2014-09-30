---
kind: change
title: Deployment webhook payload changes
created_at: 2014-09-31
author_name: atmos
---

Today we're introducing a compatability period for a breaking change to the [deployment][1] and [deployment status][2] payloads for webhooks. This change brings the payloads for these events more inline with the responses you'd receive from the API. During this period we'll continue sending the previous payload formats but we've started sending the new format along also. On October 22nd, 2014, we will stop sending the old payload formats. Integrators who are working with webhooks and deployments are advised to upgrade to the new payload format to avoid service interruption.

## DeploymentEvent Changes

#### Old Format

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

#### Current Format - 2014/09/31

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

#### New Format - 2014/10/22

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

## DeploymentStatusEvent Changes

#### Old Format

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

#### Current Format - 2014/09/31

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

#### New Format - 2014/10/22

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

Since we're still in the [preview period][3] for the deployments API we felt it was best to correct this inconsistency now. If you have any questions or feedback, please [get in touch][get-in-touch].

[1]: https://developer.github.com/v3/activity/events/types/#deploymentevent
[2]: https://developer.github.com/v3/activity/events/types/#deploymentstatusevent
[3]: https://developer.github.com/changes/2014-01-09-preview-the-new-deployments-api/
[get-in-touch]: https://github.com/contact?form[subject]=Deployments+API
