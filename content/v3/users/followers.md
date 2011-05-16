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

    PUT /user/following/:user

### Response

<%= headers 204, :no_response => true %>

## Unfollow a user

    DELETE /user/following/:user

### Response

<%= headers 204, :no_response => true %>

## Check if you are following a user

    GET /user/following/:user

### Response if you are following this user

<%= headers 204, :no_response => true %>

### Response if you are not following this user

<%= headers 404, :no_response => true %>

