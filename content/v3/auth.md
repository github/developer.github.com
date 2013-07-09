---
title: Authentication | GitHub API
---

# Authentication

* TOC
{:toc}

While the API provides multiple methods for authentication, we strongly
recommend using [OAuth](/v3/oauth/) for production applications. The other
methods provided are intended to be used for scripts or testing where full
OAuth is excessive. Independant applications that rely on GitHub for
authentication should not ask for or collect GitHub credentials and should use
the OAuth flows defined [here](/v3/oauth).

## Basic Authentication

The API supports Basic Authentication as defined in
[RFC2617](http://www.ietf.org/rfc/rfc2617.txt) with a few slight differences.
The main difference is that the RFC requires unauthenticated requests to be
answered with `401 Unauthorized` responses. In many places, this would disclose
the existence of user data, so the API instead responds with `404 Not Found`.
This may cause problems for HTTP libraries that assume a `401 Unauthorized`
response. The solution is to manually craft the `Authorization` header.

The simplest way to use Basic Authentication with the GitHub API is to send
the username and password associated with the account. Alternatively, you can
send the an OAuth token instead of the password. This method works well when
using Personal Access Tokens instead of passwords.

Another way to use OAuth tokens with the API is to provide the token as the
username and provide a blank password or a password of `x-oauth-basic`. This
approach is useful when performing Basic Authentication 

## Working with two factor authentication

With two factor authentication enabled on a user's account, they can no longer
authenticate with only username and password. Instead, two alternate
authentication flows have been provided. 

If Basic Authentication is attempted, using the username and password, a `401`
response will be returned with an error message indicating that a one time
password (OTP) is required. This means that in additon to the Basic
Authentication credentials, you must set a `X-GitHub-OTP` header including the
user's current OTP. Because the OTP will only be valid for a short amount of
time, it should be used for requesting an access token that can be used more
permanantly.

If you don't want to ask your users for their OTPs, you can also do Basic
Authentication using a Personal Access Token. Users can generate these by going
to their [application settings page](https://github.com/settings/application)
and they can be used like passwords to login to applications. 