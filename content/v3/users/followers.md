---
title: User Followers API v3 | developer.github.com
---

# User Followers API

## List followers

    GET /users/:user/followers
    GET /user/followers

### Response

<%= headers 200, :pagination => true %>
<%= json(:user) { |h| [h] } %>

## List following

    GET /users/:user/following
    GET /user/following

### Response

<%= headers 200, :pagination => true %>
<%= json(:user) { |h| [h] } %>

## Follow a user

    POST /users/:user/follow

### Response

<%= headers 201 %>
<%= json({}) %>

## Unfollow a user

    DELETE /users/:user/follow

### Response

<%= headers 200 %>
<%= json({}) %>

