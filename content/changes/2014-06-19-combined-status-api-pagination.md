---
kind: change
title: Pagination in the Combined Status API
created_at: 2014-06-19
author_name: bhuga
---

We're getting close to bringing the [Combined Status API][1] out of preview
mode, and have just a couple of small changes to make before it's :sparkles:.

First, we're now [paginating][2] combined status API calls. The combined status
`state` field will always take all statuses into account, but we'll now only
return 100 embedded statuses at a time.

Second, we're adding a `total_count` field, mirroring the Search API. This
count represents the number of contexts submitted for the given commit.

As always, we're interested in [hearing your feedback][3].

[1]: /v3/repos/statuses/#get-the-combined-status-for-a-specific-ref
[2]: /v3/#pagination
[3]: https://github.com/contact?form[subject]=Combined+Status+API
