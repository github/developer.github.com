---
kind: change
title: Removing token attribute from Authorizations API responses
created_at: 2014-12-08
author_name: ptoomey3
---

Since OAuth access tokens function like passwords, they should be treated with
care. Today we are making it easier to more securely work with authorizations
via the Authorizations API. We are deprecating the use use of the `token`
attribute in the majority of the [Authorizations API](/v3/oauth_authorizations/)
responses. For the [affected APIs][authorizations-token-deprecation-notice], the
`token` attribute will soon return an empty string. To get ready for that
change, we are giving developers a chance to
[preview the updated API](#preview-period) starting today.

## What's changing?

The current [OAuth Authorizations API](/v3/oauth_authorizations/) requires GitHub to store the full value for
each OAuth token on our servers. In order to increase the security for our
users, we are changing our architecture to store the SHA-256 digest of OAuth
tokens instead. GitHub securely hashes user passwords using bcrypt and we want
to provide comparable security for OAuth tokens as well.

Rest assured that this change is an entirely proactive measure from GitHub and is not associated with any security incident.

## Who is affected?

This change affects any code that relies on accessing the `token` attribute from
[these OAuth Authorizations API responses][authorizations-token-deprecation-notice].
For example, our own [GitHub for Mac][github-for-mac] and
[GitHub for Windows][github-for-windows] applications relied on reading the `token`
from the [Get-or-create an authorization for a specific app][get-or-create-for-app] API, in order to support multiple installations of our desktop application for a single user.

## What should you do?

In order to reduce the impact of removing the `token` attribute, the OAuth
Authorizations API has added a new request attribute (`fingerprint`), added
three new response attributes (`token_last_eight`, `hashed_token`, and
`fingerprint`), and added [one new API][get-or-create-for-app-fingerprint].
While these new APIs and attributes do not replace the full functionality that
previously existed, they can be used in place of `token` for most common use cases.

* `token_last_eight` returns the last eight characters of the associated OAuth
token. As an example, `token_last_eight` could be used to display a list of
partial token values to help a user manage their OAuth tokens.

* `hashed_token` is the base64 of the SHA-256 digest of the token.
`hashed_token` could be used to programmatically validate that a given token
matches an authorization returned by the API.

* `fingerprint` is a new optional request parameter that allows an OAuth
application to create multiple authorizations for a single user. `fingerprint`
should be a string that distinguishes the new authorization from others
for the same client ID and user.

  For example, to differentiate installations of a desktop application across
  multiple devices you might set `fingerprint` to
  `SHA256_HEXDIGEST("GitHub for Mac - MAC_ADDRESS_OF_MACHINE")`. Since
  `fingerprint` is not meant to be a user-facing value, you should still set
  the `note` attribute to help a user differentiate between authorizations on their
  [OAuth applications listing on GitHub][app-listing].

* [Get-or-create an authorization for a specific app and fingerprint][get-or-create-for-app-fingerprint]
is a new API that is analagous to the
[Get-or-create an authorization for a specific app][get-or-create-for-app]
API, but adds support for the new `fingerprint` request parameter.

## Preview period

We are making the new Authorizations API available today for developers to
preview. During this period, we may change aspects of these endpoints. If we do,
we will announce the changes on the developer blog, but we will not provide any
advance notice.

While these new APIs are in their preview period, you’ll need to provide the
following custom media type in the Accept header:

    application/vnd.github.mirage-preview+json

We expect the preview period to last 4-6 weeks. (Stay tuned to the developer blog for updates.) At the end of the preview period, these changes will become an official and stable part of GitHub API.

## Migration period

At the end of the preview period, we will announce the start of a migration period. Developers will have 8 weeks to update existing code to use the new APIs.

## Why SHA-256 over bcrypt?

Some users may be curious why we are not using bcrypt to hash our OAuth tokens
like we do for user passwords. Bcrypt is purposefully computationally expensive
in order to mitigate brute force attacks against low entropy passwords. However,
OAuth tokens are highly random and are not susceptible to brute force attacks.
Given that OAuth token validation occurs for each request to the API we chose
SHA-256 for performance reasons.

If you have any questions or feedback, please [drop us a line][contact].

[contact]: https://github.com/contact?form[subject]=Removing+authorizations+token
[app-listing]: https://github.com/settings/applications
[create-a-new-authorization]: /v3/oauth_authorizations/#create-a-new-authorization
[get-or-create-for-app]: /v3/oauth_authorizations/#get-or-create-an-authorization-for-a-specific-app
[get-or-create-for-app-fingerprint]: /v3/oauth_authorizations/#get-or-create-an-authorization-for-a-specific-app-and-fingerprint
[github-for-mac]: https://mac.github.com/
[github-for-windows]: https://windows.github.com/
[authorizations-token-deprecation-notice]: /v3/oauth_authorizations/#deprecation-notice
