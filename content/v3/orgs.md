---
title: Organizations | GitHub API
---

# Organizations

* TOC
{:toc}

## List your organizations

List organizations for the authenticated user.

### OAuth scope requirements

When using [OAuth](/v3/oauth/#scopes), authorizations must include `user` scope or `read:org` scope.

    GET /user/orgs

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:org) { |h| [h] } %>

## List user organizations

List [public organization memberships](https://help.github.com/articles/publicizing-or-concealing-organization-membership) for the specified user.

Currently, if you make an authenticated call, you can also list your private memberships in organizations (but only for the currently authenticated user).

With the new Organization Permissions API (described below), this method will only list *public* memberships, regardless of authentication. If you need to fetch all of the organization memberships (public and private) for the authenticated user, use the [List your organizations](#list-your-organizations) API instead.

<div class="alert">
  <p>
    The Organization Permissions API is currently available for developers to preview.
    During the preview period, the API may change without notice.
    Please see the <a href="/changes/2014-12-08-organization-permissions-api-preview/">blog post</a> for full details.
  </p>

  <p>
    To access the API during the preview period, you must provide a custom <a href="/v3/media">media type</a> in the <code>Accept</code> header:
    <pre>application/vnd.github.moondragon-preview+json</pre>
  </p>
</div>

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
