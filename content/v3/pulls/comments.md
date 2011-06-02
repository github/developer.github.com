---
title: Pull Request Comments API v3 | developer.github.com
---

# Pull Request Comments API

## List comments on a pull request

    GET /repos/:user/:repo/pulls/:pull_id/comments

### Response

<%= headers 200 %>
<!-- <%= json(:gist_comment) { |h| [h] } %>-->

## Get a single comment

    GET /repos/:user/:repo/pulls/:pull_id/comments/:id

### Response

<%= headers 200 %>
<!-- <%= json :gist_comment %>-->

## Create a comment

    POST /repos/:user/:repo/pulls/:pull_id/comments

### Input

<!-- <%= json :body => 'Just commenting for the sake of commenting' %>-->

### Response

<%= headers 201,
      :Location =>
"https://api.github.com/repos/:user/:repo/pulls/:pull_id/comments/1" %>
<!-- <%= json :gist_comment %>-->

## Edit a comment

    PATCH /repos/:user/:repo/pulls/:pull_id/comments/:id

### Input

<!-- <%= json :body => 'Just commenting for the sake of commenting' %>-->

### Response

<%= headers 200 %>
<!-- <%= json :gist_comment %>-->

## Delete a comment

    DELETE /repos/:user/:repo/pulls/:pull_id/comments/:id

### Response

<%= headers 204 %>

