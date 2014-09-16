---
kind: change
title: Removing token from the Authorizations API
created_at: 2014-09-16
author_name: ptoomey3
---

## API changes

We have deprecated the `token` attribute from all responses in the
[Authorizations API](/v3/oauth_authorizations/). Starting **December 1, 2014**
the API will always provide an empty string as the value for this attribute.


## Reason for the change

The current OAuth Authorizations API requires GitHub to store the full value for
each OAuth token on our servers. In order to increase the security for our
users, we are changing our architecture to store the SHA-256 digest of OAuth
tokens instead. GitHub securely hashes user passwords using bcrypt and we want
to provide comparable security for our users' OAuth tokens as well.

## New attributes

In order to reduce the impact of removing the `token` attribute, the GitHub
Authorizations API has added two new response attributes: `token_last_eight` and
`hashed_token`. While these attributes do not replace the full functionality
provided by the `token` attribute, they can be used in place of `token` for
several common use cases.

* `token_last_eight` returns the last eight characters of the associated OAuth
token. As an example, `token_last_eight` could be used to display a list of
partial token values to help a user manage their OAuth tokens.

* `hashed_token` is the base64 of the SHA-256 digest of the token. `hashed_token`
could be used to programmatically validate a given token matches an
authorization returned by the API.

## Miscellaneous Security Notes

This change is a 100% proactive measure from GitHub and is not associated with
any security incident.

Some users will be curious why we are not using bcrypt to hash our OAuth tokens
like we do for user passwords. Bcrypt is purposefully computationally expensive
in order to mitigate brute force attacks against low entropy passwords. However,
OAuth tokens are highly random and are not susceptible to brute force attacks.
Given that OAuth token validation occurs for each request to the API we chose
SHA-256 for performance reasons.



If you have any questions or feedback, please [get drop us a line][contact].

[contact]: https://github.com/contact?form[subject]=Removing+authorizations+token
