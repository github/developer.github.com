---
title: Review Comments | GitHub API
---

# Review Comments

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

Name | Type | Description
-----|------|--------------
`sort`|`string` | Can be either `created` or `updated`. Default: `created`
`direction`|`string` | Can be either `asc` or `desc`. Ignored without `sort` parameter.
`since`|`string` | Only comments updated at or after this time are returned. This is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.


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

Name | Type | Description
-----|------|--------------
`body`|`string` | **Required**. The text of the comment
`commit_id`|`string` | **Required**. The SHA of the commit to comment on.
`path`|`string` | **Required**. The relative path of the file to comment on.
`position`|`number` | **Required**. The line index in the diff to comment on.


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

Name | Type | Description
-----|------|--------------
`body`|`string` | **Required**. The text of the comment
`in_reply_to`|`number` | **Required**. The comment id to reply to.


#### Example

<%= json \
  :body        => 'Nice change',
  :in_reply_to => 4
%>

### Response

<%= headers 201,
      :Location =>
"https://api.github.com/repos/octocat/Hello-World/pulls/comments/1" %>
<%= json :pull_comment %>

## Edit a comment

    PATCH /repos/:owner/:repo/pulls/comments/:number

### Input

Name | Type | Description
-----|------|--------------
`body`|`string` | **Required**. The text of the comment


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

## Custom media types

These are the supported media types for pull request review comments. You can
read more about the use of media types in the API [here](/v3/media/).

    application/vnd.github.VERSION.raw+json
    application/vnd.github.VERSION.text+json
    application/vnd.github.VERSION.html+json
    application/vnd.github.VERSION.full+json
