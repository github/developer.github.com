---
title: OAuth | GitHub API
---

# OAuth

* TOC
{:toc}

OAuth2 is a protocol that lets external apps request authorization to
private details in a user's GitHub account without getting their
password. This is preferred over [Basic Authentication](/v3/auth#basic-authentication) because tokens can
be limited to specific types of data, and can be revoked by users at any
time.

All developers need to [register their
application](https://github.com/settings/applications/new) before getting
started. A registered OAuth application is assigned a unique Client ID
and Client Secret. The Client Secret should not be shared.

## Web Application Flow

This is a description of the OAuth2 flow from 3rd party web sites.

### 1. Redirect users to request GitHub access

    GET https://github.com/login/oauth/authorize

### Parameters

Name | Type | Description
-----|------|--------------
`client_id`|`string` | **Required**. The client ID you received from GitHub when you [registered](https://github.com/settings/applications/new).
`redirect_uri`|`string` | The URL in your app where users will be sent after authorization. See details below about [redirect urls](#redirect-urls).
`scope`|`string` | A comma separated list of [scopes](#scopes). If not provided, `scope` defaults to an empty list of scopes for users that don't have a valid token for the app. For users who do already have a valid token for the app, the user won't be shown the OAuth authorization page with the list of scopes. Instead, this step of the flow will automatically complete with the same scopes that were used last time the user completed the flow.
`state`|`string` | An unguessable random string. It is used to protect against cross-site request forgery attacks.

### 2. GitHub redirects back to your site

If the user accepts your request, GitHub redirects back to your site
with a temporary code in a `code` parameter as well as the state you provided in
the previous step in a `state` parameter. If the states don't match, the request
has been created by a third party and the process should be aborted.

Exchange this for an access token:

    POST https://github.com/login/oauth/access_token

### Parameters

Name | Type | Description
-----|------|---------------
`client_id`|`string` | **Required**. The client ID you received from GitHub when you [registered](https://github.com/settings/applications/new).
`client_secret`|`string` | **Required**. The client secret you received from GitHub when you [registered](https://github.com/settings/applications/new).
`code`|`string` | **Required**. The code you received as a response to [Step 1](#redirect-users-to-request-github-access).
`redirect_uri`|`string` | The URL in your app where users will be sent after authorization. See details below about [redirect urls](#redirect-urls).

### Response

By default, the response will take the following form:

    access_token=e72e16c7e42f292c6912e7710c838347ae178b4a&scope=user%2Cgist&token_type=bearer

You can also receive the content in different formats depending on the Accept
header:

    Accept: application/json
    {"access_token":"e72e16c7e42f292c6912e7710c838347ae178b4a", "scope":"repo,gist", "token_type":"bearer"}

    Accept: application/xml
    <OAuth>
      <token_type>bearer</token_type>
      <scope>repo,gist</scope>
      <access_token>e72e16c7e42f292c6912e7710c838347ae178b4a</access_token>
    </OAuth>


#### Requested scopes vs. granted scopes

The `scope` attribute lists scopes attached to the token that were granted by
the user. Normally, these scopes will be identical to what you requested.
However, users [will soon be able to edit their scopes][oauth changes blog], effectively
granting your application less access than you originally requested. Also, users
will also be able to edit token scopes after the OAuth flow completed.
You should be aware of this possibility and adjust your application's behavior
accordingly.

It is important to handle error cases where a user chooses to grant you
less access than you originally requested. For example, applications can warn
or otherwise communicate with their users that they will see reduced
functionality or be unable to perform some actions.

Also, applications can always send users back through the flow again to get
additional permission, but don’t forget that users can always say no.

Check out the [Basics of Authentication guide][basics auth guide] which
provides tips on handling modifiable token scopes.

### 3. Use the access token to access the API

The access token allows you to make requests to the API on a behalf of a user.

    GET https://api.github.com/user?access_token=...

## Non-Web Application Flow

Use [Basic Authentication](/v3/auth#basic-authentication) to create an OAuth2
token using the [interface below](/v3/oauth/#create-a-new-authorization).  With
this technique, a username and password need not be stored permanently, and the
user can revoke access at any time. (Make sure to understand how to [work with
two-factor authentication](/v3/auth/#working-with-two-factor-authentication) if
you or your users have two-factor authentication enabled.)

## Redirect URLs

The `redirect_uri` parameter is optional. If left out, GitHub will
redirect users to the callback URL configured in the OAuth Application
settings. If provided, the redirect URL's host and port must exactly
match the callback URL. The redirect URL's path must reference a
subdirectory of the callback URL.

    CALLBACK: http://example.com/path

    GOOD: https://example.com/path
    GOOD: http://example.com/path/subdir/other
    BAD:  http://example.com/bar
    BAD:  http://example.com/
    BAD:  http://example.com:8080/path
    BAD:  http://oauth.example.com:8080/path
    BAD:  http://example.org

## Scopes

Scopes let you specify exactly what type of access you need. Scopes _limit_
access for OAuth tokens. They do not grant any additional permission beyond
that which the user already has.

For the web flow, requested scopes will be displayed to the user on the
authorize form.

Check headers to see what OAuth scopes you have, and what the API action
accepts.

    $ curl -H "Authorization: token OAUTH-TOKEN" https://api.github.com/users/technoweenie -I
    HTTP/1.1 200 OK
    X-OAuth-Scopes: repo, user
    X-Accepted-OAuth-Scopes: user

`X-OAuth-Scopes` lists the scopes your token has authorized.
`X-Accepted-OAuth-Scopes` lists the scopes that the action checks for.


Name | Description
-----|-----------|
`(no scope)`| Public read-only access (includes public user profile info, public repo info, and gists)
`user` |Read/write access to profile info only.  Note: this scope includes `user:email` and `user:follow`.
`user:email`| Read access to a user's email addresses.
`user:follow`| Access to follow or unfollow other users.
`public_repo`| Read/write access to public repos and organizations.
`repo`| Read/write access to public and private repos and organizations.
`repo:status`| Read/write access to public and private repository commit statuses. This scope is only necessary to grant other users or services access to private repository commit statuses without granting access to the code. The `repo` and `public_repo` scopes already include access to commit status for private and public repositories, respectively.
`delete_repo`| Delete access to adminable repositories.
`notifications`| Read access to a user's notifications.  `repo` is accepted too.
`gist`| Write access to gists.

NOTE: Your application can request the scopes in the initial redirection. You
can specify multiple scopes by separating them with a comma:

    https://github.com/login/oauth/authorize?
      client_id=...&
      scope=user,public_repo

## OAuth Authorizations API

There is an API for users to manage their own tokens.  You can only access your
own tokens, and only via [Basic Authentication](/v3/auth#basic-authentication).
(Make sure to understand how to [work with two-factor
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

If you need a small number of tokens, implementing the [web flow](#web-application-flow)
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
`note`|`string` | A note to remind you what the OAuth token is for.
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
`client_secret`|`string`| The 40 character OAuth app client secret associated with the client ID specified in the URL.
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
[oauth changes blog]: /changes/2013-10-04-oauth-changes-coming/
[basics auth guide]: /guides/basics-of-authentication/
