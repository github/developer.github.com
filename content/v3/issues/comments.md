---
title: Issue Comments API v3 | dev.github.com
---

# Issue Comments API

## Get Comments for an Issue

    GET /repos/:user/:repo/issues/:id/comments.json

### Response

<%= headers :status => 200, :pagination => true %>
<%= json(:issue_comment) { |h| [h] } %>

## Create a Comment for an Issue

    POST /repos/:user/:repo/issues/:id/comments.json

### Input

<%= json :body => "String" %>

### Response

<%= headers :status => 201,
      :Location =>
"https://api.github.com/repos/user/repo/issues/comments/:id.json" %>
<%= json :issue_comment %>

## View a single Issue Comment

    GET /repos/:user/:repo/issues/comments/:id.json

### Response

<%= headers :status => 200 %>
<%= json :issue_comment %>

## Edit an Issue Comment

    PATCH /repos/:user/:repo/issues/comments/:id.json

### Input

<%= json :body => "String" %>

### Response

<%= headers :status => 200 %>
<%= json :issue_comment %>

## Delete an Issue Comment

    DELETE /repos/:user/:repo/issues/comments/:id.json

### Response

<%= headers :status => 204 %>
<%= json({}) %>
