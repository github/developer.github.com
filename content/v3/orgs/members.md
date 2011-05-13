---
title: Org Members API v3 | developer.github.com
---

# Org Members API

## List members

List all users who are members of an organization. A member is a user
that belongs to at least 1 team in the organization. If the authenticated user is
also a member of this organization then both concealed and public
members will be returned. Otherwise only public members are returned.

		GET /orgs/:org/members

## Get member

		GET /orgs/:org/members/:user

### Reponse if user is a member

<%= headers 204 %>

### Reponse if user is not a member

<%= headers 404 %>

## Add a member

		PUT /orgs/:org/members/:user

## Remove a member

		DELETE /orgs/:org/members/:user
