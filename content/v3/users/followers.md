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

    POST /user/followers/:user

<%= headers 201 %>
<%= json({}) %>

## Unfollow a user

    DELETE /user/followers/:user

### Response

<%= headers 200 %>
<%= json({}) %>

## Get if you are following a user

	GET /user/followers/:user

### Response if you are following this user

<%= headers 204 %>
<%= json({}) %>

### Response if you are not following this user

<%= headers 404 %>
<%= json({}) %>

