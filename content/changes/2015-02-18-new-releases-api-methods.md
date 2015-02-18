---
kind: change
title: New Releases API methods
created_at: 2015-02-18
author_name: pengwynn
---

We've added two new methods to the [Releases API][]. You can now get the [latest published release][latest] for a repository.

    GET /repos/:owner/:repo/releases/latest

You can also get a [release by tag name][by-tag].

    GET /repos/:owner/:repo/releases/tags/:tag

If you have any questions or feedback, please [get in touch][contact].

[Releases API]: /v3/repos/releases/
[latest]: /v3/repos/releases/#get-the-latest-release
[by-tag]: /v3/repos/releases/#get-a-release-by-tag-name
[contact]: https://github.com/contact?form[subject]=New+Releases+API+methods
