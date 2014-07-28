---
kind: change
title: Improved CI support for the Deployments API
created_at: 2014-06-11
author_name: atmos
---

Today we're making a few minor changes to the [Deployments API preview][2]. With the introduction of [combined statuses][4] in a [recent update][3], we noticed a few inconsistencies with the API that we'd like to remedy.

We're introducing a new parameter called `required_contexts`. This parameter accepts an array of named [commit status][5] contexts that are ensured to be in a "success" state before the deployment is created. This allows you to verify that more than one system verified your code before you deploy it.

We've removed support for the `force` parameter. The force parameter existed to bypass both the auto-merge and commit status checks. The same behavior can now be accomplished by setting `auto_merge` and `required_contexts` appropriately.

We're also setting a context for all [commit statuses][5]. If a commit status is created without a context, we'll now set it to the string "default".

If you have any questions or concerns, [drop us a line][1].

[1]: https://github.com/contact?form[subject]=Deployments+API
[2]: https://developer.github.com/changes/2014-01-09-preview-the-new-deployments-api/
[3]: https://developer.github.com/changes/2014-04-10-deployment-api-preview-extension/
[4]: https://developer.github.com/changes/2014-03-27-combined-status-api/
[5]: https://developer.github.com/v3/repos/statuses/
