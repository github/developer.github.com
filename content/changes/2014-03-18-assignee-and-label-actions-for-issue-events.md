---
kind: change
title: Assignee and label actions for issue events
created_at: 2014-3-19
author_name: jdpace
---

Today we're expanding the Event API for issues and pull requests. We've made it easier for your application to know about changes to issues and pull requests with four new triggers. In addition to "opened", "closed, and "reopened", the issues and pull requests events will be triggered for "assigned", "unassigned", "labeled", and "unlabeled" actions. The event payload will also include the respective assignee or label for these new actions.

If you already have a [webhook](/webhooks/) subscribed to the `issues` or `pull_request` events, you'll start seeing these new actions immediately. The new events can also be fetched from the [activity events API](/v3/activity/events/).

For more information, be sure to check out our documentation for the [IssuesEvent](/v3/activity/events/types/#issuesevent) or [PullRequestEvent](/v3/activity/events/types/#pullrequestevent). If you have any questions or feedback, please [drop us a line][contact].

[contact]: https://github.com/contact?form%5Bsubject%5D=New+Actions+for+Issues+and+Pull+Requests
