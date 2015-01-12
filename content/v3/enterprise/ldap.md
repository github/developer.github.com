---
title: LDAP
---

# LDAP

* TOC
{:toc}

You can use the LDAP API to force synchronization or update account relationships. Note that this API is only effective if your GitHub Enterprise appliance has [LDAP Sync enabled](https://help.github.com/enterprise/admin/guides/user-management/using-ldap).

## Update LDAP mapping for a user

    PATCH /admin/ldap/user/:username/mapping

### Query parameters

Name | Type | Description
-----|------|--------------
`ldap_dn`|`String` | **Required**. The new LDAP configuration.

#### Example

    ldap_dn=uid=asdf,ou=users,dc=github,dc=com

### Response

<%= headers 200 %>
<%= json :ldap_user_update %>

## Sync LDAP mapping for a user

{{#tip}}

Note that this API call does not automatically initiate an LDAP sync. Rather, it queues a sync, and performs it when ready.

{{/tip}}

    POST /admin/ldap/user/:username/sync

### Response

<%= headers 201 %>
<%= json :ldap_sync_confirm %>

## Update LDAP mapping for a team

    PATCH /admin/ldap/teams/:teamname/mapping

### Query parameters

Name | Type | Description
-----|------|--------------
`ldap_dn`|`String` | **Required**. The new LDAP configuration.

#### Example

    ldap_dn=cn=Enterprise,ou=teams,dc=github,dc=com

### Response

<%= headers 200 %>
<%= json :ldap_team_update %>


## Sync LDAP mapping for a team

{{#tip}}

Note that this API call does not automatically initiate an LDAP sync. Rather, it queues a sync, and performs it when ready.

{{/tip}}

    POST /admin/ldap/user/:teamname/sync

### Response

<%= headers 201 %>
<%= json :ldap_sync_confirm %>
