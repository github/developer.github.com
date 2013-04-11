---
title: Getting Started | GitHub API
---

# Getting Started

* TOC
{:toc}

Let's walk through core API concepts as we tackle some everyday use
cases.

## Overview

Most applications will use an existing [wrapper library][wrappers] in the language 
of your choice, but it's important to familiarize yourself with the underlying API 
HTTP methods first. 

There's no easier way to kick the tires than through [cURL][curl].

### Hello World

Let's start by testing our setup. Open up a command prompt and paste the following code:

    curl https://api.github.com/zen

You should get a random response about one of our design philosophies:

    Keep it logically awesome.

Next, let's `GET` Chris Wanstrath's GitHub profile:

    # GET /users/defunkt
    curl https://api.github.com/users/defunkt

Mmmmm, tastes like JSON. Let's include the `-i` flag to include headers:

    curl -i https://api.github.com/users/defunkt

    HTTP/1.1 200 OK
    Server: GitHub.com
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

There are a few interesting bits in the response headers. As expected, the
`Content-Type` is `application/json`. 

Any headers beginning with `X-` are custom headers, and are not included in the 
HTTP spec. Let's take a look at a few of them:

* `X-GitHub-Media-Type` has a value of `github.beta`. This lets us know the [media type][media types] 
for the response. Media types have helped us version our output in API v3. We'll 
talk more about that later.
* Take note of the `X-RateLimit-Limit` and `X-RateLimit-Remaining` headers. This 
pair of headers indicate how many requests a client can make in a rolling hour 
and how many of those requests the client has already spent.

## Authentication

Unauthenticated clients can make 60 requests per hour. To get more, we'll need to
_authenticate_. In fact, doing anything interesting with the GitHub API requires
authentication.

### Basic

The easiest way to authenticate with the GitHub API is by simply using your GitHub 
username and password via Basic Authentication.

    curl -i -u <your_username> https://api.github.com/users/defunkt
    Enter host password for user '<your_username>':

The `-u` flag sets the username, and cURL will prompt you for the password. You
can use `-u "username:password"` to avoid the prompt, but this leaves your
password in shell history and isn't recommended. When authenticating, you
should see your rate limit bumped to 5,000 requests an hour, as indicated in the
`X-RateLimit-Limit` header.

In addition to just getting more calls per hour, authentication is the key to
reading and writing private information via the API.

### Get your own user profile

When properly authenticated, you can take advantage of the permissions
associated with your GitHub account. For example, try getting your own
user profile:

    curl -i -u <your_username> https://api.github.com/user

This time, in addition to the same set of public information we
retrieved for defunkt earlier, you should also see the non-public
information for your user profile. For example, you see a `plan` object
on the response:

    ...
    "plan": {
      "space": 2516582,
      "collaborators": 10,
      "private_repos": 20,
      "name": "medium"
    }
    ...


### OAuth

While convenient, Basic Authentication isn't ideal because you shouldn't give your GitHub
username and password to anyone. Applications that need to read or write
private information using the API on behalf of another user should use [OAuth][oauth].

Instead of usernames and passwords, OAuth uses _tokens_. Tokens provide two big
features:

* **Revokable access**: users can revoke authorization to third party apps at any time
* **Limited access**: users can review the specific access that a token
  will provide before authorizing a third party app

Normally, tokens are created via a [web flow][webflow]. An application
sends users to GitHub to log in. GitHub then presents a dialog
indicating the name of the app, as well as the level of access the app
has once it's authorized by the user. After a user authorizes access, GitHub
redirects the user back to the application:
![](/images/oauth_prompt.png)

You don't need to set up the entire web flow to begin working with OAuth tokens. 
The [Authorizations API][authorizations api] makes it simple to use Basic Authentication
to create an OAuth token. Try pasting and running the following command:

    curl -i -u <your_username> \
         -d '{"scopes": ["repo"]}' \
         https://api.github.com/authorizations

