---
title: developer.github.com
---

# developer.github.com

This describes the resources that make up the official GitHub API v3. If
you have any problems or requests please contact
[support](mailto:support@github.com?subject=APIv3).

For the new API v3, start browsing the resources on the right >>

## Breaking BETA Changes

We're making some small tweaks to the API during the BETA phase.  Old
behavior will be supported until the dates listed below. Please be sure
to update your app in time.

### Behavior due to be removed by July 20th:

* `integrate_branch` on the [repo API](/v3/repos/#get) will no longer be
  returned.

### Changelog for breaking changes

#### Removed on June 15th:

* `gravatar_url` is being deprecated in favor of `avatar_url` for all
  responses that include users or orgs. A default size is no longer
  included in the url.
* Creating new gists (both anonymously and with an authenticated user)
  should use `POST /gists` from now on. `POST /users/:user/gists` is no
  longer supported.

#### Removed on June 1st:

* Removed support for PUT verb on update requests. Use POST or PATCH
  instead.
* Removed `.json` extension from all URLs.
* No longer using the X-Next or X-Last headers. Pagination info is
  returned in the Link header instead.
* JSON-P response has completely changed to a more consistent format.
* Starring gists now uses PUT verb (instead of POST) and returns 204.
