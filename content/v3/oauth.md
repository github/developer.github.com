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

#### Normalized scopes

When requesting multiple scopes, the token will be saved with a normalized list
of scopes, discarding those that are implicitly included by another requested
scope. For example, requesting `user,gist,user:email` will result in a
token with `user` and `gist` scopes only since the access granted with
`user:email` scope [is included](#scopes) in the `user` scope.

### 3. Use the access token to access the API

The access token allows you to make requests to the API on a behalf of a user.

    GET https://api.github.com/user?access_token=...

You can pass the token in the query params like shown above, but a
cleaner approach is to include it in the Authorization header

    Authorization: token OAUTH-TOKEN

For example, in curl you can set the Authorization header like this:

    curl -H "Authorization: token OAUTH-TOKEN" https://api.github.com/user

## Non-Web Application Flow

Use [Basic Authentication](/v3/auth#basic-authentication) to create an OAuth2
token using the [interface below](/v3/oauth_authorizations/#create-a-new-authorization).  With
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

    GOOD: http://example.com/path
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
`(no scope)`| Grants read-only access to public information (includes public user profile info, public repository info, and gists)
`user` | Grants read/write access to profile info only.  Note that this scope includes `user:email` and `user:follow`.
`user:email`| Grants read access to a user's email addresses.
`user:follow`| Grants access to follow or unfollow other users.
`public_repo`| Grants read/write access to code, commit statuses, and deployment statuses for public repositories and organizations.
`repo`| Grants read/write access to code, commit statuses, and deployment statuses for public and private repositories and organizations.
`repo_deployment`| Grants access to [deployment statuses][deployments] for public and private repositories. This scope is only necessary to grant other users or services access to deployment statuses, *without* granting access to the code.
`repo:status`| Grants read/write access to public and private repository commit statuses. This scope is only necessary to grant other users or services access to private repository commit statuses *without* granting access to the code.
`delete_repo`| Grants access to delete adminable repositories.
`notifications`| Grants read access to a user's notifications. `repo` also provides this access.
`gist`| Grants write access to gists.
`read:repo_hook`| Grants read and ping access to hooks in public or private repositories.
`write:repo_hook`| Grants read, write, and ping access to hooks in public or private repositories.
`admin:repo_hook`| Grants read, write, ping, and delete access to hooks in public or private repositories.
`read:org`| Read-only access to organization, teams, and membership.
`write:org`| Publicize and unpublicize organization membership.
`admin:org`| Fully manage organization, teams, and memberships.
`read:public_key`| List and view details for public keys.
`write:public_key`| Create, list, and view details for public keys.
`admin:public_key`| Fully manage public keys.

NOTE: Your application can request the scopes in the initial redirection. You
can specify multiple scopes by separating them with a comma:

    https://github.com/login/oauth/authorize?
      client_id=...&
      scope=user,public_repo

## Common errors for the authorization request

There are a few things that can go wrong in the process of obtaining an
OAuth token for a user. In the initial authorization request phase,
these are some errors you might see:

### Application Suspended

If the OAuth application you set up has been suspended (due to reported
abuse, spam, or a mis-use of the API), GitHub will redirect to the
registered callback URL with the following parameters summarizing the
error:

    http://your-application.com/callback?error=application_suspended
      &error_description=Your+application+has+been+suspended.+Contact+support@github.com.
      &error_uri=https://developer.github.com/v3/oauth/%23application-suspended
      &state=xyz

Please contact [support](https://github.com/contact) to solve issues
with suspended applications.

### Redirect URI mismatch

If you provide a redirect_uri that doesn't match what you've registered
with your application, GitHub will redirect to the registered callback
URL with the following parameters summarizing the error:

    http://your-application.com/callback?error=redirect_uri_mismatch
      &error_description=The+redirect_uri+MUST+match+the+registered+callback+URL+for+this+application.
      &error_uri=https://developer.github.com/v3/oauth/%23redirect-uri-mismatch
      &state=xyz

To correct this error, either provide a redirect_uri that matches what
you registered or leave out this parameter to use the default one
registered with your application.

### Access denied

If the user rejects access to your application, GItHub will redirect to
the registered callback URL with the following parameters summarizing
the error:

    http://your-application.com/callback?error=access_denied
      &error_description=The+user+has+denied+your+application+access.
      &error_uri=https://developer.github.com/v3/oauth/%23access-denied
      &state=xyz

There's nothing you can do here as users are free to choose not to use
your application. More often than not, users will just close the window
or press back in their browser, so it is likely that you'll never see
this error.

## Common errors for the access token request

In the second phase of exchanging a code for an access token, there are
an additional set of errors that can occur. The format of these
responses is determined by the accept header you pass. The following
examples only show JSON responses.

### Incorrect client credentials

If the client\_id and or client\_secret you pass are incorrect you will
receive this error response.

<%= json :error             => :incorrect_client_credentials,
         :error_description => "The client_id and/or client_secret passed are incorrect.",
         :error_uri         => "https://developer.github.com/v3/oauth/#incorrect-client-credentials"
%>

To solve this error, go back and make sure you have the correct
credentials for your oauth application. Double check the `client_id` and
`client_secret` to make sure they are correct and being passed correctly
to GitHub.

### Redirect URI mismatch(2)

If you provide a redirect_uri that doesn't match what you've registered
with your application, you will receive this error message:

<%= json :error             => :redirect_uri_mismatch,
         :error_description => "The redirect_uri MUST match the registered callback URL for this application.",
         :error_uri         => "https://developer.github.com/v3/oauth/#redirect-uri-mismatch(2)"
%>

To correct this error, either provide a redirect_uri that matches what
you registered or leave out this parameter to use the default one
registered with your application.

### Bad verification code

<%= json :add_scopes => ['repo'], :note => 'admin script' %>

If the verification code you pass is incorrect, expired, or doesn't
match what you received in the first request for authorization you will
receive this error.

<%= json :error             => :bad_verification_code,
         :error_description => "The code passed is incorrect or expired.",
         :error_uri         => "https://developer.github.com/v3/oauth/#bad-verification-code"
%>

To solve this error, start the [OAuth process over from the beginning](#redirect-users-to-request-github-access)
and get a new code.

[oauth changes blog]: /changes/2013-10-04-oauth-changes-coming/
[basics auth guide]: /guides/basics-of-authentication/
[deployments]: /v3/repos/deployments
[public keys]: /v3/users/keys/
