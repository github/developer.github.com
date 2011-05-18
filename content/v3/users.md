---
title: Users API v3 | developer.github.com
---

# Users API
Many of the resources on the users API provide a shortcut for getting
information about the currently authenticated user. If a request URL does not
include a `:user` parameter than the response will be for the logged in
user (and you must pass authentication information with your request).

## Get a user

    GET /users/:user

### Response

<%= headers 200 %>
<%= json :full_user %>

## Get the authenicated user

    GET /user

### Response

<%= headers 200 %>
<%= json :private_user %>

## Update the authenticated user

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

<%= headers 200 %>
<%= json :private_user %>

