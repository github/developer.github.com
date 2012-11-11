# Getting Started

Let's walk through core API concepts as we tackle some everyday use
cases.

## Overview

Most applications will use a [wrapper library][wrappers], but it's important to
get familiar with the underlying API HTTP methods. There's no easier way to
kick the tires than [cURL][curl].

### Hello World

Let start by `GET`ting Chris Wanstrath's GitHub profile:

    # GET /users/defunkt
    curl https://api.github.com/users/defunkt

Mmmmm tastes like JSON. Let's include the `-i` flag to include headers:

    curl -i https://api.github.com/users/defunkt

    HTTP/1.1 200 OK
    Server: nginx
    Date: Sun, 11 Nov 2012 18:43:28 GMT
    Content-Type: application/json; charset=utf-8
    Connection: keep-alive
    Status: 200 OK
    ETag: "bfd85cbf23ac0b0c8a29bee02e7117c6"
    X-RateLimit-Remaining: 57
    X-GitHub-Media-Type: github.beta
    Vary: Accept
    X-RateLimit-Limit: 60
    Cache-Control: public, max-age=60, s-maxage=60
    X-Content-Type-Options: nosniff
    Content-Length: 692
    Last-Modified: Tue, 30 Oct 2012 18:58:42 GMT

There's a few interesting bits in the response headers. As we expected, the
`Content-Type` is `application/json`. Note the `X-GitHub-Media-Type` value of
`github.beta`. This lets us know the [media type][media types] for the
response. Media types have helped us version our output in API v3. More on that
later.

Take note of the `X-RateLimit-Limit` and `X-RateLimit-Remaining` headers. (Any
headers beginning with `X-` are custom headers and are not included in the HTTP
spec). This pair of headers indicate how many requests a client can make in a
rolling hour and how many of those requests it has already spent.

## Authentication

Unauthenticated clients can make 60 calls per hour. To get more, we need to
_authenticate_.

### Basic

The easiest way to authenticate with the GitHub API is using your GitHub
username and password via Basic Authentication.

    curl -i -u tlberglund https://api.github.com/users/defunkt
    Enter host password for user 'tlberglund':

The `-u` flag sets the username and cURL will prompt us for the password. You
can use `-u "username:password"` to avoid the prompt, but this leaves your
password in shell history and isn't recommended. When authenticating, you
should see your rate limit bumped to 5000 requests an hour as indicated in the
`X-RateLimit-Limit` header.

In addition to just getting more calls per hour, authentication is the key to
reading and writing private information via the API.

### Get your own user profile

When properly authenticated, you can grab your own user profile:

    curl -i -u pengwynn https://api.github.com/user

This time, in addition to the same set of information we retrieved for @defunkt
earlier, you should see a `plan` object on the response:

    ...
    "plan": {
      "space": 2516582,
      "collaborators": 10,
      "private_repos": 20,
      "name": "medium"
    },
    "login": "pengwynn"
    ...


### OAuth

While convenient, Basic Auth isn't ideal because you shouldn't give your GitHub
username and password to anyone. Applications that need to read or write
private information using the API on behalf of another user should use [OAuth][oauth]. 

Instead of usernames and passwords, OAuth uses _tokens_. Tokens provide two big
features:

* **Revokable access**. Users can revoke authorization to third party apps.
* **Limited access**. Users can specify what access a token provides when they
authorize a third party app.

Normally, tokens are created via a [web flow][webflow], where third party
applications send users to GitHub to log in and authorize their application and
GitHub redirects the user back to the third party application. You don't need
to set up the entire web flow to begin working with OAuth tokens. The [Authorizations API][authorizations api] 
makes it simple to use Basic Auth to create an OAuth token.

    curl -i -u pengwynn \
            -d '{"scopes": ["repo"]}' \
            https://api.github.com/authorizations

There's a lot going on in this one little call, so let's break it down. First,
the `-d` flag indicates we're doing a `POST`, using the
`application/x-www-form-urlencoded` content type. All `POST` requests to the
GitHub API should be JSON, as we're sending in this case.

Next, let's look at the `scopes` we're sending over in this call. When creating
a new token, we include an optional array of [_scopes_][scopes], or access
levels, that indicate what information this token can access. In this case,
we're setting up the token with _repo_ access, the most permissive scope in the
GitHub API, allowing access to read and write to private repositories. See [the
docs][scopes] for a full list of scopes.

## Repositories

## Commits

### Paginate

## Star a repo

## Follow a user

## Conditional requests

## JSON-P



[wrappers]: http://developer.github.com/v3/libraries/
[curl]: http://curl.haxx.se/
[media types]: http://developer.github.com/v3/media/
[oauth]: http://developer.github.com/v3/oauth/
[webflow]: http://developer.github.com/v3/oauth/#web-application-flow
[authorizations api]: http://developer.github.com/v3/oauth/#oauth-authorizations-api
[scopes]: http://developer.github.com/v3/oauth/#scopes
