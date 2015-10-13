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
`login`|`string` | **Required.** The user's username.
`email`|`string` | **Required.** The user's email address.

#### Example

<%= json \
    :login    => "monalisa",
    :email    => "octocat@github.com"
%>

### Response

<%= headers 201 %>
<%= json :user %>

## Rename an existing user

    PATCH /admin/users/:user_id

### Parameters

Name | Type | Description
-----|------|--------------
`login`|`string` | **Required.** The user's new username.

#### Example

<%= json \
  :login => "thenewmonalisa"
%>

### Response

<%= headers 202 %>
<%= json \
  :message => "Job queued to rename user. It may take a few minutes to complete.",
  :url => "https://api.github.com/user/1"
%>

## Create an impersonation OAuth token

    POST /admin/users/:user_id/authorizations

### Parameters

Name | Type | Description
---- | ---- | -------------
`scopes`|`array` | A list of [scopes](/v3/oauth/#scopes).

### Response

<%= headers 201 %>
<%= json(:oauth_access) %>

## Delete an impersonation OAuth token

    DELETE /admin/users/:user_id/authorizations

### Response

<%= headers 204 %>

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

## List all public keys

   GET /admin/keys

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:all_keys) { |public_key, deploy_key| \
  [public_key, deploy_key.merge("id" => "2", "url" => "https://api.github.com/repos/octocat/Hello-World/keys/2")] \
} %>

## Delete a user

{{#warning}}

Deleting a user will delete all their repositories, gists, applications, and personal settings. [Suspending a user](/v3/users/administration/#suspend-a-user) is often a better option.

{{/warning}}

    DELETE /admin/users/:username

You can delete any user account except your own.

### Response

<%= headers 204 %>

## Delete a public key

  DELETE /admin/keys/1

### Response

<%= headers 204 %>
