---
title: Preview the Timeline API
author_name: nickh
---

We've added an API for issue timelines, which will let you fetch a list
of events from an issue or pull request timeline.

To access [the Timeline API][docs] during the preview period, you must provide a custom [media type][media-type] in the `Accept` header:

    application/vnd.github.mockingbird-preview

During the preview period, we may change aspects of these API methods based on developer feedback. If we do, we will announce the changes here on the developer blog, but we will not provide any advance notice.

If you have any questions or feedback, please [let us know][contact]!

[media-type]: /v3/media
[docs]: /v3/issues/timeline/
[contact]: https://github.com/contact?form%5Bsubject%5D=Timeline+API
