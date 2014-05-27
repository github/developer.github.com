---
kind: change
title: Deployments API support for combined statuses
created_at: 2014-05-30
author_name: atmos
---

Today we're making a couple of minor changes to the [Deployments API preview][2]. With the introduction of [combined statuses][4] in the [Deployment API preview update][3], we realized a few incosistencies with the API that we'd like to remedy.

The first change provides a mechanism for bypassing commit status checks without the use of the `force` parameter. Requiring users to use the `force` parameter bypassed the auto-merging feature which ensures that the requested `ref` is up to date with the repo's default branch. To remedy this, we're introducing a new boolean parameter called `commit_status_check`. If this parameter is provided, and is set to `false`, commit status checks will not be run during deployment creation. The default behavior will be as before though, and you should verify commit statuses are in a `success` state before creating a deployment.

The second change allows for specific contexts to be required when creating a deployment. To reconcile this issue we're introducing a new parameter called `commit_status_contexts`. This parameter accepts an array of named contexts that are ensured to be in a "success" state. If the `commit_status_contexts` array is ommitted then it will attempt to validate that all unique contexts are in a "success" state. If you aren't using multiple commit status contexts then this parameter can be safely omitted and we will verify the default context.

We're also deprecating the `force` parameter entirely. The `force` parameter existed to bypass both the up-to date checks and the commit status checks. The same behavior can now be accomplished by setting both the `auto_merge` and `commit_status_check` to `false`.

This will hopefully resolve the last of our concerns around the Deployments APIand we're hoping to take it out of preview mode in the next 60 days.

If you have any questions or concerns, [drop us a line][1].

[1]: https://github.com/contact?form[subject]=Deployments+API
[2]: https://developer.github.com/changes/2014-01-09-preview-the-new-deployments-api/
[3]: https://developer.github.com/changes/2014-04-10-deployment-api-preview-extension/
[4]: https://developer.github.com/changes/2014-03-27-combined-status-api/
