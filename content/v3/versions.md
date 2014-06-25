---
title: Versions | GitHub API
---
# Versions

There are two stable versions of the GitHub API: the [v3](#v3) version and the deprecated [beta](#beta) version. There are just a few [differences between these two versions](#differences-from-beta-version).

By default, all requests receive the v3 version. We encourage you to [request a specific version via the `Accept` header](/v3/media/#request-specific-version).

# v3

The [v3 API](/v3) is stable and unchangeable. Please [file a support issue][support] if you have problems.

Some v3 functionality is [deprecated](#v3-deprecations) and will be removed in the next major version of the API.

## Differences from beta version

The v3 media type differs from the beta media type in just a few places:

### Gist JSON

For [Gists](/v3/gists/#get-a-single-gist), the v3 media type renames the `user` attribute to `owner`.

### Issue JSON

When an [issue](/v3/issues/#get-a-single-issue) is not a pull request, the v3 media type omits the `pull_request` attribute.

### Repository JSON

For [Repositories](/v3/repos/#get), the v3 media type omits the `master_branch` attribute. API clients should use the `default_branch` attribute to obtain the repository's default branch.

### User Emails JSON

For [User Emails](/v3/users/emails/#list-email-addresses-for-a-user), the v3 media type returns an array of hashes (instead of an array of strings).

## v3 deprecations

The following functionality is deprecated. For backwards compatibility purposes,
v3 will continue to provide this functionality. However, this deprecated
functionality _will be removed_ in the next major version of the API.

The recommendations below will help you prepare your application for the next major version of the API.

1. Method: /gists/:id/fork
: Recommendation: Use **/gists/:id/forks** (plural) instead.

1. Method: /legacy/issues/search/:owner/:repository/:state/:keyword
: Recommendation: Use [v3 Issue Search API](/v3/search/#search-issues) instead.

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

1. Query parameter value: Passing "watchers" as the value for the "sort" parameter in a GET request to /repos/:owner/:repo/forks
: Recommendation: Use **stargazers** as the value instead.

1. Pull Request attribute: merge_commit_sha
: Recommendation: [Do not use this attribute](/changes/2013-04-25-deprecating-merge-commit-sha/).

1. Rate Limit attribute: rate
: Recommendation: Use **resources["core"]** instead.

1. Repository attribute: forks
: Recommendation: Use **forks_count** instead.

1. Repository attribute: master_branch
: Recommendation: Use **default_branch** instead.

1. Repository attribute: open_issues
: Recommendation: Use **open_issues_count** instead.

1. Repository attribute: public
: Recommendation: When [creating a repository](/v3/repos/#create), use the
  **private** attribute to indicate whether the repository should be public or
  private. Do not use the **public** attribute.

1. Repository attribute: watchers
: Recommendation: Use **watchers_count** instead.

1. User attribute: bio
: Recommendation: Do not use this attribute. It is obsolete.

1. User attribute: plan["collaborators"]
: Recommendation: Do not use this attribute. It is obsolete.

1. Pagination parameters `top` and `sha` for method: /repos/:owner/:repo/commits
: Recommendation: When fetching [the list of commits for a repository](/v3/repos/commits/#list-commits-on-a-repository)
  use the [standard `per_page` and `page` parameters](/v3/#pagination) for pagination, instead of `per_page`,
  `top`, and `sha`.

# beta (Deprecated) {#beta}

The [beta API](/v3) is deprecated. Its current functionality is stable and unchangeable. Please [file a support issue][support] if you have problems.

<div class="alert">
  <p>
    <strong>Note</strong>: We recommend using the <a href="#v3">v3 API</a>
    instead of the deprecated beta version of the API.
  </p>
  <p>
    The beta media type differs from the v3 media type in
    <a href="#differences-from-beta-version">just a few places</a>. In most
    cases, migrating an application from the beta media type to the v3 media
    type is smooth and painless.
  </p>
  <p>
    We will eventually retire the beta version, but we have no official
    retirement date to annouce at the moment. When the time comes, rest assured
    that we'll announce the retirement with plenty of notice.
  </p>
</div>

## Breaking beta changes

### June 15th, 2011:

* `gravatar_url` is being deprecated in favor of `avatar_url` for all
  responses that include users or orgs. A default size is no longer
  included in the URL.
* Creating new gists (both anonymously and with an authenticated user)
  should use `POST /gists` from now on. `POST /users/:username/gists` is no
  longer supported.

### June 1st, 2011:

* Removed support for PUT verb on update requests. Use POST or PATCH
  instead.
* Removed `.json` extension from all URLs.
* No longer using the X-Next or X-Last headers. Pagination info is
  returned in the Link header instead.
* JSON-P response has completely changed to a more consistent format.
* Starring gists now uses PUT verb (instead of POST) and returns 204.

# v2

We removed support for API v2 on June 12, 2012.

# v1

We removed support for API v1 on June 12, 2012.

[support]: https://github.com/contact?form[subject]=APIv3