You should see output similar to this:

    HTTP/1.1 201 Created
    Server: nginx/1.0.14
    Date: Wed, 14 Nov 2012 14:04:24 GMT
    Content-Type: application/json; charset=utf-8
    Connection: keep-alive
    Status: 201 Created
    Cache-Control: max-age=0, private, must-revalidate
    X-Content-Type-Options: nosniff
    ETag: "f6a0ce8bac4559f2a578afd9dad51f95"
    X-GitHub-Media-Type: github.beta
    Location: https://api.github.com/authorizations/2
    Content-Length: 384

    {
      "scopes": [
        "repo"
      ],
      "token": "5199831f4dd3b79e7c5b7e0ebe75d67aa66e79d4",
      "updated_at": "2012-11-14T14:04:24Z",
      "url": "https://api.github.com/authorizations/2",
      "app": {
        "url": "http://developer.github.com/v3/oauth/#oauth-authorizations-api",
        "name": "GitHub API"
      },
      "created_at": "2012-11-14T14:04:24Z",
      "note_url": null,
      "id": 2,
      "note": null
    }

There's a lot going on in this one little call, so let's break it down. First,
the `-d` flag indicates we're doing a `POST`, using the
`application/x-www-form-urlencoded` content type (as opposed to `GET`). All `POST`
requests to the GitHub API should be in JSON.

Next, let's look at the `scopes` we're sending over in this call. When creating
a new token, we include an optional array of [_scopes_][scopes], or access
levels, that indicate what information this token can access. In this case,
we're setting up the token with _repo_ access, the most permissive scope in the
GitHub API, allowing access to read and write to private repositories. See [the
scopes docs][scopes] for a full list of scopes. You should **only** request
scopes that your application actually needs, in order to not frighten users with
potentially invasive actions.

The `201` status code tells us that the call was successful, and the JSON returned
contains the details of our new OAuth token. Now, we can use the forty character
`token` instead of a username and password in the rest of our examples. Let's
grab our own user info again, using OAuth this time:

    curl -i -H 'Authorization: token 5199831f4dd3b79e7c5b7e0ebe75d67aa66e79d4' \
        https://api.github.com/user

**Treat OAuth tokens like passwords!** Don't share them with other users or store 
them in insecure places. The tokens in these examples are fake and the names have 
been changed to protect the innocent.

Now that we've got the hang of making authenticated calls, let's move along to
the [Repositories API][repos-api].

## Repositories

Most any meaningful use of the GitHub API will involve some level of Repository
information. We can `GET` repository details in the same way we fetched user
details earlier:

      curl -i https://api.github.com/repos/twitter/bootstrap

In the same way, we can view repositories for the authenticated user:

    curl -i -H 'Authorization: token 5199831f4dd3b79e7c5b7e0ebe75d67aa66e79d4' \
        https://api.github.com/user/repos

Or, we can list repositories for another user:

    curl -i https://api.github.com/users/technoweenie/repos

Or, we can list repositories for an organization:

    curl -i https://api.github.com/orgs/github/repos

The information returned from these calls will depend on how we authenticate:

* Using Basic Authentication, the response includes all repositories the
  the user has access to see on github.com.
* Using OAuth, private repositories are only returned if the OAuth token
  contains the `repo` [scope][scopes].

As the [docs][repos-api] indicate, these methods take a `type` parameter that
can filter the repositories returned based on what type of access the user has
for the repository. In this way, we can fetch only directly-owned repositories, 
organization repositories, or repositories the user collaborates on via a team.

    curl -i "https://api.github.com/users/technoweenie/repos?type=owner"

In this example, we grab only those repositories that technoweenie owns, not the
ones on which he collaborates. Note the quoted URL above. Depending on your
shell setup, cURL sometimes requires a quoted URL or else it ignores the
querystring.

### Create a repository

