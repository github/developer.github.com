---
title: Org Teams API v3 | developer.github.com
---

# Org Teams API

All actions against teams require an authenticated user who is a member
of the `:org` being managed.

## List teams

		GET /orgs/:org/teams

## Create team

		POST /orgs/:org/teams

## Get team

		GET /orgs/:org/teams/:team

## Edit team

		PATCH /orgs/:org/teams/:team

## Delete team

		DELETE /orgs/:org/teams/:team

## List team members

		GET /orgs/:org/teams/:team/members

## Get team member

		GET /orgs/:org/teams/:team/members/:user

### Reponse if user is a member

<%= headers 204 %>

### Reponse if user is not a member

<%= headers 404 %>

## Add team member

		POST /orgs/:org/teams/:team/members/:user

## Remove team member

This does not delete the user, it just remove them from the team.

		DELETE /orgs/:org/teams/:team/members/:user

## List team repos

		GET /orgs/:org/teams/:team/repos

## Get team repo

		GET /orgs/:org/teams/:team/repos/:repo

### Reponse if repo is managed by this team

<%= headers 204 %>

### Reponse if repo is not managed by this team

<%= headers 404 %>

## Add team repo

		POST /orgs/:org/teams/:team/repos/:repo

## Remove team repo

This does not delete the repo, it just removes it from the team.

		DELETE/orgs/:org/teams/:team/repos/:repo

