---
title: Issue Comments API v3 | developer.github.com
---

# Issue Comments API

## Get Comments for an Issue

    GET /repos/:user/:repo/issues/:id/comments

### Response

<%= headers 200, :pagination => true %>
<%= json(:issue_comment) { |h| [h] } %>

## Create a Comment for an Issue

    POST /repos/:user/:repo/issues/:id/comments

### Input

<%= json :body => "String" %>

### Response

<%= headers 201,
      :Location =>
"https://api.github.com/repos/user/repo/issues/comments/:id" %>
<%= json :issue_comment %>

## View a single Issue Comment

    GET /repos/:user/:repo/issues/comments/:id

### Response

<%= headers 200 %>
<%= json :issue_comment %>

## Edit an Issue Comment

    PATCH /repos/:user/:repo/issues/comments/:id

### Input

<%= json :body => "String" %>

### Response

<%= headers 200 %>
<%= json :issue_comment %>

## Delete an Issue Comment

    DELETE /repos/:user/:repo/issues/comments/:id

### Response

<%= headers 204, :no_response => true %>
