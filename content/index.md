---
title: GitHub API
---

# The GitHub API

This describes the resources that make up the official GitHub API v3. If
you have any problems or requests please contact
[support](mailto:support@github.com?subject=APIv3).

For the new API v3, start browsing the resources on the right >>

View the [API Changelog](/v3/changelog) for information on existing and
planned changes to the API.

## Current Version

    Accept: application/vnd.github.beta+json

The GitHub API version is currently in beta.  The `beta` mime type property will
be valid until sometime in 2012.  A notice will be given closer to the
actual date.

We consider the beta API unbreakable, so please [file a support
issue](https://github.com/contact) if you have problems.

### Upcoming Version

    Accept: application/vnd.github.v3+json

The API is expected to be finalized Real Soon Now.

#### Expected Changes

* All `*_url` attributes move to a `_links` object.  See [Pull
  Requests](http://developer.github.com/v3/pulls/#get-a-single-pull-request) for an example.
* The `/repos/:user/:repo/hooks/:id/test` action becomes
  `/repos/:user/:repo/hooks/:id/tests`.
* The `/gists/:id/fork` action becomes `/gists/:id/forks`.
* Gist forks/history objects become separate API calls.
* Gist files object is not returned on Gist listings.
* Commit schema will change to be [more consistent](https://gist.github.com/3a2e5779588e21b0c0f3).
* `master_branch` becomes `default_branch`.
* `integrate_branch` on the [repo API](/v3/repos/#get) will no longer be
  returned.
* Use the `private` attribute when creating a private repository,
  instead of setting `public` to false.

### Breaking Beta Changes

##### Removed on June 12, 2012:
* API v1 support
* API v2 support

##### Removed on June 15th, 2011:

* `gravatar_url` is being deprecated in favor of `avatar_url` for all
  responses that include users or orgs. A default size is no longer
  included in the url.
* Creating new gists (both anonymously and with an authenticated user)
  should use `POST /gists` from now on. `POST /users/:user/gists` is no
  longer supported.

##### Removed on June 1st, 2011:

* Removed support for PUT verb on update requests. Use POST or PATCH
  instead.
* Removed `.json` extension from all URLs.
* No longer using the X-Next or X-Last headers. Pagination info is
  returned in the Link header instead.
* JSON-P response has completely changed to a more consistent format.
* Starring gists now uses PUT verb (instead of POST) and returns 204.
