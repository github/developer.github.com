---
title: Organizations | GitHub API
---

# Orgs API

* TOC
{:toc}

## List User Organizations

List all public organizations for a user.

    GET /users/:user/orgs

List public and private organizations for the authenticated user.

    GET /user/orgs

### Response

<%= headers 200, :pagination => true %>
<%= json(:org) { |h| [h] } %>

## Get an Organization

    GET /orgs/:org

### Response

<%= headers 200 %>
<%= json(:full_org) %>

## Edit an Organization

    PATCH /orgs/:org

### Input

billing_email
: _Optional_ **string** - Billing email address. This address is not
publicized.

company
: _Optional_ **string**

email
: _Optional_ **string** - Publicly visible email address.

location
: _Optional_ **string**

name
: _Optional_ **string**

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
