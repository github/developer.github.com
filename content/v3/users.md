---
title: Users API v3 | developer.github.com
---

# Users API
Many of the resources on the users API provide a shortcut for getting
information about the currently authenticated user. If a request URL does not
include a `:user` parameter than the response will be for the logged in
user (and you must pass authentication information with your request).

## Get a single user

    GET /users/:user
    GET /user

### Response

<%= headers 200, :pagination => true %>
<%= json :full_user %>

## Update a user

    PATCH /user

### Input

<%= json \
    :name     => "monalisa octocat",
    :email    => "octocat@github.com",
    :blog     => "https://github.com/blog",
    :company  => "GitHub",
    :location => "San Francisco",
    :hireable => true,
    :bio      => "There once..."
    %>

### Response

<%= headers 200, :pagination => true %>
<%= json :private_user %>

## List a user's repositories

Calling this for the authenticated user returns public and private
repositories. Otherwise only the public repositories of the specified
user are returned.

    GET /users/:user/repos
    GET /user/repos

### Response

<%= headers 200, :pagination => true %>
<%= json(:repo) { |h| [h] } %>

## List a user's organizations

    GET /user/orgs

### Response

<%= headers 200, :pagination => true %>
<%= json(:org) { |h| [h] } %>

