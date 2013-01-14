---
title: Repo Collaborators | GitHub API
---

# Repo Collaborators API

* TOC
{:toc}

## List

    GET /repos/:owner/:repo/collaborators

When authenticating as an organization owner of an organization-owned
repository, all organization owners are included in the list of collaborators.
Otherwise, only users with access to the repository are returned in the
collaborators list.

### Response

<%= headers 200 %>
<%= json(:user) { |h| [h] } %>

## Get

    GET /repos/:owner/:repo/collaborators/:user

### Response if user is a collaborator

<%= headers 204 %>

### Response if user is not a collaborator

<%= headers 404 %>

## Add collaborator

    PUT /repos/:owner/:repo/collaborators/:user

### Response

<%= headers 204 %>

## Remove collaborator

    DELETE /repos/:owner/:repo/collaborators/:user

### Response

<%= headers 204 %>
