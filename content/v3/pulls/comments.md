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

Name | Type | Description | Required? | Default
-----|------|--------------|----------|---------
`sort`|`string` | Can be either `created` or `updated`| |
`direction`|`string` | Can be either `asc` or `desc`. Ignored without `sort` parameter.| |
`since`|`string` | A timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`. Only comments updated at or after this time are returned.| |


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

Name | Type | Description | Required? | Default
-----|------|--------------|----------|---------
`body`|`string` | The text of the comment|**YES**|
`commit_id`|`string` | The SHA of the commit to comment on.|**YES**|
`path`|`string` | The relative path of the file to comment on.|**YES**|
`position`|`number` | The line index in the diff to comment on.|**YES**|


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

Name | Type | Description | Required? | Default
-----|------|--------------|----------|---------
`body`|`string` | The text of the comment|**YES**|
`in_reply_to`|`number` | The comment id to reply to.|**YES**|


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

Name | Type | Description | Required? | Default
-----|------|--------------|----------|---------
`body`|`string` | The text of the comment|**YES**|


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
