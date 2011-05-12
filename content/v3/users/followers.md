---
title: User Followers API v3 | developer.github.com
---

# User Followers API

## List a user's followers

    GET /users/:user/followers
    GET /user/followers

### Response

<%= headers 200, :pagination => true %>
<%= json(:user) { |h| [h] } %>

## List who a user is following

    GET /users/:user/following
    GET /user/following

### Response

<%= headers 200, :pagination => true %>
<%= json(:user) { |h| [h] } %>

## Follow a user

    POST /user/following/:user

### Response

<%= headers 201 %>
<%= json({}) %>

## Unfollow a user

    DELETE /user/following/:user

### Response

<%= headers 200 %>
<%= json({}) %>

## Check if you are following a user

    GET /user/following/:user

### Response if you are following this user

<%= headers 204 %>
<%= json({}) %>

### Response if you are not following this user

<%= headers 404 %>
<%= json({}) %>

