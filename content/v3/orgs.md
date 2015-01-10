---
title: Organizations | GitHub API
---

# Organizations

* TOC
{:toc}

## List your organizations

List organizations for the authenticated user.

### OAuth scope requirements

Currently, [OAuth](/v3/oauth/#scopes) requests always receive the user's [public organization memberships](https://help.github.com/articles/publicizing-or-concealing-organization-membership), regardless of the OAuth scopes associated with the request. If the OAuth authorization has `user` or `read:org` scope, the response also includes private organization memberships.

With the new Organization Permissions API (described below), this method will only return organizations that your authorization allows you to operate on in some way (e.g., you can list teams with `read:org` scope, you can publicize your organization membership with `user` scope, etc.). Therefore, this API will require at least `user` or `read:org` scope. OAuth requests with insufficient scope will receive a `403 Forbidden` response.

<div class="alert">
  <p>
    We're currently offering a migration period allowing applications to opt in to the Organization Permissions API. This functionality will apply to all API consumers beginning February 24, 2015. Please see the <a href="/changes/2015-01-07-prepare-for-organization-permissions-changes/">blog post</a> for full details.
  </p>

  <p>
    To access the API during the migration period, you must provide a custom <a href="/v3/media">media type</a> in the <code>Accept</code> header:
    <pre>application/vnd.github.moondragon+json</pre>
  </p>
</div>

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
    We're currently offering a migration period allowing applications to opt in to the Organization Permissions API. This functionality will apply to all API consumers beginning February 24, 2015. Please see the <a href="/changes/2015-01-07-prepare-for-organization-permissions-changes/">blog post</a> for full details.
  </p>

  <p>
    To access the API during the migration period, you must provide a custom <a href="/v3/media">media type</a> in the <code>Accept</code> header:
    <pre>application/vnd.github.moondragon+json</pre>
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
