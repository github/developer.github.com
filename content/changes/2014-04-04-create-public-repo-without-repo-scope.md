---
kind: change
title: Grant access to create public repositories without granting access to private repositories
created_at: 2014-04-04
author_name: pengwynn
---

The [Create Repository method][api] now allows creating public repositories via
OAuth with `public_repo` [scope][].  This means you can safely grant third
party applications the ability to create public repositories on your behalf
without granting access to your private repositories.

If you have any questions or feedback, please [get in touch][contact].

[contact]: https://github.com/contact?form[subject]=API+create+repositories+with+public_repo+scope
[api]: /v3/repos/#create
[scope]: /v3/oauth/#scopes
