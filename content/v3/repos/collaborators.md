---
title: Collaborators | GitHub API
---

# Collaborators

* TOC
{:toc}

## List a repo's collaborators {#list}

    GET /repos/:owner/:repo/collaborators

When authenticating as an organization owner of an organization-owned
repository, all organization owners are included in the list of collaborators.
Otherwise, only users with access to the repository are returned in the
collaborators list.

### Response

<%= headers 200 %>
<%= json(:user) { |h| [h] } %>

## Check if a user is a repo collaborator {#get}

    GET /repos/:owner/:repo/collaborators/:user

### Response if user is a collaborator

<%= headers 204 %>

### Response if user is not a collaborator

<%= headers 404 %>

## Add collaborator to a repo {#add-collaborator}

    PUT /repos/:owner/:repo/collaborators/:user

### Response

<%= headers 204 %>

## Remove collaborator from a repo {#remove-collaborator}

    DELETE /repos/:owner/:repo/collaborators/:user

### Response

<%= headers 204 %>
