---
title: Organization Teams | GitHub API
---

# Org Teams API

* TOC
{:toc}

All actions against teams require at a minimum an authenticated user who
is a member of the Owners team in the `:org` being managed. Additionally,
OAuth users require "user" [scope](/v3/oauth/#scopes).

## List teams

    GET /orgs/:org/teams

### Response

<%= headers 200 %>
<%= json(:team) { |h| [h] } %>

## Get team

    GET /teams/:id

### Response

<%= headers 200 %>
<%= json(:full_team) %>

## Create team

In order to create a team, the authenticated user must be an owner of
`:org`.

    POST /orgs/:org/teams

### Input

name
: _Required_ **string**

repo\_names
: _Optional_ **array** of **strings**

permission
: _Optional_ **string**

  `pull` - team members can pull, but not push to or administer these
  repositories. **Default**

  `push` - team members can pull and push, but not administer these
  repositories.

  `admin` - team members can pull, push and administer these
  repositories.

<%= json \
  :name => 'new team',
  :permission => 'push',
  :repo_names => ['github/dotfiles'] %>

### Response

<%= headers 201 %>
<%= json(:full_team) %>

## Edit team

In order to edit a team, the authenticated user must be an owner of
the org that the team is associated with.

    PATCH /teams/:id

### Input

name
: _Required_ **string**

permission
: _Optional_ **string**

<%= json \
  :name => 'new team name',
  :permission => 'push' %>

### Response

<%= headers 200 %>
<%= json(:full_team) %>

## Delete team

In order to delete a team, the authenticated user must be an owner of
the org that the team is associated with.

    DELETE /teams/:id

### Response

<%= headers 204 %>

## List team members

In order to list members in a team, the authenticated user must be a
member of the team.

    GET /teams/:id/members

### Response

<%= headers 200 %>
<%= json(:user) { |h| [h] } %>

## Get team member

In order to get if a user is a member of a team, the authenticated user
must be a member of the team.

    GET /teams/:id/members/:user

### Response if user is a member

<%= headers 204 %>

### Response if user is not a member

<%= headers 404 %>

## Add team member

In order to add a user to a team, the authenticated user must have
'admin' permissions to the team or be an owner of the org that the team
is associated with.

    PUT /teams/:id/members/:user

### Response

<%= headers 204 %>

If you attempt to add an organization to a team, you will get this:

<%= headers 422 %>
<%=
  json :message => "Validation Failed",
    :errors => [{
      :code     => "org",
      :field    => :user,
      :resource => :TeamMember
    }]
%>

## Remove team member

In order to remove a user from a team, the authenticated user must have
'admin' permissions to the team or be an owner of the org that the team
is associated with.
NOTE: This does not delete the user, it just remove them from the team.

    DELETE /teams/:id/members/:user

### Response

<%= headers 204 %>

## List team repos

    GET /teams/:id/repos

### Response

<%= headers 200 %>
<%= json(:repo) { |h| [h] } %>

## Get team repo

    GET /teams/:id/repos/:owner/:repo

### Response if repo is managed by this team

<%= headers 204 %>

### Response if repo is not managed by this team

<%= headers 404 %>

## Add team repo

In order to add a repo to a team, the authenticated user must be an
owner of the org that the team is associated with.  Also, the repo must
be owned by the organization, or a direct fork of a repo owned by the
organization.

    PUT /teams/:id/repos/:org/:repo

### Response

<%= headers 204 %>

If you attempt to add a repo to a team that is not owned by the
organization, you get:

<%= headers 422 %>
<%=
  json :message => "Validation Failed",
    :errors => [{
      :code     => "not_owned",
      :field    => :repository,
      :resource => :TeamMember}]
%>

## Remove team repo

In order to remove a repo from a team, the authenticated user must be an
owner of the org that the team is associated with.
NOTE: This does not delete the repo, it just removes it from the team.

    DELETE /teams/:id/repos/:owner/:repo

### Response

<%= headers 204 %>

