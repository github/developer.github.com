---
title: Other Authentication Methods | GitHub API
---

# Other Authentication Methods

* TOC
{:toc}

While the API provides multiple methods for authentication, we strongly
recommend using [OAuth](/v3/oauth/) for production applications. The other
methods provided are intended to be used for scripts or testing (i.e., cases
where full OAuth would be overkill). Third party applications that rely on
GitHub for authentication should not ask for or collect GitHub credentials.
Instead, they should use the [OAuth web flow](/v3/oauth).

## Basic Authentication

The API supports Basic Authentication as defined in
[RFC2617](http://www.ietf.org/rfc/rfc2617.txt) with a few slight differences.
The main difference is that the RFC requires unauthenticated requests to be
answered with `401 Unauthorized` responses. In many places, this would disclose
the existence of user data. Instead, the GitHub API responds with `404 Not Found`.
This may cause problems for HTTP libraries that assume a `401 Unauthorized`
response. The solution is to manually craft the `Authorization` header.

### Via Username and Password

To use Basic Authentication with the GitHub API, simply send the username and
password associated with the account.

For example, if you're accessing the API via [cURL][curl], the following command
would authenticate you if you replace `<username>` with your GitHub username.
(cURL will prompt you to enter the password.)

<pre class='terminal'>
$ curl -u &lt;username&gt; https://api.github.com/user
</pre>

### Via OAuth Tokens

Alternatively, you can authenticate using [personal access
tokens][personal-access-tokens] or OAuth tokens. To do so, provide the token as
the username and provide a blank password or a password of `x-oauth-basic`. If
you're accessing the API via cURL, replace `<token>` with your OAuth token in
the following command:

<pre class='terminal'>
$ curl -u &lt;token&gt;:x-oauth-basic https://api.github.com/user
</pre>

This approach is useful if your tools only support Basic Authentication but you
want to take advantage of OAuth access token security features.

## Working with two-factor authentication

For users with two-factor authentication enabled, Basic Authentication requires
an extra step. When you attempt to authenticate with Basic Authentication, the
server will respond with a `401` and an `X-GitHub-OTP: required; :2fa-type`
header. This indicates that a two-factor authentication code is needed (in
addition to the username and password). The `:2fa-type` in this header indicates
whether the account receives its two-factor authentication codes via SMS or via
an application.

In addition to the Basic Authentication credentials, you must send the user's
authentication code (i.e., one-time password) in the `X-GitHub-OTP` header.
Because these authentication codes expire quickly, we recommend using the
Authorizations API to [create an access token][create-access] and using that
token to [authenticate via OAuth][oauth-auth] for most API access.

Alternately, you can create access tokens from the Personal Access Token
section of your [application settings page](https://github.com/settings/applications).

[create-access]: /v3/oauth_authorizations/#create-a-new-authorization
[curl]: http://curl.haxx.se/
[oauth-auth]: /v3/#authentication
[personal-access-tokens]: https://github.com/blog/1509-personal-api-tokens
