---
kind: change
title: Improved pagination for the Repository Commits API
created_at: 2014-05-08
author_name: izuzak
---

The [Repository Commits API](/v3/repos/commits/) now supports an additional approach for paginating [commit lists](/v3/repos/commits/#list-commits-on-a-repository). As of today, this endpoint supports the "standard" [`page` and `per_page` parameters](/v3/#pagination) for controlling pagination. This API now uses these parameters by default when constructing [page links](/v3/#pagination).

The old way of paginating, using `top`, `last_sha`, and `per_page` parameters, is still supported in API v3, but it will be removed in the [next major version of the API](https://developer.github.com/v3/versions/#v3-deprecations). API clients that are manually constructing URLs for pages should be modified to use the new parameters. Even better, API clients shouldn't construct URLs for pages manually, but should use [page links provided by the `Link` header](/guides/traversing-with-pagination/) in API responses.

Since both the new and the old pagination parameters will be supported until the next version of the API, API clients shouldn't notice any changes today. Still, if you notice any problems with this endpoint, please [let us know](https://github.com/contact?form%5Bsubject%5D=API:+Commits+pagination+changes).

This change improves the reliability of this endpoint, which on rare occasions skipped some commits when paginating repository commit lists. This will also increase the overall consistency of the API because all endpoints now paginate resource lists the same way.
