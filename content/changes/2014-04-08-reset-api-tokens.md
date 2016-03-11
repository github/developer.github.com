---
title: "Recommendation: Reset OAuth authorizations"
author_name: pengwynn
---

As [announced earlier today][heartbleed-blog-post], we are actively responding
to the recently-disclosed [Heartbleed security
vulnerability][heartbleed-blog-post] in OpenSSL. While at this time GitHub has
no indication that the attack has been used beyond testing the vulnerability, we
recommend that integrators [reset the API authorizations][api] for their OAuth
applications.

We've added a [new API method][api] for this exact purpose. Calling this method
will invalidate the old token and return a new token for applications to store
and use in its place. This new method provides a safe way to reset user
authorizations without requiring users to re-authorize the application on the
web.

Integrators can also use the existing revocation methods to ~~revoke all
tokens~~ or [revoke a single token][] for their applications.

{{#tip}}

**UPDATE (2016-01-25):** API v3 no longer provides a method to revoke <em>all</em> of an application's tokens as previously referenced above. If you need to revoke all tokens for your application, you can do so via the <a href="https://github.com/settings/developers">settings page for your application</a>.

{{/tip}}

If you have any questions or feedback, please [get in touch][contact].

[contact]: https://github.com/contact?form[subject]=API+resetting+tokens
[api]: /v3/oauth_authorizations/#reset-an-authorization
[revoke a single token]: /v3/oauth_authorizations/#revoke-an-authorization-for-an-application
[heartbleed-blog-post]: https://github.com/blog/1818-security-heartbleed-vulnerability
