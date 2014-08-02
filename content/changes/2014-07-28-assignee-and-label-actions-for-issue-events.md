---
kind: change
title: New assigned/labeled actions for issue and pull request events
created_at: 2014-07-28
author_name: jdpace
---

As part of the [new GitHub Issues][issues-three], we've added new actions to the issues and pull requests webhook events: "labeled", "unlabeled", "assigned", and "unassigned". The payload will also include the respective assignee or label for these new actions.

If you already have a [webhook](/webhooks/) subscribed to the `issues` or `pull_request` events, you'll start seeing these new actions immediately. The new events can also be fetched from the [issue events API](/v3/issues/events/).

For more information, be sure to check out our documentation for the [IssuesEvent](/v3/activity/events/types/#issuesevent) or [PullRequestEvent](/v3/activity/events/types/#pullrequestevent). If you have any questions or feedback, please [drop us a line][contact].

[issues-three]: https://github.com/blog/1866-the-new-github-issues
[contact]: https://github.com/contact?form%5Bsubject%5D=New+Assigned+and+Labeled+Actions+for+Issues+and+Pull+Request+Events
