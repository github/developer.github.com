---
title: User Administration | GitHub API
---

# Administration (Enterprise)

* TOC
{:toc}

The User Administration API allows you to promote, demote, suspend, and unsuspend users on a GitHub Enterprise appliance. *It is only available to [authenticated](/v3/#authentication) site administrators.* Normal users will receive a `403` response if they try to access it.

## Promote an ordinary user to a site administrator

    PUT /user/:username/site_admin

<%= fetch_content(:put_content_length) %>

### Response

<%= headers 204 %>

## Demote a site administrator to an ordinary user

    DELETE /user/:username/site_admin

You can demote any user account except your own.

### Response

<%= headers 204 %>

## Suspend a user

    PUT /user/:username/suspended

You can suspend any user account except your own.

### Response

<%= headers 204 %>

## Unsuspend a user

    DELETE /user/:username/suspended

### Response

<%= headers 204 %>
