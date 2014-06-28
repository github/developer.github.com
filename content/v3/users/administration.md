---
title: User Administration | GitHub API
---

# User Administration

* TOC
{:toc}

These endpoints allow you to promote, demote, suspend, or unsuspend users on your GitHub Enterprise installation. *It is only available to site admins.* Normal users will receive a `403` response if they try to access it.

[The Users API](/v3/users/) has additional functionality that's available to both GitHub.com and GitHub Enterprise consumers.

## Promote an ordinary user to a site administrator

    PUT /user/:username/site_admin

### Response

<%= headers 204 %>

## Demote a site administrator to an ordinary user

    DELETE /user/:username/site_admin

### Response

<%= headers 204 %>

## Suspend a user

    PUT /user/:username/suspended

### Response

<%= headers 204 %>

## Unsuspend a user

    DELETE /user/:username/suspended

### Response

<%= headers 204 %>
