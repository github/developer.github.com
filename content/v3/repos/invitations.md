---
title: Repository Invitations
---

# Repository Invitations

{{#tip}}

We're currently offering a preview of the Repository Invitations API.

To access the API during the preview period, you must provide a custom [media type](/v3/media) in the `Accept` header:

```
application/vnd.github.swamp-thing-preview+json
```

{{/tip}}

{:toc}

<a id="invite" />		

## Invite a user to a repository		

Use the API endpoint for adding a collaborator [here](/v3/repos/collaborators).		

<a id="list" />

## List invitations for a repository

    GET /repositories/:repo_id/invitations

When authenticating as a user with admin rights to a repository, this endpoint will list all currently open repository invitations.

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:repository_invitation) { |h| [h] } %>

<a id="uninvite" />

## Delete a repository invitation

    DELETE /repositories/:repo_id/invitations/:invitation_id

### Response

<%= headers 204 %>

<a id="update" />

## Update a repository invitation

    PATCH /repositories/:repo_id/invitations/:invitation_id

### Input

Name | Type | Description
-----|------|--------------
`permissions`|`string` | The permissions that the associated user will have on the repository. Valid values are `read`, `write`, and `admin`.

### Response

<%= headers 200 %>
<%= json(:repository_invitation) %>

<a id="my-invitations" />

## List a user's repository invitations

    GET /user/repository_invitations

When authenticating as a user, this endpoint will list all currently open repository invitations for that user.

### Response

<%= headers 200 %>
<%= json(:repository_invitation) { |h| [h] } %>

<a id="accept" />

## Accept a repository invitation

    PATCH /user/repository_invitations/:invitation_id

### Response

<%= headers 204 %>

<a id="decline" />

## Decline a repository invitation

    DELETE /user/repository_invitations/:invitation_id

### Response

<%= headers 204 %>
