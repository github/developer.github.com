---
kind: change
title: New attributes for the Deployments API
created_at: 2014-05-19
author_name: atmos
---

We're continuing to iterate on the [Deployments API preview][deployments-preview], and we're starting to see it satisfy more and more use cases. Today we're introducing new attributes for Deployments and Deployment Statuses as well as a few payload changes.

**This is a breaking change for Deployment Status payloads**. If you're trying out this new API during its preview period, you'll need to update your code to continue working with it.

## API Changes

For Deployments we're introducing the concept of an `environment`. An environment is basically a unique identifier for a deployment target. Lots of people tend toward the concept of environments for staging, QA, user acceptance testing, etc. We hope this enhancement will enable more use cases for our users that deploy to multiple environments.

Deployments are also persisting the requested deployment `ref`. Previously we resolved a ref to the current SHA for that ref. Now we'll be keeping the ref around for historical purposes. This is especially helpful if you're deploying branches to verify them before you merge them into your default branch (e.g., "master").

## JSON Payload Changes

We're also adding a few attributes to the outbound Deployment payloads. We're now including the `ref` attribute so you know the branch or tag name that resolved to a specific SHA. The `environment` is also present.

## Webhook Changes

The Deployment Status payloads now embed the associated Deployment object. With this enhancement, Deployment Status events received via webhooks will have enough information to notify other systems, without having to call back to the GitHub API for the `environment`, `ref`, or payload that was deployed.

### Example Deployment JSON

<pre><code class="language-javascript">
{
  "url": "https://api.github.com/repos/my-org/my-repo/deployments/392",
  "id": 392,
  "sha": "837db83be4137ca555d9a5598d0a1ea2987ecfee",
  "ref": "master",
  "environment": "staging",
  "payload": {
    "fe": [
      "fe1",
      "fe2",
      "fe3"
    ]
  },
  "description": "ship it!",
  "creator": {
    "login": "my-org",
    "id": 521,
    "avatar_url": "https://avatars.githubusercontent.com/u/2988?",
    "type": "User"
  },
  "created_at": "2014-05-09T19:56:47Z",
  "updated_at": "2014-05-09T19:56:47Z",
  "statuses_url": "https://api.github.com/repos/my-org/my-repo/deployments/392/statuses"
}
</code></pre>

### Example Deployment Status JSON

<pre><code class="language-javascript">
{
  "url": "https://api.github.com/repos/my-org/my-repo/deployments/396/statuses/1",
  "id": 1,
  "state": "success",
  "deployment": {
    "url": "https://api.github.com/repos/my-org/my-repo/deployments/396",
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
    "environment": "production",
    "description": "Deploying to production",
    "creator": {
      "login": "alysson-goldner",
      "id": 540,
      "type": "User"
    },
    "created_at": "2014-05-09T19:59:36Z",
    "updated_at": "2014-05-09T19:59:36Z",
    "statuses_url": "https://api.github.com/repos/my-org/my-repo/deployments/396/statuses"
  },
  "description": "Deployment succeeded",
  "target_url": "https://deploy.myorg.com/apps/my-repo/logs/420",
  "created_at": "2014-05-09T19:59:39Z",
  "updated_at": "2014-05-09T19:59:39Z",
  "deployment_url": "https://api.github.com/repos/my-org/my-repo/deployments/396"
}
</code></pre>

If you have any questions or feedback, please [get in touch][contact].

[contact]: https://github.com/contact?form[subject]=Deployments+API
[deployments-preview]: https://developer.github.com/changes/2014-01-09-preview-the-new-deployments-api/
