---
title: Orgs API v3 | developer.github.com
---

# Orgs API

## List

List all public organizations for a user.

    GET /users/:user/orgs

List public and private organizations for the authenticated user.
(_Login required_)

    GET /user/orgs

### Response

<%= headers 200, :pagination => true %>
<%= json(:org) { |h| [h] } %>

## Get

    GET /orgs/:org

### Response

<%= headers 200 %>
<%= json(:full_org) %>

## Edit [A,R,PR]

    PATCH /orgs/:org

### Input

billing_email
: _Optional_ **string** for a billing email address. This address is not
publicized.

company
: _Optional_ **string** company this organization belongs to.

email
: _Optional_ **string** for a publically visible email address.

location
: _Optional_ **string** where this organization is located.

name
: _Optional_ **string** name of this organization.

<%= json \
    :billing_email => "support@github.com",
    :blog     => "https://github.com/blog",
    :company  => "GitHub",
    :email    => "support@github.com",
    :location => "San Francisco",
    :name     => "github"
    %>

### Response

<%= headers 200 %>
<%= json(:private_org) %>
