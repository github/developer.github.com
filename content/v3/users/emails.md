---
title: User Emails | GitHub API
---

# Emails

* TOC
{:toc}

Management of email addresses via the API requires that you are
authenticated through basic auth or OAuth with the user scope.

## List email addresses for a user

    GET /user/emails

This endpoint is accessible with the user:email scope.

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:user_email) {|e| [e]} %>

## Add email address(es)

{{#enterprise-only}}

{{#warning}}

If your GitHub Enterprise appliance has [LDAP Sync enabled](/enterprise/admin/guides/user-management/using-ldap), this API will return a `403` response. Users managed by an external account cannot add an email address via the API.

{{/warning}}

{{/enterprise-only}}

    POST /user/emails

### Input

You can post a single email address or an array of addresses:

<%= json ["octocat@github.com", "support@github.com"] %>

### Response

<%= headers 201 %>
<%= json [
  {
    "email" => "octocat@github.com",
    "primary" => false,
    "verified" => false
  },
  {
    "email" => "support@github.com",
    "primary" => false,
    "verified" => false
  },
] %>

## Delete email address(es)

{{#enterprise-only}}

{{#warning}}

If your GitHub Enterprise appliance has [LDAP Sync enabled](/enterprise/admin/guides/user-management/using-ldap), this API will return a `403` response. Users managed by an external account cannot delete an email address via the API.

{{/warning}}

{{/enterprise-only}}

    DELETE /user/emails

### Input

You can include a single email address or an array of addresses:

<%= json ["octocat@github.com", "support@github.com"] %>

### Response

<%= headers 204 %>


[media-types]: /v3/media
