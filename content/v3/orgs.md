---
title: Organizations | GitHub API
---

# Organizations

* TOC
{:toc}

## List User Organizations

List all public organizations for an unauthenticated user. Lists private *and* public organizations for authenticated users.

    GET /users/:username/orgs

List public and private organizations for the authenticated user.

    GET /user/orgs

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:org) { |h| [h] } %>

## Get an Organization

    GET /orgs/:org

### Response

<%= headers 200 %>
<%= json(:full_org) %>

## Edit an Organization

    PATCH /orgs/:org

### Input

Name | Type | Description
-----|------|--------------
`billing_email`|`string` | Billing email address. This address is not publicized.
`company`|`string` | The company name.
`email`|`string` | The publicly visible email address.
`location`|`string` | The location.
`name`|`string` | The shorthand name of the company.

### Example

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
