---
title: User Administration | GitHub API
---

# Administration (Enterprise)

* TOC
{:toc}

The User Administration API allows you to promote, demote, suspend, and unsuspend users on a GitHub Enterprise appliance. *It is only available to [authenticated](/v3/#authentication) site administrators.* Normal users will receive a `403` response if they try to access it.

Prefix all the endpoints for this API with the following URL:

<pre class="terminal">
http(s)://<em>hostname</em>/api/v3
</pre>

## Create a new user

    POST /admin/users

### Parameters

Name | Type | Description
-----|------|--------------
`login`|`string` | The user's username
`email`|`string` | The user's email address

#### Example

<%= json \
    :login    => "monalisa",
    :email    => "octocat@github.com"
%>

### Response

<%= headers 201 %>
<%= json :user %>

## Promote an ordinary user to a site administrator

    PUT /users/:username/site_admin

<%= fetch_content(:put_content_length) %>

### Response

<%= headers 204 %>

## Demote a site administrator to an ordinary user

    DELETE /users/:username/site_admin

You can demote any user account except your own.

### Response

<%= headers 204 %>

## Suspend a user

{{#warning}}

If your GitHub Enterprise appliance has [LDAP Sync with Active Directory LDAP servers](https://help.github.com/enterprise/2.1/admin/guides/user-management/using-ldap), this API is disabled and will return a `403` response. Users managed by an external account cannot be suspended via the API.

{{/warning}}

    PUT /users/:username/suspended

You can suspend any user account except your own.

<%= fetch_content(:put_content_length) %>

### Response

<%= headers 204 %>

## Unsuspend a user

{{#warning}}

If your GitHub Enterprise appliance has [LDAP Sync with Active Directory LDAP servers](https://help.github.com/enterprise/2.1/admin/guides/user-management/using-ldap), this API is disabled and will return a `403` response. Users managed by an external account cannot be unsuspended via the API.

{{/warning}}

    DELETE /users/:username/suspended

### Response

<%= headers 204 %>
