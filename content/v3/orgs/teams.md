---
title: Org Teams API v3 | developer.github.com
---

# Org Teams API

All actions against teams require an authenticated user who is a member
of the owner's team in the `:org` being managed.

## List teams

		GET /orgs/:org/teams

## Create team

		POST /orgs/:org/teams

## Get team

		GET /teams/:id

## Edit team

		PATCH /teams/:id

## Delete team

		DELETE /teams/:id

## List team members

		GET /teams/:id/members

## Get team member

		GET /teams/:id/members/:user

### Reponse if user is a member

<%= headers 204 %>

### Reponse if user is not a member

<%= headers 404 %>

## Add team member

		PUT /teams/:id/members/:user

## Remove team member

This does not delete the user, it just remove them from the team.

		DELETE /teams/:id/members/:user

## List team repos

		GET /teams/:id/repos

## Get team repo

		GET /teams/:id/repos/:repo

### Reponse if repo is managed by this team

<%= headers 204 %>

### Reponse if repo is not managed by this team

<%= headers 404 %>

## Add team repo

		PUT /teams/:id/repos/:repo

## Remove team repo

This does not delete the repo, it just removes it from the team.

		DELETE /teams/:id/repos/:repo

