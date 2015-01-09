---
title: LDAP
---

# LDAP

* TOC
{:toc}

You can use the LDAP API to force synchronization or update account relationships. Note that this API is only effective if your GitHub Enterprise appliance has [LDAP Sync enabled](https://help.github.com/enterprise/admin/guides/user-management/using-ldap).

## Update LDAP mapping for a user

    PATCH /admin/ldap/user/:username/mapping

### Body parameters

You must pass in a JSON configuration that defines your new LDAP configuration.

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

Note that this API call does not automatically initiate an LDAP sync. Rather, it queues a sync, and performs it when ready.

{{/tip}}

    POST /admin/ldap/user/:username/sync

### Response

<%= headers 201 %>
<%= json :ldap_sync_confirm %>

## Update LDAP mapping for a team

    PATCH /admin/ldap/teams/:teamname/mapping

### Body parameters

You must pass in a JSON configuration that defines your new LDAP configuration.

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

Note that this API call does not automatically initiate an LDAP sync. Rather, it queues a sync, and performs it when ready.

{{/tip}}

    POST /admin/ldap/user/:teamname/sync

### Response

<%= headers 201 %>
<%= json :ldap_sync_confirm %>
