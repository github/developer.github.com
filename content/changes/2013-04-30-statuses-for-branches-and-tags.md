---
kind: change
title: Commit Statuses Now Available for Branches and Tags
created_at: 2013-04-30
author_name: foca
---

Last week we announced [support for build statuses in the branches page][blog].
Now we are extending this to the API. The [API endpoint for commit statuses][doc]
has been extended to allow branch and tag names, as well as commit SHAs.

<pre class="terminal">
curl https://api.github.com/repos/rails/rails/statuses/3-2-stable
</pre>

Enjoy.

[blog]: https://github.com/blog/1484-check-the-status-of-your-branches
[doc]: http://developer.github.com/v3/repos/statuses/#list-statuses-for-a-specific-ref
