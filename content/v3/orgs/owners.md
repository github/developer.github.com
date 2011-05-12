---
title: Org Owners API v3 | developer.github.com
---

# Org Owners API

## List owners

List users in the owner's team. An owner is a user that has full access
to all repositories and admin rights to the organization. All actions
against the owners API require an authenticated user who is a member of
the `:org` being managed.

		GET /orgs/:org/owners

## Get owner

		GET /orgs/:org/owners/:user

### Reponse if user is an owner

<%= headers 204 %>

### Reponse if user is not an owner

<%= headers 404 %>

## Add owner

		POST /orgs/:org/owners/:user

## Remove owner

		DELETE /orgs/:org/owners/:user

