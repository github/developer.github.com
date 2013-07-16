---
title: User Followers | GitHub API
---

# User Followers API

* TOC
{:toc}

## List followers of a user

List a user's followers:

    GET /users/:user/followers

List the authenticated user's followers:

    GET /user/followers

### Response

<%= headers 200, :pagination => true %>
<%= json(:user) { |h| [h] } %>

## List users followed by another user

List who a user is following:

    GET /users/:user/following

List who the authenticated user is following:

    GET /user/following

### Response

<%= headers 200, :pagination => true %>
<%= json(:user) { |h| [h] } %>

## Check if you are following a user

    GET /user/following/:user

### Response if you are following this user

<%= headers 204 %>

### Response if you are not following this user

<%= headers 404 %>

## Check if one user follows another

    GET /users/:user/following/:target_user

### Response if user follows target user

<%= headers 204 %>

### Response if user does not follow target user

<%= headers 404 %>

## Follow a user

    PUT /user/following/:user

Following a user requires the user to be logged in and authenticated with basic
auth or OAuth with the `user:follow` scope.

### Response

<%= headers 204 %>

## Unfollow a user

    DELETE /user/following/:user

Unfollowing a user requires the user to be logged in and authenticated with basic
auth or OAuth with the `user:follow` scope.

### Response

<%= headers 204 %>
