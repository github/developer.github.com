---
title: LDAP
---

# LDAP

* TOC
{:toc}

You can use the LDAP API to update account relationships between a GitHub Enterprise user and its linked LDAP entry or queue a new synchronization.

With the LDAP mapping endpoints, you're able to update the Distinguished Name (DN) that a user maps to. Note that the LDAP sync endpoints are only effective if your GitHub Enterprise appliance has [LDAP Sync enabled](https://help.github.com/enterprise/admin/guides/user-management/using-ldap).

## Update LDAP mapping for a user

    PATCH /admin/ldap/user/:username/mapping

### Body parameters

Pass a JSON payload with the new LDAP Distinguished Name.

#### Example

    #!javascript
    {
      "uid": "asdf",
      "ou": "users",
      "dc": "github",
      "dc": "com"
    }

### Response

<%= headers 200 %>
<%= json :ldap_user_update %>

## Sync LDAP mapping for a user

{{#tip}}

Note that this API call does not automatically initiate an LDAP sync. Rather, if a `201` is returned, the sync job is queued successfully, and is performed when the instance is ready.

{{/tip}}

    POST /admin/ldap/user/:username/sync

### Response

<%= headers 201 %>
<%= json :ldap_sync_confirm %>

## Update LDAP mapping for a team

    PATCH /admin/ldap/teams/:team_id/mapping

### Body parameters

Pass a JSON payload with the new LDAP Distinguished Name.

#### Example

    #!javascript
    {
      "cn": "Enterprise Ops",
      "ou": "teams",
      "dc": "github",
      "dc": "co"
    }

### Response

<%= headers 200 %>
<%= json :ldap_team_update %>

## Sync LDAP mapping for a team

{{#tip}}

Note that this API call does not automatically initiate an LDAP sync. Rather, if a `201` is returned, the sync job is queued successfully, and is performed when the instance is ready.

{{/tip}}

    POST /admin/ldap/user/:teamname/sync

### Response

<%= headers 201 %>
<%= json :ldap_sync_confirm %>
