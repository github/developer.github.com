---
title: Repo Collaborators API v3 | developer.github.com
---

# Repo Collaborators API

## List

    GET /repos/:user/:repo/collaborators

### Response

<%= headers 200 %>
<%= json(:user) { |h| [h] } %>

## Get

    GET /repos/:user/:repo/collaborators/:user

### Reponse if user is a collaborator

<%= headers 204 %>

### Reponse if user is not a collaborator

<%= headers 404 %>

## Add collaborator

    PUT /repos/:user/:repo/collaborators/:user

### Response

<%= headers 204 %>

## Remove collaborator

    DELETE /repos/:user/:repo/collaborators/:user

### Response

<%= headers 204 %>
