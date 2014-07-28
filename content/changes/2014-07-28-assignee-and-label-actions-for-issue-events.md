---
kind: change
title: New assigned/labeled actions for issue and pull request events
created_at: 2014-7-28
author_name: jdpace
---

Hot on the heels of [The New GitHub Issues](https://github.com/blog/1866-the-new-github-issues) we're expanding webook payloads for issues and pull requests. We've made it easier for your application to know about changes to issues and pull requests with four new triggers. In addition to "opened", "closed, and "reopened", the issues and pull requests webhooks will be triggered for "assigned", "unassigned", "labeled", and "unlabeled" actions. The payload will also include the respective assignee or label for these new actions.

If you already have a [webhook](/webhooks/) subscribed to the `issues` or `pull_request` events, you'll start seeing these new actions immediately. The new events can also be fetched from the [issue events API](/v3/issues/events/).

For more information, be sure to check out our documentation for the [IssuesEvent](/v3/activity/events/types/#issuesevent) or [PullRequestEvent](/v3/activity/events/types/#pullrequestevent). If you have any questions or feedback, please [drop us a line][contact].

[contact]: https://github.com/contact?form%5Bsubject%5D=New+Assigned+and+Labeled+Actions+for+Issues+and+Pull+Request+Events
