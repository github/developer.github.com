---
title: Issue Comments | GitHub API
---

# Comments

* TOC
{:toc}

The Issue Comments API supports listing, viewing, editing, and creating
comments on issues and pull requests.

Issue Comments use [these custom media types](#custom-media-types).
You can read more about the use of media types in the API
[here](/v3/media/).

## List comments on an issue

    GET /repos/:owner/:repo/issues/:number/comments

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:issue_comment) { |h| [h] } %>

## List comments in a repository

    GET /repos/:owner/:repo/issues/comments

By default, Issue Comments are ordered by ascending ID.

### Parameters

Name | Type | Description 
-----|------|--------------
`sort`|`string` | Either `created` or `updated`. Default: `created`
`direction`|`string` | Either `asc` or `desc`. Ignored without the `sort` parameter.
`since`|`string` | Only comments updated at or after this time are returned. This is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`.


### Response

<%= headers 200 %>
<%= json(:pull_comment) { |h| [h] } %>

## Get a single comment

    GET /repos/:owner/:repo/issues/comments/:id

### Response

<%= headers 200 %>
<%= json :issue_comment %>

## Create a comment

    POST /repos/:owner/:repo/issues/:number/comments

### Input

Name | Type | Description
-----|------|--------------
`body`|`string` | **Required**. The contents of the comment.


<%= json :body => "a new comment" %>

### Response

<%= headers 201,
      :Location =>
"https://api.github.com/repos/user/repo/issues/comments/1" %>
<%= json :issue_comment %>

## Edit a comment

    PATCH /repos/:owner/:repo/issues/comments/:id

### Input

Name | Type | Description 
-----|------|--------------
`body`|`string` | **Required**. The contents of the comment.


<%= json :body => "String" %>

### Response

<%= headers 200 %>
<%= json :issue_comment %>

## Delete a comment

    DELETE /repos/:owner/:repo/issues/comments/:id

### Response

<%= headers 204 %>

## Custom media types

These are the supported media types for issue comments. You can read more
about the use of media types in the API [here](/v3/media/).

    application/vnd.github.VERSION.raw+json
    application/vnd.github.VERSION.text+json
    application/vnd.github.VERSION.html+json
    application/vnd.github.VERSION.full+json
