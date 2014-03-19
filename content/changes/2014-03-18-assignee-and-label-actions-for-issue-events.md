---
kind: change
title: Assignee and Label Actions for Issue Events
created_at: 2014-3-18
author_name: jdpace
---

Today we're expanding on the event API around Issues. Starting today, in addition to "opened", "closed, and "reopened", the `issues` event will be triggered for "assigned", "unassigned", "labeled", and "unlabeled" actions. The event payload for issues will also include the respective assignee or label for these new actions.

If you already have a [webhook](/webhooks/) subscribed to the `issues` event, you'll start seeing these new actions immediately. The new events can also be fetched from the [activity events API](/v3/activity/events/).

For more information, be sure to check out our [documentation for the IssuesEvent](/v3/activity/events/types/#issuesevent). If you have any questions or feedback, please [drop us a line][contact].

[contact]: https://github.com/contact?form%5Bsubject%5D=New+Actions+For+Issues+Event
