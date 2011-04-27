---
title: Issue Comments API v3 | dev.github.com
---

# Issue Comments API

## Get Comments for an Issue

    GET /repos/:user/:repo/issues/:id/comments.json

### Response

<%= json(:issue_comment) { |h| [h] } %>

## Create a Comment for an Issue

    POST /repos/:user/:repo/issues/:id/comments.json

### Input

<%= json :body => "String" %>

### Response

<%= json :issue_comment %>

## View a single Issue Comment

    GET /repos/:user/:repo/issues/comments/:id.json

### Response

<%= json :issue_comment %>

## Edit an Issue Comment

    PATCH /repos/:user/:repo/issues/comments/:id.json

### Input

<%= json :body => "String" %>

### Response

<%= json :issue_comment %>

## Delete an Issue Comment

    DELETE /repos/:user/:repo/issues/comments/:id.json

### Response

    {}
