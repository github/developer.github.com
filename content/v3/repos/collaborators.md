---
title: Repo Collaborators | GitHub API
---

# Repo Collaborators API

## List

    GET /repos/:user/:repo/collaborators

### Response

<%= headers 200 %>
<%= json(:user) { |h| [h] } %>

## Get

    GET /repos/:user/:repo/collaborators/:user

### Response if user is a collaborator

<%= headers 204 %>

### Response if user is not a collaborator

<%= headers 404 %>

## Add collaborator

    PUT /repos/:user/:repo/collaborators/:user

### Response

<%= headers 204 %>

## Remove collaborator

    DELETE /repos/:user/:repo/collaborators/:user

### Response

<%= headers 204 %>
