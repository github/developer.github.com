---
title: Organization Members | GitHub API
---

# Members

* TOC
{:toc}

## Members list

List all users who are members of an organization. If the authenticated user is
also a member of this organization then both concealed and public members will
be returned.

    GET /orgs/:org/members

### Parameters {#audit-two-factor-auth}

Name    | Type    | Description
--------|---------|--------------
`filter`|`string` | Filter members returned in the list. Can be one of:<br/>* `2fa_disabled`: Members without [two-factor authentication][2fa-blog] enabled. Available for organization owners.<br/>* `all`: All organization members.<br/><br/>Default: `all`
`role`  |`string` | Filter members returned by their role. Can be one of:<br/>* `all`: All members of the organization, regardless of role.<br/>* `admin`: Organization owners.<br/>* `member`: Non-owner organization members. **This option requires a custom media type to be specified. Please see more in the alert below.**<br/><br/>Default: `all`

[2fa-blog]: https://github.com/blog/1614-two-factor-authentication

<div class="alert">
  <p>
    We're currently offering a preview period allowing applications to opt in to the Organization Permissions API. Please see the <a href="/changes/2015-06-24-api-enhancements-for-working-with-organization-permissions/">blog post</a> for full details.
  </p>

  <p>
    To access the API during the preview period, you must provide a custom <a href="/v3/media">media type</a> in the <code>Accept</code> header:
    <pre>application/vnd.github.ironman-preview+json</pre>
  </p>
</div>

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:user) { |h| [h] } %>

### Response if requester is not an organization member

<%= headers 302, "Location" => "https://api.github.com/orgs/github/public_members" %>

## Check membership

Check if a user is, publicly or privately, a member of the organization.

    GET /orgs/:org/members/:username

### Response if requester is an organization member and user is a member

<%= headers 204 %>

### Response if requester is an organization member and user is not a member

<%= headers 404 %>

### Response if requester is not an organization member and is inquiring about themselves

<%= headers 404 %>

### Response if requester is not an organization member

<%= headers 302, :Location => "https://api.github.com/orgs/github/public_members/pezra" %>

## Add a member

To add someone as a member to an organization, you must
[invite them to the organization](/v3/orgs/members/#add-or-update-organization-membership)
or [invite them to a team](/v3/orgs/teams/#add-team-membership).

## Remove a member

Removing a user from this list will remove them from all teams and
they will no longer have any access to the organization's repositories.

    DELETE /orgs/:org/members/:username

### Response

<%= headers 204 %>

## Public members list

Members of an organization can choose to have their membership
publicized or not.

    GET /orgs/:org/public_members

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:user) { |h| [h] } %>

## Check public membership

    GET /orgs/:org/public_members/:username

### Response if user is a public member

<%= headers 204 %>

### Response if user is not a public member

<%= headers 404 %>

## Publicize a user's membership

The user can publicize their own membership.
(A user cannot publicize the membership for another user.)

    PUT /orgs/:org/public_members/:username

<%= fetch_content(:put_content_length) %>

### Response

<%= headers 204 %>

## Conceal a user's membership

    DELETE /orgs/:org/public_members/:username

### Response

<%= headers 204 %>

## Get organization membership

In order to get a user's membership with an organization, the authenticated user must be an organization owner.

    GET /orgs/:org/memberships/:username

### Response if user has an active admin membership with organization

<%= headers 200 %>
<%= json(:active_admin_org_membership) %>

### Response if user has an active membership with organization

<%= headers 200 %>
<%= json(:active_limited_org_membership) %>

### Response if user has a pending membership with organization

<%= headers 200 %>
<%= json(:pending_limited_org_membership) %>

## Add or update organization membership

In order to create or update a user's membership with an organization, the authenticated user must be an organization owner.

    PUT /orgs/:org/memberships/:username

### Parameters

Name  | Type   | Description
------|--------|--------------
`role`|`string`| **Required**. The role to give the user in the organization. Can be one of:<br/> * `admin` - The user will become an owner of the organization.<br/> * `member` - The user will become a non-owner member of the organization. Use this only to demote an existing owner to a non-owner.

### Response if user was previously unaffiliated with organization

<%= headers 200 %>
<%= json(:pending_admin_org_membership) %>

### Response if user already had membership with organization

<%= headers 200 %>
<%= json(:active_admin_org_membership) %>

## Remove organization membership

In order to remove a user's membership with an organization, the authenticated user must be an organization owner.

    DELETE /orgs/:org/memberships/:username

If the specified user is an active member of the organization, this will remove them from the organization. If the specified user has been invited to the organization, this will cancel their invitation.

### Response

<%= headers 204 %>

## List your organization memberships

    GET /user/memberships/orgs

### Input

Name | Type | Description
-----|------|--------------
`state`|`string`| Indicates the state of the memberships to return. Can be either `active` or `pending`. If not specified, both active and pending memberships are returned.

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:org_memberships) %>

## Get your organization membership

    GET /user/memberships/orgs/:org

### Response

<%= headers 200 %>
<%= json(:pending_admin_org_membership) %>

## Edit your organization membership

    PATCH /user/memberships/orgs/:org

### Input

Name | Type | Description
-----|------|--------------
`state`|`string`| **Required**. The state that the membership should be in. Only `"active"` will be accepted.

### Example

<%= json \
    :state => "active"
    %>

### Response

<%= headers 200 %>
<%= json(:active_admin_org_membership) %>
