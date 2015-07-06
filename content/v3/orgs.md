---
title: Organizations | GitHub API
---

# Organizations

* TOC
{:toc}

## List your organizations

List organizations for the authenticated user.

### OAuth scope requirements

This only lists organizations that your authorization allows you to operate on in some way (e.g., you can list teams with `read:org` scope, you can publicize your organization membership with `user` scope, etc.). Therefore, this API requires at least `user` or `read:org` scope. OAuth requests with insufficient scope receive a `403 Forbidden` response.

    GET /user/orgs

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:org) { |h| [h] } %>

## List all organizations

Lists all organizations, in the order that they were created on GitHub.

Note: Pagination is powered exclusively by the `since` parameter.
Use the [Link header](/v3/#link-header) to get the URL for the next page of
organizations.

    GET /organizations

### Parameters

Name | Type | Description
-----|------|--------------
`since`|`string`| The integer ID of the last Organization that you've seen.

### Response

<%= headers 200, :pagination => { :next => 'https://api.github.com/organizations?since=135' } %>
<%= json(:org) {|h| [h] } %>

## List user organizations

List [public organization memberships](https://help.github.com/articles/publicizing-or-concealing-organization-membership) for the specified user.

This method only lists *public* memberships, regardless of authentication. If you need to fetch all of the organization memberships (public and private) for the authenticated user, use the [List your organizations](#list-your-organizations) API instead.

    GET /users/:username/orgs

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:org) { |h| [h] } %>

## Get an organization

    GET /orgs/:org

### Response

<%= headers 200 %>
<%= json(:full_org) %>

## Edit an organization

    PATCH /orgs/:org

### Input

Name | Type | Description
-----|------|--------------
`billing_email`|`string` | Billing email address. This address is not publicized.
`company`|`string` | The company name.
`email`|`string` | The publicly visible email address.
`location`|`string` | The location.
`name`|`string` | The shorthand name of the company.
`description`|`string` | The description of the company.

### Example

<%= json \
    :billing_email => "support@github.com",
    :blog     => "https://github.com/blog",
    :company  => "GitHub",
    :email    => "support@github.com",
    :location => "San Francisco",
    :name     => "github",
    :description => "GitHub, the company."
    %>

### Response

<%= headers 200 %>
<%= json(:private_org) %>
