---
title: Organization Members | GitHub API
---

# Members

* TOC
{:toc}

## Members list

List all users who are members of an organization. A member is a user that
belongs to at least 1 team in the organization. If the authenticated user is
also an owner of this organization then both concealed and public members will
be returned.

    GET /orgs/:org/members

### Parameters {#audit-two-factor-auth}

Name    | Type    | Description
--------|---------|--------------
`filter`|`string` | Filter members returned in the list. Can be one of:<br/>* `2fa_disabled`: Members without [two-factor authentication][2fa-blog] enabled. Available for owners of organizations with private repositories.<br/>* `all`: All members the authenticated user can see.<br/><br/>Default: `all`

[2fa-blog]: https://github.com/blog/1614-two-factor-authentication

### Response

<%= headers 200 %>
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

To add someone as a member to an org, you must add them to a
[team](/v3/orgs/teams/#add-team-member).

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

<%= headers 200 %>
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

## List your organization memberships

<div class="alert">
  <p>
    The Organization Memberships API is currently available for developers to preview.
    During the preview period, the API may change without notice.
    Please see the <a href="/changes/2014-08-28-accepting-organization-invitations-from-the-api/">blog post</a> for full details.
  </p>

  <p>
    To access the API during the preview period, you must provide a custom <a href="/v3/media">media type</a> in the <code>Accept</code> header:
    <pre>application/vnd.github.the-wasp-preview+json</pre>
  </p>
</div>

An optional `state` can be passed to request only pending or active memberships.

    GET /user/memberships/orgs
    GET /user/memberships/orgs?state=active
    GET /user/memberships/orgs?state=pending

### Response when no state is specified

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:org_memberships) %>

### Response when a "pending" state is specified

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:pending_org_memberships) %>

### Response when an "active" state is specified

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:active_org_memberships) %>

## Get your organization membership

<div class="alert">
  <p>
    The Organization Memberships API is currently available for developers to preview.
    During the preview period, the API may change without notice.
    Please see the <a href="/changes/2014-08-28-accepting-organization-invitations-from-the-api/">blog post</a> for full details.
  </p>

  <p>
    To access the API during the preview period, you must provide a custom <a href="/v3/media">media type</a> in the <code>Accept</code> header:
    <pre>application/vnd.github.the-wasp-preview+json</pre>
  </p>
</div>

    GET /user/memberships/orgs/:org

### Response

<%= headers 200 %>
<%= json(:pending_org_membership) %>

## Edit your organization membership

<div class="alert">
  <p>
    The Organization Memberships API is currently available for developers to preview.
    During the preview period, the API may change without notice.
    Please see the <a href="/changes/2014-08-28-accepting-organization-invitations-from-the-api/">blog post</a> for full details.
  </p>

  <p>
    To access the API during the preview period, you must provide a custom <a href="/v3/media">media type</a> in the <code>Accept</code> header:
    <pre>application/vnd.github.the-wasp-preview+json</pre>
  </p>
</div>

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
<%= json(:active_org_membership) %>
