---
kind: change
title: New Validation Rule for Beta Code Search API
created_at: 2013-10-18
author_name: jasonrudolph
---

As we [prepare to end the preview period][sept-search-api-post] for the new search API,
we're making sure that it's ready to handle the traffic from all the apps you'll build on top of it.

## New Validation Rule

In order to support the expected volume of requests, we're applying a new validation rule to the [Code Search API][code-search-api].
Starting today, you will need to scope your code queries to a specific set of users, organizations, or repositories.

As usual, you specify the query via the `q` parameter.
The value must include [at least one user, organization, or repository][search-by-user-org-repo].

For example, with this query, we're searching for code from [@twitter][] or [@facebook][] that uses an MIT License:

    MIT License user:twitter user:facebook

And here, we're looking for uses of the underscore library in [@mozilla's BrowserQuest][@mozilla/BrowserQuest] repository:

    underscore language:js repo:mozilla/BrowserQuest

To perform these queries via the API, we would use the following URLs (respectively):

    https://api.github.com/search/code?q=MIT+License+user%3Atwitter+user%3Afacebook

    https://api.github.com/search/code?q=underscore+language%3Ajs+repo%3Amozilla%2FBrowserQuest

All the various [code search qualifiers][code-search-qualifiers] are still available to you.
A [user, organization, or repository qualifier][search-by-user-org-repo] is now required.
The other search qualifiers are still optional.

## Other Search Types Not Affected

This new validation only applies to the [Code Search API][code-search-api].
It does not apply to the Search API for [issues][issue-search-api], [users][user-search-api], or [repositories][repo-search-api].

This validation does not affect searches performed on [github.com/search][web-search].

By ensuring that code queries are more targeted in nature, the API will be ready to meet the expected demand from all your apps.
As we continue to tune the Search API, we hope to relax this validation in the future.
There's no ETA, but we'd like to relax it as soon as it's feasible.

As always, if you have any questions or feedback, please [get in touch][contact].

[@facebook]: https://github.com/facebook
[@twitter]: https://github.com/twitter
[@mozilla/BrowserQuest]: https://github.com/mozilla/BrowserQuest
[code-search-api]: /v3/search/#search-code
[code-search-qualifiers]: https://help.github.com/articles/searching-code
[contact]: https://github.com/contact?form[subject]=New+Validation+Rule+for+Code+Search+API
[issue-search-api]: /v3/search/#search-issues
[repo-search-api]: /v3/search/#search-repositories
[search-by-user-org-repo]: https://help.github.com/articles/searching-code#users-organizations-and-repositories
[sept-search-api-post]: /changes/2013-09-28-an-update-on-the-new-search-api/
[user-search-api]: /v3/search/#search-users
[web-search]: https://github.com/search
