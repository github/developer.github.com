---
kind: change
title: Repository Contributors and Empty Repositories
created_at: 2014-02-20
author_name: izuzak
---

We've made a small change to the [Repository Contributors API](/v3/repos/#list-contributors) in the way empty repositories are handled. Previously, the API returned a `404 Not Found` status when the list of contributors was fetched for an empty repository. To improve consistency with other API endpoints and reduce confusion, the API now returns a `204 No Content` status instead.

If you notice any strangeness, [just let us know](https://github.com/contact?form%5Bsubject%5D=APIv3).
