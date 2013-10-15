---
kind: change
title: New Validation Rules for the Code Search API
created_at: 2013-10-18
author_name: jasonrudolph
---

As we [prepare to end the preview period][sept-search-api-post] for the new search API,
we're making sure that it's ready to handle the traffic from all the apps you'll build on top of it.

In order to support the expected volume of requests, we're applying some new validation rules to the [Code Search API][code-search-docs].
Starting today, you will need to scope your code queries to a specific set of [users, organizations, or repositories][search-by-user-org-repo].

**TODO**: Include an example?

By ensuring that code queries are more targeted in nature, the API will be ready to meet the expected demand from all your apps.

As we continue to tune the Search API, we hope to relax this validation in the future.
There's no ETA, but we'd like to relax it as soon as it's feasible.
However, rather than delay the stable release of the Code Search API, we're putting this validation in place for now.

As always, if you have any questions or feedback, please [get in touch][contact].

[code-search-docs]: /v3/search/#search-code
[contact]: https://github.com/contact?form[subject]=New+Validation+Rules+for+Code+Search+API
[search-by-user-org-repo]: https://help.github.com/articles/searching-code#users-organizations-and-repositories
[sept-search-api-post]: /changes/2013-09-28-an-update-on-the-new-search-api/
