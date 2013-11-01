---
title: GitHub API
---

# The GitHub API

This describes the resources that make up the official GitHub API v3. If
you have any problems or requests please contact
[support](https://github.com/contact?form[subject]=APIv3).

For the new API v3, start browsing the resources on the right >>

View the [API Changelog](/changes) for information on existing and
planned changes to the API.

## Current Version

    Accept: application/vnd.github.beta+json

The GitHub API version is currently in beta.  [The `beta` media type](/v3/media/)
property will be valid until sometime in 2013.  A notice will be given closer
to the actual date.

We consider the "beta" API unchangeable.  [File a support issue](https://github.com/contact)
if you have problems.

### Deprecations

The following functionality is deprecated. For backwards compatibility purposes,
API v3 will continue to provide this functionality. However, this deprecated
functionality **will be removed** in the _next_ major version of the API.

The recommendations below will help you prepare your application for the next major version of the API.

1. Method: /gists/:id/fork
: Recommendation: Use **/gists/:id/forks** (plural) instead.

1. Method: /legacy/issues/search/:owner/:repository/:state/:keyword
: Recommendation: Use [v3 Issue Search API](v3/search/#search-issues) instead.

1. Method: /legacy/repos/search/:keyword
: Recommendation: Use [v3 Repository Search API](/v3/search/#search-repositories) instead.

1. Method: /legacy/user/search/:keyword
: Recommendation: Use [v3 User Search API](/v3/search/#search-users) instead.

1. Method: /legacy/user/email/:email
: Recommendation: Use [v3 User Search API](/v3/search/#search-users) instead.

1. Method: /repos/:owner/:repo/hooks/:id/test
: Recommendation: Use **/repos/:owner/:repo/hooks/:id/tests** (plural) instead.

1. Query parameters when POSTing to /repos/:owner/:repo/forks
: Recommendation: Use JSON to POST to this method instead.

1. Pull Request attribute: merge_commit_sha
: Recommendation: [Do not use this attribute](/changes/2013-04-25-deprecating-merge-commit-sha/).

1. Rate Limit attribute: rate
: Recommendation: Use **resources["core"]** instead.

1. Repository attribute: master_branch
: Recommendation: Use **default_branch** instead.

1. Repository attribute: public
: Recommendation: When [creating a repository](/v3/repos/#create), use the
  **private** attribute to indicate whether the repository should be public or
  private. Do not use the **public** attribute.

1. User attribute: bio
: Recommendation: Do not use this attribute. It is obsolete.

### Breaking Beta Changes

##### June 12, 2012:
* Removed API v1 support
* Removed API v2 support

##### June 15th, 2011:

* `gravatar_url` is being deprecated in favor of `avatar_url` for all
  responses that include users or orgs. A default size is no longer
  included in the URL.
* Creating new gists (both anonymously and with an authenticated user)
  should use `POST /gists` from now on. `POST /users/:user/gists` is no
  longer supported.

##### June 1st, 2011:

* Removed support for PUT verb on update requests. Use POST or PATCH
  instead.
* Removed `.json` extension from all URLs.
* No longer using the X-Next or X-Last headers. Pagination info is
  returned in the Link header instead.
* JSON-P response has completely changed to a more consistent format.
* Starring gists now uses PUT verb (instead of POST) and returns 204.

[v3-email]: /v3/users/emails/#future-response
