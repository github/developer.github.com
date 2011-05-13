---
title: Repo Collaboratos API v3 | developer.github.com
---

# Repo Collaboratos API

## List

		GET /repos/:repo/collaborators

## Get

		GET /repos/:repo/collaborators/:user

### Reponse if user is a collaborator

<%= headers 204 %>

### Reponse if user is not a collaborator

<%= headers 404 %>

## Add collaborator

		PUT /repos/:repo/collaborators/:user

## Remove collaborator

		DELETE /repos/:repo/collaborators/:user

