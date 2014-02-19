---
kind: change
title: Repository Contributors and Empty Repositories
created_at: 2014-02-19
author_name: izuzak
---
​
We've made a small change to the [Repository Contributors API](/v3/repos/#list-contributors) in the way empty repositories are handled. Previously, the API returned a `404 Not Found` status when fetching a list of contributors for empty repositories. To improve consistency with other parts of the API and reduce confusion, the API now returns a `204 No Content` status instead.
​
If you notice any strangeness, [just let us know](https://github.com/contact?form%5Bsubject%5D=APIv3).
