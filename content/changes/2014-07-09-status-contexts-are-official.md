---
kind: change
title: The Combined Status API is official
created_at: 2014-07-09
author_name: bhuga
---

We're happy to announce that the [Combined Status API][docs] is officially part
of the GitHub API v3. We now consider it stable for production use.

Thanks to everyone who provided feedback during the comment period. We got
some great feedback, and hope this feature helps you build the tools you
need to make GitHub the best place to ship exactly the way you want.

### Preview media type no longer needed

If you used the Combined Status API during the preview period, you needed to
provide a custom media type in the `Accept` header:

    application/vnd.github.she-hulk-preview+json

Now that the preview period has ended, you no longer need to pass this custom
media type.

Instead, we [recommend][media-types] that you specify `v3` as the version in the
`Accept` header:

    application/vnd.github.v3+json

### Feedback

We'll never be done listening to you! As always, please don't hesitate to
[share your feedback][feedback].

[docs]: /v3/repos/statuses/#get-the-combined-status-for-a-specific-ref
[media-types]: /v3/media
[feedback]: https://github.com/contact?form[subject]=Combined+Status+API
