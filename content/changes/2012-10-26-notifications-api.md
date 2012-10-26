---
kind: change
title: Notifications API
created_at: 2012-10-26
author_name: technoweenie
---

Now that the dust has settled around [Notifications and Stars][newsies],
we've unleashed all that :sparkles: in a [brand new API][api].  You can now
view and mark notifications as read.

[api]: http://developer.github.com/v3/activity/notifications/
[newsies]: https://github.com/blog/1204-notifications-stars

## Endpoint

The core notifications functionality is under the `/notifications` endpoint.
You can look for unread notifications:

<pre class="terminal">
$ curl https://api.github.com/notifications
</pre>

You can filter these notifications to a single Repository:

<pre class="terminal">
$ curl https://api.github.com/repos/technoweenie/faraday/notifications
</pre>

You can mark them as read:

<pre class="terminal">
# all notifications
$ curl https://api.github.com/notifications \
    -X PUT -d '{"read": true}'

# notifications for a single repository
$ curl https://api.github.com/repos/technoweenie/faraday/notifications \
    -X PUT -d '{"read": true}'
</pre>

You can also modify subscriptions for a Repository or a single thread.

<pre class="terminal">
# subscription details for the thread (either an Issue or Commit)
$ curl https://api.github.com/notifications/threads/1/subscription

# subscription details for a whole Repository.
$ curl https://api.github.com/repos/technoweenie/faraday/subscription
</pre>

## Polling

The Notifications API is optimized for polling by the last modified time:

<pre class="terminal">
# Add authentication to your requests
$ curl -I https://api.github.com/notifications
HTTP/1.1 200 OK
Last-Modified: Thu, 25 Oct 2012 15:16:27 GMT
X-Poll-Interval: 60

# Pass the Last-Modified header exactly
$ curl -I https://api.github.com/notifications
    -H "If-Modified-Since: Thu, 25 Oct 2012 15:16:27 GMT"
HTTP/1.1 304 Not Modified
X-Poll-Interval: 60
</pre>

You can read about the API details in depth in the [Notifications documentation][api].


