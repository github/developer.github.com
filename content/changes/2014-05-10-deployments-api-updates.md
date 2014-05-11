---
kind: change
title: New attributes for the Deployments API
created_at: 2014-05-10
author_name: atmos
---

We're continuing to iterate on the [Deployments API preview][2], and we're starting to see it satisfy more and more use cases. Today we're introducing new attributes for Deployments and DeploymentStatuses as well as a few payload changes.

**This is a breaking change for DeploymentStatus payloads**. You'll need to update your code to continue working with it.

## API Changes

For Deployments we're introducing the concept of an `environment`. An environment is basically a unique identifier for a deployment target. Lots of people tend toward the concept of environments for staging, QA, and user acceptance testing. We hope this will help our users that deploy to multiple environments interact with the API in a more sane manner.

Deployments are also persisting the request deployment `ref`. Previously we resolved a `ref` to the current `sha` for that ref. Now we'll be keeping it around for historical purposes. This helps a lot if you're deploying branches to verify them before you merge them into your default(master) branch.

## JSON Payload Changes

We're also adding a few attributes to the outbound Deployment payloads. We're now including the `ref` attribute so you know the branch or tag name that resolved to a specific sha. The `environment` will also be present.

The DeploymentStatus payloads now include a copy of the associated Deployment object. Ths means that DeploymentStatus events received via webhooks will have enough information to notify other systems without having to callback to GitHub for the `environment`, `ref`, or payload that was deployed.

### Example Deployment Payload

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

### Example DeploymentStatus

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
