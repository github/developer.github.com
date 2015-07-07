---
kind: change
title: More flexible options for listing repositories
created_at: 2015-07-22
author_name: jakeboxer
---

We're offering an improved way to filter the repositories returned by the [List your repositories][list-your-repos] API. We've added two new parameters that supercede the old `type` parameter: `visibility` and `affiliation`.

The `visibility` parameter filters repositories by their visibility, while the `affiliation` parameter filters repositories by how they're affiliated with the authenticated user. They can be used separately, together, and in combination with other parameters to craft flexible queries that will fetch the exact repositories you're looking for.

For full details, check out the [List your repositories API documentation][list-your-repos]. If you have any questions or feedback, please [get in touch with us][contact]!

[list-your-repos]: /v3/repos/#list-your-repositories
[contact]: https://github.com/contact?form[subject]=List+your+repositories+API
