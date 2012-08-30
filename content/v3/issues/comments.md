---
title: Issue Comments | GitHub API
---

# Issue Comments API

The Issue Comments API supports listing, viewing, editing, and creating
comments on issues and pull requests.

Issue Comments leverage [these](#custom-mime-types) custom mime types.
You can read more about the use of mime types in the API
[here](/v3/mime/).

## List comments on an issue

    GET /repos/:user/:repo/issues/:number/comments

### Response

<%= headers 200, :pagination => true %>
<%= json(:issue_comment) { |h| [h] } %>

## Get a single comment

    GET /repos/:user/:repo/issues/comments/:id

### Response

<%= headers 200 %>
<%= json :issue_comment %>

## Create a comment

    POST /repos/:user/:repo/issues/:number/comments

### Input

body
: _Required_ **string**

<%= json :body => "a new comment" %>

### Response

<%= headers 201,
      :Location =>
"https://api.github.com/repos/user/repo/issues/comments/1" %>
<%= json :issue_comment %>

## Edit a comment

    PATCH /repos/:user/:repo/issues/comments/:id

### Input

body
: _Required_ **string**

<%= json :body => "String" %>

### Response

<%= headers 200 %>
<%= json :issue_comment %>

## Delete a comment

    DELETE /repos/:user/:repo/issues/comments/:id

### Response

<%= headers 204 %>

## Custom Mime Types

These are the supported mime types for issue comments. You can read more
about the use of mime types in the API [here](/v3/mime/).

    application/vnd.github.VERSION.raw+json
    application/vnd.github.VERSION.text+json
    application/vnd.github.VERSION.html+json
    application/vnd.github.VERSION.full+json
