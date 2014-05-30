---
kind: change
title: Deployments API support for combined statuses
created_at: 2014-05-30
author_name: atmos
---

Today we're making a couple of minor changes to the [Deployments API preview][2]. With the introduction of [combined statuses][4] in the [Deployment API preview update][3], we noticed a few incosistencies with the API that we'd like to remedy.

We now provide a mechanism for bypassing commit status checks without the use of the `force` parameter. Requiring users to use the `force` parameter also bypassed the auto-merging feature which ensures that the requested `ref` is up to date with the repository's default branch. To reconcile this issue we're introducing a new parameter called `required_contexts`. This parameter accepts an array of named [commit status][5] contexts that are ensured to be in a "success" state. If the `required_contexts` array is ommitted then it will attempt to validate that all unique contexts are in a "success" state. If you want to bypass commit status checks pass in an empty array as `required_contexts`.

We've removed support for the `force` parameter. The `force` parameter existed to bypass both the up-to date checks and the commit status checks. The same behavior can now be accomplished by setting `auto_merge` to `false` and `required_contexts` to `[]`.

This will hopefully resolve the last of our concerns around the Deployments API and we'll be extending the preview period until we're fully comfortable with it.

If you have any questions or concerns, [drop us a line][1].

[1]: https://github.com/contact?form[subject]=Deployments+API
[2]: https://developer.github.com/changes/2014-01-09-preview-the-new-deployments-api/
[3]: https://developer.github.com/changes/2014-04-10-deployment-api-preview-extension/
[4]: https://developer.github.com/changes/2014-03-27-combined-status-api/
[5]: https://developer.github.com/v3/repos/statuses/
