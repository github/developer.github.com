---
title: Gist Comments API v3 | dev.github.com
---

# Gist Comments API

## List

    GET /gists/:gist_id/comments.json

### Response

<%= headers :status => 200 %>
<%= json(:gist_comment) { |h| [h] } %>

## Get

    GET /gists/comments/:id.json

### Response

<%= headers :status => 200 %>
<%= json :gist_comment %>

## Create

    POST /gists/:gist_id/comments.json

### Response

<%= headers :status => 201,
      :Location => "https://api.github.com/gists/comments/1.json" %>
<%= json :gist_comment %>

## Edit

    PATCH /gists/comments/:id.json

### Response

<%= headers :status => 200 %>
<%= json :gist_comment %>

## Delete

    DELETE /gists/comments/:id.json

### Response

<%= headers :status => 204 %>
<%= json({}) %>

