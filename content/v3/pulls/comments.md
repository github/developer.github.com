---
title: Pull Request Comments | GitHub API
---

# Pull Request Review Comments API

* TOC
{:toc}

Pull Request Review Comments are comments on a portion of the unified
diff.  These are separate from Commit Comments (which are applied
directly to a commit, outside of the Pull Request view), and Issue
Comments (which do not reference a portion of the unified diff).

Pull Request Review Comments use [these custom media
types](#custom-media-types). You can read more about the use of media types in the API
[here](/v3/media/).

## List comments on a pull request

    GET /repos/:owner/:repo/pulls/:number/comments

### Response

<%= headers 200 %>
<%= json(:pull_comment) { |h| [h] } %>

## List comments in a repository

    GET /repos/:owner/:repo/pulls/comments

By default, Review Comments are ordered by ascending ID.

### Parameters

sort
: _Optional_ **String** `created` or `updated`

direction
: _Optional_ **String** `asc` or `desc`. Ignored without `sort` parameter.

since
: _Optional_ **String** of a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ

### Response

<%= headers 200 %>
<%= json(:pull_comment) { |h| [h] } %>

## Get a single comment

    GET /repos/:owner/:repo/pulls/comments/:number

### Response

<%= headers 200 %>
<%= json :pull_comment %>

## Create a comment

    POST /repos/:owner/:repo/pulls/:number/comments

### Input

body
: _Required_ **string**

commit_id
: _Required_ **string** - Sha of the commit to comment on.

path
: _Required_ **string** - Relative path of the file to comment on.

position
: _Required_ **number** - Line index in the diff to comment on.

#### Example

<%= json \
  :body      => 'Nice change',
  :commit_id => '6dcb09b5b57875f334f61aebed695e2e4193db5e',
  :path      => 'file1.txt',
  :position  => 4
%>

### Alternative Input

Instead of passing `commit_id`, `path`, and `position` you can reply to
an existing Pull Request Comment like this:

body
: _Required_ **string**

in_reply_to
: _Required_ **number** - Comment id to reply to.

#### Example

<%= json \
  :body        => 'Nice change',
  :in_reply_to => 4
%>

### Response

<%= headers 201,
      :Location =>
"https://api.github.com/repos/:owner/:repo/pulls/comments/1" %>
<%= json :pull_comment %>

## Edit a comment

    PATCH /repos/:owner/:repo/pulls/comments/:number

### Input

body
: _Required_ **string**

#### Example

<%= json \
  :body => 'Nice change'
%>

### Response

<%= headers 200 %>
<%= json :pull_comment %>

## Delete a comment

    DELETE /repos/:owner/:repo/pulls/comments/:number

### Response

<%= headers 204 %>

