---
kind: change
title: Resetting OAuth authorizations in response to Heartbleed security vulnerability
created_at: 2014-04-08
author_name: pengwynn
---

We've added a [new API method][api] for integrators to reset API authorizations
for their OAuth applications. Calling this method will invalidate the old token
  and return a new token for applications to store and use in its place.

This new method provides a safe way to reset user authorization without
requiring users to re-authorize the application on the web. 

Integrators can also use the existing revocation methods to [revoke all
tokens][] or [revoke a single token][] for their applications.

## Heads up: we're breaking the API for your protection.

Due to the recent [Heartbleed security vulnerablity][heartbleed-blog-post] that
affected most of the web, we've decided to revoke all GitHub OAuth tokens
created before our systems were patched. **Starting April XXth, 2014, we'll
begin revoking all OAuth tokens created prior to April XVth, 2014.** To
minimize impact to your users and your applications, we strongly encourage you
to begin [resetting your tokens][api] now.

If you have any questions or feedback, please [get in touch][contact].

[contact]: https://github.com/contact?form[subject]=API+resetting+tokens
[api]: /v3/oauth_authorizations/#reset-an-authorization
[revoke all tokens]: /v3/oauth_authorizations/#revoke-all-authorizations-for-an-application
[revoke a single token]: /v3/oauth_authorizations/#revoke-an-authorization-for-an-application
