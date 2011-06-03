---
title: Orgs API v3 | developer.github.com
---

# Orgs API

## List

List all public organizations for a user.

    GET /users/:user/orgs

List public and private organizations for the authenticated user.

    GET /user/orgs

### Response

<%= headers 200, :pagination => true %>
<%= json(:org) { |h| [h] } %>

## Get

    GET /orgs/:org

### Response

<%= headers 200 %>
<%= json(:full_org) %>

## Edit

    PATCH /orgs/:org

### Input

<%= json \
    :name     => "github",
    :email    => "support@github.com",
    :blog     => "https://github.com/blog",
    :company  => "GitHub",
    :location => "San Francisco",
    :billing_email => "support@github.com"
    %>

### Response

<%= headers 200 %>
<%= json(:private_org) %>
