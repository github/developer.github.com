---
kind: change
title: Removing token attribute from the Oauth Authorizations API responses (breaking change)
created_at: 2014-09-16
author_name: ptoomey3
---

## API changes

We have deprecated the `token` attribute from the majority of [Authorizations
API](/v3/oauth_authorizations/) responses
(see the
[Authorization deprecation notice][authorizations-token-deprecation-notice] for
a complete list of APIs that are affected). For the affected APIs, the `token`
attribute will return an empty string after **December 31, 2014**.


## What's changing?

The current OAuth Authorizations API requires GitHub to store the full value for
each OAuth token on our servers. In order to increase the security for our
users, we are changing our architecture to store the SHA-256 digest of OAuth
tokens instead. GitHub securely hashes user passwords using bcrypt and we want
to provide comparable security for our users' OAuth tokens as well. To be clear,
this change is a 100% proactive measure from GitHub and is not associated with
any security incident.

## Who is affected?

Any code that relies on accessing the `token` attribute from
[these OAuth Authorizations API responses][authorizations-token-deprecation-notice].
For example, our own [GitHub for Mac][github-for-mac] and
[GitHub for Windows][github-for-windows] applications relied on reading `token`
from the [Get-or-create an authorization for a specific app][get-or-create-for-app]
Authorizations API to allow multiple installations of our desktop application
for a single user.

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
for the same client ID and user. For example, to differentiate installations of
a desktop application across multiple devices you might set `fingerprint` to
`SHA256_HEXDIGEST("GitHub for Mac - MAC_ADDRESS_OF_MACHINE")`. Since
`fingerprint` is not meant to be a user facing value, you should still set
`note` to help a user differentiate between authorizations on their
[OAuth applications listing on GitHub][app-listing]

* [Get-or-create an authorization for a specific app and fingerprint][get-or-create-for-app-fingerprint]
is a new API that is analagous to the
[Get-or-create an authorization for a specific app][get-or-create-for-app]
API, but adds support for the new `fingerprint` request parameter.

To access the new API functionality during the preview period, you must provide
a custom [media type](/v3/media/) in the `Accept` header:
`application/vnd.github.mirage-preview+json`

## Why SHA-256 over bcrypt?

Some users may be curious why we are not using bcrypt to hash our OAuth tokens
like we do for user passwords. Bcrypt is purposefully computationally expensive
in order to mitigate brute force attacks against low entropy passwords. However,
OAuth tokens are highly random and are not susceptible to brute force attacks.
Given that OAuth token validation occurs for each request to the API we chose
SHA-256 for performance reasons.


If you have any questions or feedback, please [get drop us a line][contact].

[contact]: https://github.com/contact?form[subject]=Removing+authorizations+token
[app-listing]: https://github.com/settings/applications
[create-a-new-authorization]: /v3/oauth_authorizations/#create-a-new-authorization
[get-or-create-for-app]: /v3/oauth_authorizations/#get-or-create-an-authorization-for-a-specific-app
[get-or-create-for-app-fingerprint]: /v3/oauth_authorizations/#get-or-create-an-authorization-for-a-specific-app-and-fingerprint
[github-for-mac]: https://mac.github.com/
[github-for-windows]: https://windows.github.com/
[authorizations-token-deprecation-notice]: /v3/oauth_authorizations/#deprecation-notice
