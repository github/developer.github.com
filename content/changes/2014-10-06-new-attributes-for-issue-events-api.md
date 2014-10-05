---
kind: change
title: New Attributes for Issue Events API
created_at: 2014-10-06
author_name: jdpace
---

We've made it easier to track changes to issues. The Issue Events API now provides more context for several event types:

- `assigned` and `unassigned` events now include an `assignee` object so you can see just who was assigned or unassigned.
- `labeled` and `unlabeled` events include a `label` object.
- `milestoned` and `demilesoned` events include a `milestone` object.
- `renamed` events include a `rename` object with the title before and after the rename.

Check out the [Issue Events API documentation][issue-events] for a full list of supported events. If you have
any questions or feedback, please [drop us a line][contact].

[issue-events]: /v3/issues/events/
[contact]: https://github.com/contact?form[subject]=New+Attrs+for+Issue+Events+API
