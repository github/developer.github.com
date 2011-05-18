---
title: Gist Comments API v3 | developer.github.com
---

# Gist Comments API

## List

    GET /gists/:gist_id/comments

### Response

<%= headers 200 %>
<%= json(:gist_comment) { |h| [h] } %>

## Get

    GET /gists/comments/:id

### Response

<%= headers 200 %>
<%= json :gist_comment %>

## Create

    POST /gists/:gist_id/comments

### Input

<%= json :body => 'Just commenting for the sake of commenting' %>

### Response

<%= headers 201,
      :Location => "https://api.github.com/gists/comments/1" %>
<%= json :gist_comment %>

## Edit

    PATCH /gists/comments/:id

### Input

<%= json :body => 'Just commenting for the sake of commenting' %>

### Response

<%= headers 200 %>
<%= json :gist_comment %>

## Delete

    DELETE /gists/comments/:id

### Response

<%= headers 204, :no_response => true %>

