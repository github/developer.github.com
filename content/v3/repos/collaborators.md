---
title: Collaborators
---

# Collaborators

{:toc}

<a id="list" />

## List collaborators

    GET /repos/:owner/:repo/collaborators

When authenticating as an organization owner of an organization-owned
repository, all organization owners are included in the list of collaborators.
Otherwise, only users with access to the repository are returned in the
collaborators list.

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:collaborator) { |h| [h] } %>

## Check if a user is a collaborator

    GET /repos/:owner/:repo/collaborators/:username

### Response if user is a collaborator

<%= headers 204 %>

### Response if user is not a collaborator

<%= headers 404 %>

## Add user as a collaborator

    PUT /repos/:owner/:repo/collaborators/:username

### Parameters

Name | Type | Description
-----|------|--------------
`permission`|`string` | The permission to grant the collaborator. **Only valid on organization-owned repositories.** Can be one of:<br/> * `pull` - can pull, but not push to or administer this repository.<br/> * `push` - can pull and push, but not administer this repository.<br/> * `admin` -  can pull, push and administer this repository.<br/>Default: `pull`

<%= fetch_content(:optional_put_content_length) %>

### Response

<%= headers 204 %>

## Remove user as a collaborator

    DELETE /repos/:owner/:repo/collaborators/:username

### Response

<%= headers 204 %>