Fetching information for existing repositories is a common use case, but the
GitHub API supports creating new repositories as well. To create a repository,
we need to `POST` some JSON containing the details and configuration options.

    curl -i -H 'Authorization: token 5199831f4dd3b79e7c5b7e0ebe75d67aa66e79d4' \
         -d '{ \
              "name": "blog", \
              "auto_init": true, \
              "private": true, \
              "gitignore_template": "nanoc" \
            }' \
          https://api.github.com/user/repos

In this minimal example, we create a new repository for our blog (to be served
on [GitHub Pages][pages], perhaps). Though the blog will be public, we've made
the repository private. In this single step, we'll also initialize it with
a README and a [nanoc][nanoc]-flavored [.gitignore template][gitignore
templates].

The resulting repository will be found at `https://github.com/<your
username>/blog`. To create a repository under an organization for which you're
an owner, just change the API method from `/user/repos` to `/orgs/<org
name>/repos`.

Next, let's fetch our newly created repository:

    curl -i https://api.github.com/pengwynn/blog

    HTTP/1.1 404 Not Found

    {
        "message": "Not Found"
    }

Oh noes! Where did it go? Since we created the repository as _private_, we need
to authenticate in order to see it. If you're a grizzled HTTP user, you might
expect a `403` instead. Since we don't want to leak information about private
repositories, the GitHub API returns a `404` in this case, as if to say "we can
neither confirm nor deny the existence of this repository."

## Issues

The UI for Issues on GitHub aims to provide 'just enough' workflow while
staying out of your way. With the GitHub [Issues API][issues-api], you can pull
data out or create issues from other tools to create a workflow that works for
your team.

Just like github.com, the API provides a few methods to view issues for the
authenticated user. To see all your issues, call `GET /issues`:

    curl -i -H 'Authorization: token 5199831f4dd3b79e7c5b7e0ebe75d67aa66e79d4' \
         https://api.github.com/issues

To get only the issues under one of your GitHub organizations, call `GET
/orgs/<org>/issues`:

    curl -i -H 'Authorization: token 5199831f4dd3b79e7c5b7e0ebe75d67aa66e79d4' \
         https://api.github.com/orgs/rails/issues

We can also get all the issues under a single repository:

    curl -i https://api.github.com/repos/rails/rails/issues

### Pagination

A project the size of Rails has thousands of issues. We'll need to paginate,
making multiple API calls to get the data. Let's repeat that last call, this
time taking note of the response headers:

    curl -i https://api.github.com/repos/rails/rails/issues

    HTTP/1.1 200 OK

    Link: <https://api.github.com/repos/rails/rails/issues?page=2>; rel="next",
    <https://api.github.com/repos/rails/rails/issues?page=14>; rel="last"

The [`Link` header][link-header] provides a way for a response to link to
external resources, in this case additional pages of data. Since our call found
more than thirty issues (the default page size), the API tells us where we can
find the next page and the last page of results.

### Creating an issue

Now that we've seen how to paginate lists of issues, let's create an issue from
the API.

    curl -i -H 'Authorization: token 5199831f4dd3b79e7c5b7e0ebe75d67aa66e79d4' \
         -d '{ \
               "title": "New logo", \
               "body": "We should have one", \
               "labels": ["design"] \
             }' \
         https://api.github.com/repos/pengwynn/api-sandbox/issues

