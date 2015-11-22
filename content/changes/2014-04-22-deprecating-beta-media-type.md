---
kind: change
title: Deprecating the beta media type
created_at: 2014-04-22
author_name: jasonrudolph
---

Now that the GitHub API is [serving the v3 media type by default][v3-default], we are deprecating the legacy [beta media type][beta].

We will eventually remove support for the beta media type, but we have no official retirement date to annouce at the moment. When the time comes, rest assured that we'll announce the retirement with plenty of notice. In the meantime, existing API clients that rely on the beta media type should start making plans to migrate to v3. The beta media type differs from v3 in [just a few places][differences]. In most cases, migrating an application from the beta media type to the v3 media type is smooth and painless.

As always, if you have any questions, please [get in touch][contact].

[v3-default]: /changes/2014-01-07-upcoming-change-to-default-media-type/
[beta]: /v3/versions/#beta
[differences]: /v3/versions/#differences-from-beta-version
[contact]: https://github.com/contact?form[subject]=API:+Deprecating+the+beta+media+type
