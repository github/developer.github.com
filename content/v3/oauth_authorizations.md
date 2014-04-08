---
title: Authorizations | GitHub API
---

# OAuth Authorizations API

* TOC
{:toc}

There is an API for users to manage their own tokens.  You can only access your
own tokens, and only via [Basic Authentication](/v3/auth#basic-authentication).
(Make sure you understand how to [work with two-factor
authentication](/v3/auth/#working-with-two-factor-authentication) if you or your
users have two-factor authentication enabled.)

## List your authorizations

    GET /authorizations

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:oauth_access) { |h| [h] } %>

## Get a single authorization

    GET /authorizations/:id

### Response

<%= headers 200 %>
<%= json :oauth_access %>

## Create a new authorization

If you need a small number of tokens, implementing the [web flow](/v3/oauth/#web-application-flow)
can be cumbersome. Instead, tokens can be created using the Authorizations API using
[Basic Authentication](/v3/auth#basic-authentication). To create tokens for a particular OAuth application, you
must provide its client ID and secret, found on the OAuth application settings
page, linked from your [OAuth applications listing on GitHub][app-listing]. OAuth tokens
can also be created through the web UI via the [Application settings page](https://github.com/settings/applications).
Read more about these tokens on the [GitHub Help page](https://help.github.com/articles/creating-an-access-token-for-command-line-use).

    POST /authorizations

### Parameters

Name | Type | Description
-----|------|--------------
`scopes`|`array` | A list of scopes that this authorization is in.
`note`|`string` | **Required**. A note to remind you what the OAuth token is for.
`note_url`|`string` | A URL to remind you what app the OAuth token is for.
`client_id`|`string` | The 20 character OAuth app client key for which to create the token.
`client_secret`|`string` | The 40 character OAuth app client secret for which to create the token.


<%= json :scopes => ["public_repo"], :note => 'admin script' %>

### Response

<%= headers 201, :Location => "https://api.github.com/authorizations/1"
%>
<%= json :oauth_access %>

## Get-or-create an authorization for a specific app

This method will create a new authorization for the specified OAuth application,
only if an authorization for that application doesn't already exist for the
user. (The URL includes the 20 character client ID for the OAuth app that is
requesting the token.) It returns the user's token for the application if one
exists. Otherwise, it creates one.

    PUT /authorizations/clients/:client_id

### Parameters

Name | Type | Description
-----|------|--------------
`client_secret`|`string`| **Required**. The 40 character OAuth app client secret associated with the client ID specified in the URL.
`scopes`|`array` | A list of scopes that this authorization is in.
`note`|`string` | A note to remind you what the OAuth token is for.
`note_url`|`string` | A URL to remind you what app the OAuth token is for.


<%= json :client_secret => "abcdabcdabcdabcdabcdabcdabcdabcdabcdabcd", :scopes => ["public_repo"], :note => 'admin script' %>

### Response if returning a new token

<%= headers 201, :Location => "https://api.github.com/authorizations/1"
%>
<%= json :oauth_access %>

### Response if returning an existing token

<%= headers 200, :Location => "https://api.github.com/authorizations/1"
%>
<%= json :oauth_access %>

## Update an existing authorization

    PATCH /authorizations/:id

### Parameters

Name | Type | Description
-----|------|--------------
`scopes`|`array` | Replaces the authorization scopes with these.
`add_scopes`|`array` | A list of scopes to add to this authorization.
`remove_scopes`|`array` | A list of scopes to remove from this authorization.
`note`|`string` | A note to remind you what the OAuth token is for.
`note_url`|`string` | A URL to remind you what app the OAuth token is for.


You can only send one of these scope keys at a time.

<%= json :add_scopes => ['repo'], :note => 'admin script' %>

### Response

<%= headers 200 %>
<%= json :oauth_access %>

## Delete an authorization

    DELETE /authorizations/:id

### Response

<%= headers 204 %>

## Check an authorization

OAuth applications can use a special API method for checking OAuth token
validity without running afoul of normal rate limits for failed login attempts.
Authentication works differently with this particular endpoint. You must use
[Basic Authentication](/v3/auth#basic-authentication) when accessing it, where the username is the OAuth
application `client_id` and the password is its `client_secret`. Invalid tokens
will return `404 NOT FOUND`.

    GET /applications/:client_id/tokens/:access_token

### Response

<%= headers 200 %>
<%= json(:oauth_access_with_user) %>

## Reset an authorization

OAuth applications can use this API method to reset a valid OAuth token without
end user involvement.  Applications must save the "token" property in the
response, because changes take effect immediately. You must use 
[Basic Authentication](/v3/auth#basic-authentication) when accessing it, where
the username is the OAuth application `client_id` and the password is its 
`client_secret`. Invalid tokens will return `404 NOT FOUND`.

    POST /applications/:client_id/tokens/:access_token

### Response

<%= headers 200 %>
<%= json(:oauth_access_with_user) %>

## Revoke all authorizations for an application

OAuth application owners can revoke every token for an OAuth application. You
must use [Basic Authentication](/v3/auth#basic-authentication) when calling
this method. The username is the OAuth application `client_id` and the password
is its `client_secret`. Tokens are revoked via a background job, and it might
take a few minutes for the process to complete.

    DELETE /applications/:client_id/tokens

### Response

<%= headers 204 %>

## Revoke an authorization for an application

OAuth application owners can also revoke a single token for an OAuth
application. You must use [Basic Authentication](/v3/auth#basic-authentication)
for this method, where the username is the OAuth application `client_id` and
  the password is its `client_secret`.

    DELETE /applications/:client_id/tokens/:access_token

### Response

<%= headers 204 %>

## More Information


It can be a little tricky to get started with OAuth. Here are a few
links that might be of help:

* [OAuth 2 spec](http://tools.ietf.org/html/rfc6749)
* [Facebook Login API](http://developers.facebook.com/docs/technical-guides/login/)
* [Ruby OAuth2 lib](https://github.com/intridea/oauth2)
* [Simple Ruby/Sinatra example](https://gist.github.com/9fd1a6199da0465ec87c)
* [Python Flask example](https://gist.github.com/ib-lundgren/6507798) using [requests-oauthlib](https://github.com/requests/requests-oauthlib)
* [Simple Python example](https://gist.github.com/e3fbd47fbb7ee3c626bb) using [python-oauth2](https://github.com/dgouldin/python-oauth2)
* [Ruby OmniAuth example](https://github.com/intridea/omniauth)
* [Ruby Sinatra extension](https://github.com/atmos/sinatra_auth_github)
* [Ruby Warden strategy](https://github.com/atmos/warden-github)

[app-listing]: https://github.com/settings/applications
[basics auth guide]: /guides/basics-of-authentication/
