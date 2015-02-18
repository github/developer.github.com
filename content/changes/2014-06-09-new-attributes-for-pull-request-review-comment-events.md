---
kind: change
title: New attributes for PullRequestReviewComment events
created_at: 2014-06-09
author_name: jdpace
---

We've enhanced the [PullRequestReviewComment events payloads][pr-review-comment-events] to include `action` and `pull_request` attributes. With the addition of the `pull_request` attribute, you now have immediate access to detailed information about the pull request without needing an additional API request.

If you have any questions or feedback, please [get in touch][contact].

[contact]: https://github.com/contact?form[subject]=PullRequestReviewComment+Event+Payloads
[pr-review-comment-events]: https://developer.github.com/v3/activity/events/types/#pullrequestreviewcommentevent
