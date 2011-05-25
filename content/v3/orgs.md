---
title: Orgs API v3 | developer.github.com
---

# Orgs API

## List

List all public organizations for a user.

    GET /users/:user/orgs

List public and private organizations for the authenticated user.

    GET /user/orgs	

List all public and private organizations if called by an authenicated
user. Otherwise return all public organizations.

    GET /orgs

List all public organizations.

    GET /orgs/public

### Response

<%= headers 200, :pagination => true %>
<%= json(:org) { |h| [h] } %>

## Get

    GET /orgs/:org

### Response

<%= headers 200 %>
<%= json(:org) %>

## Edit

    PATCH /orgs/:org

### Response

<%= headers 200 %>
<%= json(:org) %>

## Delete †

    DELETE /orgs/:org

<%= headers 204 %>

† not sure if we want to do this or not.
