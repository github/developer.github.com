---
kind: change
title: New attributes for the Deployments API
created_at: 2014-05-05
author_name: atmos
---

We're still iterating on the [Deployments API preview mode][2]starting to feel pretty good about the Deployments API, and we'd like to introduce a new payload field plus a few extra attributes to the events API.

## API Changes

We're introducing the concept of an `environment`. An environment is basically a unique identifier for a deployment target, lots of people tend toward the concept of environments for staging and QA. We hope this will help for users that deploy to multiple environments.

## Event Changes

We're also adding a few attributes to the outbound payloads. We're now including the `ref` attribute so you know the branch or tag name that resolved to a specific sha. We're also including the `environment` and `sha` on both the Deployment and DeploymentStatus payloads.

### Deployment

<pre><code class="language-javascript">
{
  "url": "https://api.github.com/repos/my-org/my-repo/deployments/392",
  "id": 392,
  "sha": "837db83be4137ca555d9a5598d0a1ea2987ecfee",
  "ref": "master",
  "payload": {
    "fe": [
      "fe1",
      "fe2",
      "fe3"
    ]
  },
  "environment": "staging",
  "description": "ship it!",
  "creator": {
    "login": "my-org",
    "id": 521,
    "avatar_url": "http://alambic.github.test/avatars/u/521?",
    "type": "User"
  },
  "created_at": "2014-05-09T19:56:47Z",
  "updated_at": "2014-05-09T19:56:47Z",
  "statuses_url": "https://api.github.com/repos/my-org/my-repo/deployments/392/statuses"
}
</code></pre>

### DeploymentStatus

<pre><code class="language-javascript">
{
  "url": "https://api.github.com/repos/my-org/my-repo/deployments/396/statuses/1",
  "id": 1,
  "state": "success",
  "deployment": {
    "url": "https://api.github.com/repos/my-org/my-repo/deployments/396",
    "id": 396,
    "sha": "3b1039786c4c24b7a94987dc92fa4a92636c4e02",
    "ref": "master",
    "payload": {

    },
    "environment": "production",
    "description": null,
    "creator": {
      "login": "alysson-goldner",
      "id": 540,
      "type": "User"
    },
    "created_at": "2014-05-09T19:59:36Z",
    "updated_at": "2014-05-09T19:59:36Z",
    "statuses_url": "https://api.github.com/repos/my-org/my-repo/deployments/396/statuses"
  },
  "description": null,
  "target_url": "https://deploy.myorg.com/apps/my-repo/logs/420",
  "created_at": "2014-05-09T19:59:39Z",
  "updated_at": "2014-05-09T19:59:39Z",
  "deployment_url": "https://api.github.com/repos/my-org/my-repo/deployments/396"
}
</code></pre>

If you have any questions or feedback, please [get in touch][contact].

[contact]: https://github.com/contact?form[subject]=Deployments+API
