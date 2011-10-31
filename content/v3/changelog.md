---
title: GitHub API Changelog
---

# Current Version

The GitHub API version is currently in beta.  The Accept mime type is
`application/vnd.github.beta+json`.  The `beta` mime type property will
be valid until sometime in 2012.  A notice will be given closer to the
actual date.

We consider the beta API unbreakable, so please [file a support
issue](https://github.com/contact) if you have problems.

## Upcoming Version

The API is expected to be finalized in late 2011.

### Expected Changes

* `integrate_branch` on the [repo API](/v3/repos/#get) will no longer be
  returned.

## Breaking Beta Changes

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
