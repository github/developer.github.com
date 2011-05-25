---
title: Gist Comments API v3 | developer.github.com
---

# Gist Comments API

## List comments on a gist

    GET /gists/:gist_id/comments

### Response

<%= headers 200 %>
<%= json(:gist_comment) { |h| [h] } %>

## Get a single comment

    GET /gists/comments/:id

### Response

<%= headers 200 %>
<%= json :gist_comment %>

## Create a comment

    POST /gists/:gist_id/comments

### Input

<%= json :body => 'Just commenting for the sake of commenting' %>

### Response

<%= headers 201,
      :Location => "https://api.github.com/gists/comments/1" %>
<%= json :gist_comment %>

## Edit a comment

    PATCH /gists/comments/:id

### Input

<%= json :body => 'Just commenting for the sake of commenting' %>

### Response

<%= headers 200 %>
<%= json :gist_comment %>

## Delete a comment

    DELETE /gists/comments/:id

### Response

<%= headers 204 %>

