---
title: LDAP
---

# LDAP

* TOC
{:toc}

You can use the LDAP API to update account relationships between a GitHub Enterprise user or team and its linked LDAP entry or queue a new synchronization.

With the LDAP mapping endpoints, you're able to update the Distinguished Name (DN) that a user or team maps to. Note that the LDAP endpoints are generally only effective if your GitHub Enterprise appliance has [LDAP Sync enabled](https://help.github.com/enterprise/admin/guides/user-management/using-ldap). As of GitHub Enterprise 2.3.1, the [Update LDAP mapping for a user](#update-ldap-mapping-for-a-user) can be used when LDAP is enabled, even if LDAP Sync is disabled.

## Update LDAP mapping for a user

    PATCH /admin/ldap/users/:username/mapping

### Body parameters

Pass a JSON payload with the new LDAP Distinguished Name.

#### Example

    #!javascript
    '{"ldap_dn": "uid=asdf,ou=users,dc=github,dc=com"}'

### Response

<%= headers 200 %>
<%= json :ldap_user_update %>

## Sync LDAP mapping for a user

{{#tip}}

Note that this API call does not automatically initiate an LDAP sync. Rather, if a `201` is returned, the sync job is queued successfully, and is performed when the instance is ready.

{{/tip}}

    POST /admin/ldap/users/:username/sync

### Response

<%= headers 201 %>
<%= json :ldap_sync_confirm %>

## Update LDAP mapping for a team

    PATCH /admin/ldap/teams/:team_id/mapping

### Body parameters

Pass a JSON payload with the new LDAP Distinguished Name.

#### Example

    #!javascript
    '{"ldap_dn": "cn=Enterprise Ops,ou=teams,dc=github,dc=com"}'

### Response

<%= headers 200 %>
<%= json :ldap_team_update %>

## Sync LDAP mapping for a team

{{#tip}}

Note that this API call does not automatically initiate an LDAP sync. Rather, if a `201` is returned, the sync job is queued successfully, and is performed when the instance is ready.

{{/tip}}

    POST /admin/ldap/teams/:team_id/sync

### Response

<%= headers 201 %>
<%= json :ldap_sync_confirm %>
