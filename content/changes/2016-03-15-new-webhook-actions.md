---
title: New webhook event actions are coming
author_name: davidcelis
---

We will soon begin introducing new `action` values for several existing webhook events. If you currently subscribe to webhooks but do not check the payload's `action` value, you may end up incorrectly processing events after this change is released. To ensure that your webhook processing is not affected by these new `action` values, **you should audit your webhook processing logic by April 15th, 2016**.

We are providing an advance notice to warn of these changes. In the future, we may continue adding new actions without providing further warning.

### A brief overview of GitHub webhook actions

Webhook events can have multiple actions. For example, the [`IssuesEvent`](https://developer.github.com/v3/activity/events/types/#issuesevent) has several possible actions. These include `opened` when the issue is created, `closed` when the issue is closed, and `assigned` when the issue is assigned to someone. Historically, we haven't added new actions to webhook events that have only one action. However, as GitHub's feature set grows, we may occasionally add new actions to existing event types. We encourage you to take some time and ensure that your application explicitly checks the action before doing any processing.

### What to avoid when working with event actions

Here's an example of functionality that **will not work** when attempting to process an `IssuesEvent`. In this example, the `process_closed` method will be called for any event action which is not `opened` or `assigned`. This means that the `process_closed` method will be called for events with the `closed` action, but also other events with actions other than `opened` or `assigned` that are delivered to the webhook.

```ruby
# The following is not future-proof!
case action
when "opened"
  process_opened
when "assigned"
  process_assigned
else
  process_closed
end
```

### How to work with new event actions

We suggest that you explicitly check event actions and act accordingly. In this example, the `closed` action is checked first before calling the `process_closed` method. Additionally, for unknown actions, we log that something new was encountered:

```ruby
# The following is recommended
case action
when "opened"
  process_opened
when "assigned"
  process_assigned
when "closed"
  process_closed
else
  puts "Ooohh, something new from GitHub!"
end
```

We may also add new webhook event types from time to time. If your webhook is configured to "Send me **everything**", your code should also explicitly check for the event type in a similar way as we have done with checking for the action type above. Take a look at our [integrators best practices guide][best-practices] for more tips.

If you have any questions or feedback, please [get in touch][get-in-touch].

[best-practices]: https://developer.github.com/guides/best-practices-for-integrators/
[get-in-touch]: https://github.com/contact?form[subject]=New+Webhook+Actions
