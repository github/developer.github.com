---
title: User Emails | GitHub API
---

# User Emails API

* TOC
{:toc}

Management of email addresses via the API requires that you are
authenticated through basic auth or OAuth with the user scope.

## List email addresses for a user

    GET /user/emails

This endpoint is accessible with the user:email scope.

### Response

<div class="alert">
  <p>
    <strong>Deprecated</strong>: This response format is deprecated.
    The API will remove support for this response format in the future.
  </p>
  <p>
    We recommend that you start requesting the new response format as described
    in the <a href="#future-response">Future Response</a> section below.
  </p>
</div>

<%= headers 200 %>
<%= json ["octocat@github.com", "support@github.com"] %>
<br>

#### Future Response

In the final version of the API, this method will return an array of hashes
with extended information for each email address indicating if the address has
been verified and if it's the user's primary email address for GitHub.

Until API v3 is finalized, use the `application/vnd.github.v3`
[media type][media-types] to get this response format.

<%= headers 200 %>
<%= json(:user_email) {|e| [e]} %>

## Add email address(es)

    POST /user/emails

### Input

You can post a single email address or an array of addresses:

<%= json ["octocat@github.com", "support@github.com"] %>

### Response

<%= headers 201 %>
<%= json ["octocat@github.com", "support@github.com"] %>

## Delete email address(es)

    DELETE /user/emails

### Input

You can include a single email address or an array of addresses:

<%= json ["octocat@github.com", "support@github.com"] %>

### Response

<%= headers 204 %>


[media-types]: /v3/media