To create an issue, we need to be authenticated, so we pass an
OAuth token in the header. We pass the title, body, and labels in the JSON
body to the `/issues` path underneath the repository in which we want to create
the issue.

    HTTP/1.1 201 Created
    Location: https://api.github.com/repos/pengwynn/api-sandbox/issues/17
    X-RateLimit-Limit: 5000

    {
      "pull_request": {
        "patch_url": null,
        "html_url": null,
        "diff_url": null
      },
      "created_at": "2012-11-14T15:25:33Z",
      "comments": 0,
      "milestone": null,
      "title": "New logo",
      "body": "We should have one",
      "user": {
        "login": "pengwynn",
        "gravatar_id": "7e19cd5486b5d6dc1ef90e671ba52ae0",
        "avatar_url": "https://secure.gravatar.com/avatar/7e19cd5486b5d6dc1ef90e671ba52ae0?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
        "id": 865,
        "url": "https://api.github.com/users/pengwynn"
      },
      "closed_at": null,
      "updated_at": "2012-11-14T15:25:33Z",
      "number": 17,
      "closed_by": null,
      "html_url": "https://github.com/pengwynn/api-sandbox/issues/17",
      "labels": [
        {
          "color": "ededed",
          "name": "design",
          "url": "https://api.github.com/repos/pengwynn/api-sandbox/labels/design"
        }
      ],
      "id": 8356941,
      "assignee": null,
      "state": "open",
      "url": "https://api.github.com/repos/pengwynn/api-sandbox/issues/17"
    }

The response gives us a couple of pointers to the newly created issue, both in
the `Location` response header and the `url` field of the JSON response.

### Convert an issue to a Pull Request

GitHub moves fast and the API tries to keep pace, but there are some things you
can do with the API that you can't do on github.com. Using the API, you can
turn an issue into a Pull Request.

But at this point, we'll need to create a branch called `new-feature`
with at least one commit so it's ahead of the `master` branch:

    git clone https://github.com/repos/github/platform-sandbox
    git checkout -b new-feature
    touch cool-feature.rb
    git add cool-feature.rb
    git commit -m "Add new feature."
    git push origin new-feature

Now let's convert the issue we created in the previous section:

    curl -i -H 'Authorization: token 5199831f4dd3b79e7c5b7e0ebe75d67aa66e79d4' \
         -d '{ \
               "issue": 17, \
               "head": "new-feature", \
               "base": "master" \
             }' \
         https://api.github.com/repos/pengwynn/api-sandbox/pulls

Using this shorthand, the details for the pull request title and body are taken
from the issue we provide.

## Conditional requests

A big part of being a good API citizen is respecting rate limits by
caching information that hasn't changed. The API supports [conditional
requests][conditional-requests] and helps you do the right thing. Consider the
first call we made to get defunkt's profile:

    curl -i https://api.github.com/users/defunkt

In addition to the JSON body, take note of the HTTP status code of `200` and
the `ETag` header:

    HTTP/1.1 200 OK
    ETag: "bfd85cbf23ac0b0c8a29bee02e7117c6"

The ETag is a fingerprint of the response. If we pass that on subsequent calls,
we can tell the API to give us the resource again, only if it has changed:

    curl -i -H 'If-None-Match: "644b5b0155e6404a9cc4bd9d8b1ae730"' \
         https://api.github.com/users/defunkt

    HTTP/1.1 304 OK

The `304` status indicates that the resource hasn't changed since the last time
we asked for it and the response will contain no body. As a bonus, `304`
responses don't count against your [rate limit][rate-limiting].



[wrappers]: http://developer.github.com/v3/libraries/
[curl]: http://curl.haxx.se/
[media types]: http://developer.github.com/v3/media/
[oauth]: http://developer.github.com/v3/oauth/
[webflow]: http://developer.github.com/v3/oauth/#web-application-flow
[authorizations api]: http://developer.github.com/v3/oauth/#oauth-authorizations-api
[scopes]: http://developer.github.com/v3/oauth/#scopes
[repos-api]: http://developer.github.com/v3/repos/
[pages]: http://pages.github.com
[nanoc]: http://nanoc.stoneship.org/
[gitignore templates]: https://github.com/github/gitignore
[issues-api]: http://developer.github.com/v3/issues/
[link-header]: http://www.w3.org/wiki/LinkHeader
[conditional-requests]: http://developer.github.com/v3/#conditional-requests
[rate-limiting]: http://developer.github.com/v3/#rate-limiting
