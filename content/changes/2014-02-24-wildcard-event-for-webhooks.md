---
kind: change
title: Wildcard Event for Webhooks
created_at: 2014-2-24
author_name: kdaigle
---

We've made a small change to make it easier for webhook integrators to receive "everything".
Instead of adding every event to your webhook, you can now opt-in to all events (including
all new events in the future) by using the [wildcard event](/webhooks/#wildcard-event) (`*`).

If you add this event to an existing webhook, we'll remove the existing specific events and
send you payloads for all supported events. As we add new events, you'll automatically
begin receiving those too.
