---
kind: change
title: When Does My Rate Limit Reset?
created_at: 2013-07-02
author_name: jasonrudolph
---

Have you ever wondered when your [rate limit][rate-limit-docs] will reset back to its maximum value?
That information is now available in the new `X-RateLimit-Reset` response header.

<pre class="terminal">
$ curl -I https://api.github.com/orgs/octokit

HTTP/1.1 200 OK
Status: 200 OK
X-RateLimit-Limit: 60
X-RateLimit-Remaining: 42
X-RateLimit-Reset: 1372700873
...
</pre>

The `X-RateLimit-Reset` header provides a [Unix UTC timestamp][unix-time], letting you know the exact time that your fresh new rate limit kicks in.

The reset timestamp is also available as part of the `/rate_limit` resource.

<pre class="terminal">
$ curl https://api.github.com/rate_limit

{
  "rate": {
    "limit": 60,
    "remaining": 42,
    "reset": 1372700873
  }
}
</pre>

For more information on rate limits, be sure to check out the [docs][rate-limit-docs].

If you have any questions or feedback, please [drop us a line][contact].


[contact]: https://github.com/contact?form[subject]=X-RateLimit-Reset
[rate-limit-docs]: /v3/#rate-limiting
[unix-time]: http://en.wikipedia.org/wiki/Unix_time
