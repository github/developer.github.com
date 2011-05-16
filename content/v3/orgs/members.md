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

To add someone as a member to an org, you must add them to a team.

## Remove a member

Removing a user from this list will remove them from all teams and
they will no longer have any access to the organization's repositories.

    DELETE /orgs/:org/members/:user

## List public members

Members of an organization can choose to have their membership
publicized or not.

    GET /orgs/:org/public_members

## Get if a user is a public member

    GET /orgs/:org/public_members/:user

### Reponse if user is a public member

<%= headers 204 %>

### Reponse if user is not a public member

<%= headers 404 %>

## Publicize a user's membership

    PUT /orgs/:org/public_members/:user

## Conceal a user's membership

    DELETE /orgs/:org/public_members/:user

## Response

<%= headers 204 %>
