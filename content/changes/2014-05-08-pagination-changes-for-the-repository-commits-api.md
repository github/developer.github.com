---
kind: change
title: Pagination changes for the Repository Commits API
created_at: 2014-05-08
author_name: izuzak
---

The [Repository Commits API](/v3/repos/commits/) now supports an additional way for paginating [commit lists](/v3/repos/commits/#list-commits-on-a-repository). As of today, this endpoint supports the "standard" [`page` and `per_page` parameters](/v3/#pagination) for controlling pagination, and will use these by default when constructing page links.

The old way of controlling pagination, using `top`, `last_sha` and `per_page` parameters, is still supported but **will be removed on June 1st 2014**. API clients which are manually constructing URLs for pages should be modified to use the new parameters. Even better, API clients shouldn't construct URLs for pages manually, but use [page links provided by the `Link` header](/v3/#pagination) in API responses.

Since both the new and the old pagination parameters will be supported until June 1st 2014, API clients shouldn't notice any changes today. Still, if you notice any problems with this endpoint, please [let us know](https://github.com/contact?form%5Bsubject%5D=API:+Commits+pagination+changes).

This change improves the reliability of this endpoint, which on rare occasions skipped some commits when paginating repository commit lists. Also, this will increase the overall consistency of the API as all endpoints now use the same way for paginating resource lists.
