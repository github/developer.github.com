---
kind: change
title: Two-Factor Authentication and the API
created_at: 2013-09-03
author_name: mastahyeti
---

As [announced earlier today][dotcom-blog-post], GitHub.com now supports two-factor
authentication (2FA) for increased security. For users with this feature
enabled, GitHub.com will prompt for a 2FA code in addition to a username and
password during authentication. We've also rolled out some improvements to the
API to ensure that 2FA requirements in the API are consistent with GitHub.com.

## Authenticating with the API

For users without 2FA enabled, and for applications using the [OAuth web
flow](/v3/oauth/#web-application-flow) for authentication, everything is
business as usual. You'll continue to authenticate with the API just as you
always have. (That was easy.)

If you enable 2FA _and_ use Basic Authentication to access the API, we're
providing multiple options to make the flow simple and easy.

## Basic Authentication and 2FA

### Personal Access Tokens

Personal access tokens provide the simplest option for using 2FA with Basic
Authentication. You can create these tokens via the [application settings page
on GitHub.com](https://github.com/settings/applications), and you can revoke
them at any time. For more information about authenticating to the API with
personal access tokens, be sure to check out our [help article on the
topic][personal-access-tokens].

### Tightly-integrated 2FA

For developers wishing to integrate GitHub 2FA directly into their application,
the API's Basic Authentication now supports the [ability to send the user's 2FA
code][basic-auth-2fa], in addition to the username and password.

## We're here to help

We think GitHub users are going to love the additional security provided by
two-factor authentication. As always, if you have any questions or feedback,
[let us know][contact]. We're here to help!

[basic-auth-2fa]: /v3/auth/#working-with-two-factor-authentication
[contact]: https://github.com/contact?form[subject]=2FA+and+the+API
[dotcom-blog-post]: https://github.com/blog/1614-two-factor-authentication
[personal-access-tokens]: https://help.github.com/articles/creating-an-access-token-for-command-line-use
