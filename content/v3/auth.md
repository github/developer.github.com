---
title: Authentication | GitHub API
---

# Authentication

* TOC
{:toc}

While the API provides multiple methods for authentication, we strongly
recommend using [OAuth](/v3/oauth/) for production applications. The other
methods provided are intended to be used for scripts or testing where full
OAuth is excessive. Third party applications that rely on GitHub for
authentication should not ask for or collect GitHub credentials and should use
the [OAuth web flow](/v3/oauth).

## Basic Authentication

The API supports Basic Authentication as defined in
[RFC2617](http://www.ietf.org/rfc/rfc2617.txt) with a few slight differences.
The main difference is that the RFC requires unauthenticated requests to be
answered with `401 Unauthorized` responses. In many places, this would disclose
the existence of user data. Instead, the GitHub API responds with `404 Not Found`.
This may cause problems for HTTP libraries that assume a `401 Unauthorized`
response. The solution is to manually craft the `Authorization` header.

To use Basic Authentication with the GitHub API, simply send
the username and password associated with the account. 

<pre class='terminal'>
curl -u mojomob https://api.github.com/user
</pre>

Another way to use OAuth tokens with the API is to provide the token as the
username and provide a blank password or a password of `x-oauth-basic`. This
approach is useful if your tools only support Basic Authentication but you want
to take advantage of OAuth access token security features.

<pre class='terminal'>
curl -u 3816d821c80a6847ca84550052c1ff6246e8169b:x-oauth-basic https://api.github.com/user
</pre>

## Working with two factor authentication

For users with two factor authentication enabled, Basic Authentication requires
an extra step. When Basic Authentication is attempted, the server will respond
with a `401` and an `X-GitHub-OTP: required;:2fa-type` header, indicating that a 
two-factor authentication code is needed in addition to the username and password.
The `:2fa-type` in this header indicates if the account is configured using SMS
or app-based two-factor authentication.

In additon to the Basic Authentication credentials, you must send the user's OTP
in the `X-GitHub-OTP` header. Because the these one time passwords expire quickly,
we recommend using the Authorizations API to [create an access token][create-access]
and using that to [authenticate via OAuth][oauth-auth] for most API access.

Alternately, you can create access tokens from the Personal Access Token
section of your [application settings page](https://github.com/settings/application).

[create-access]: /v3/oauth/#create-a-new-authorization
[oauth-auth]: /v3/#authentication

