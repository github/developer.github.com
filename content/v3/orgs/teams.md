---
title: Organization Teams | GitHub API
---

# Teams

* TOC
{:toc}

All actions against teams require at a minimum an authenticated user who
is a member of the Owners team in the `:org` being managed. Additionally,
OAuth users require the "read:org" [scope](/v3/oauth/#scopes).

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

### Parameters

Name | Type | Description
-----|------|--------------
`name`|`string` | **Required**. The name of the team.
`repo_names`|`array` of `strings` | The repositories to add the team to.
`permission`|`string` | The permission to grant the team. Can be one of:<br/> * `pull` - team members can pull, but not push to or administer these repositories.<br/> * `push` - team members can pull and push, but not administer these repositories.<br/> * `admin` - team members can pull, push and administer these repositories.<br/>Default: `pull`

#### Example

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

### Parameters

Name | Type | Description
-----|------|--------------
`name`|`string` | **Required**. The name of the team.
`permission`|`string` | The permission to grant the team. Can be one of:<br/> * `pull` - team members can pull, but not push to or administer these repositories.<br/> * `push` - team members can pull and push, but not administer these repositories.<br/> * `admin` - team members can pull, push and administer these repositories. Default: `pull`

#### Example

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

    GET /teams/:id/members/:username

### Response if user is a member

<%= headers 204 %>

### Response if user is not a member

<%= headers 404 %>

## Add team member

In order to add a user to a team, the authenticated user must have
'admin' permissions to the team or be an owner of the organization that the team
is associated with, and the user being added must already be a member of at
least one other team on the same organization.

    PUT /teams/:id/members/:username

<%= fetch_content(:put_content_length) %>

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

If you attempt to add a user to a team and that user is not a member of at least
one other team on the same organization, you will get this:

<%= headers 422 %>
<%=
  json :message => "Validation Failed",
    :errors => [{
      :code     => "unaffiliated",
      :field    => :user,
      :resource => :TeamMember
    }]
%>

## Remove team member

In order to remove a user from a team, the authenticated user must have
'admin' permissions to the team or be an owner of the org that the team
is associated with.
NOTE: This does not delete the user, it just removes them from the team.

    DELETE /teams/:id/members/:username

### Response

<%= headers 204 %>

## Get team membership

<div class="alert">
  <p>
    The Team Memberships API is currently available for developers to preview.
    During the preview period, the API may change without notice.
    Please see the <a href="/changes/2014-08-05-team-memberships-api/">blog post</a> for full details.
  </p>

  <p>
    To access the API during the preview period, you must provide a custom <a href="/v3/media">media type</a> in the <code>Accept</code> header:
    <pre>application/vnd.github.the-wasp-preview+json</pre>
  </p>
</div>

In order to get a user's membership with a team, the authenticated user must be
a member of the team or an owner of the team's organization.

    GET /teams/:id/memberships/:username

### Response if user has an active membership with team

<%= headers 200 %>
<%= json(:active_team_membership) %>

### Response if user has a pending membership with team

<%= headers 200 %>
<%= json(:pending_team_membership) %>

### Response if user has no membership with team

<%= headers 404 %>

## Add team membership

<div class="alert">
  <p>
    The Team Memberships API is currently available for developers to preview.
    During the preview period, the API may change without notice.
    Please see the <a href="/changes/2014-08-05-team-memberships-api/">blog post</a> for full details.
  </p>

  <p>
    To access the API during the preview period, you must provide a custom <a href="/v3/media">media type</a> in the <code>Accept</code> header:
    <pre>application/vnd.github.the-wasp-preview+json</pre>
  </p>
</div>

In order to add a membership between a user and a team, the authenticated user
must have 'admin' permissions to the team or be an owner of the organization
that the team is associated with.

If the user is already a part of the team's organization (meaning they're on at
least one other team in the organization), this endpoint will add the user to
the team.

If the user is completely unaffiliated with the team's organization (meaning
they're on none of the organization's teams), this endpoint will send an
invitation to the user via email. This newly-created membership will be in the
"pending" state until the user accepts the invitation, at which point the
membership will transition to the "active" state and the user will be added as a
member of the team.

    PUT /teams/:id/memberships/:username

### Response if user's membership with team is now active

<%= headers 200 %>
<%= json(:active_team_membership) %>

### Response if user's membership with team is now pending

<%= headers 200 %>
<%= json(:active_team_membership) %>

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

## Remove team membership

<div class="alert">
  <p>
    The Team Memberships API is currently available for developers to preview.
    During the preview period, the API may change without notice.
    Please see the <a href="/changes/2014-08-05-team-memberships-api/">blog post</a> for full details.
  </p>

  <p>
    To access the API during the preview period, you must provide a custom <a href="/v3/media">media type</a> in the <code>Accept</code> header:
    <pre>application/vnd.github.the-wasp-preview+json</pre>
  </p>
</div>

In order to remove a membership between a user and a team, the authenticated
user must have 'admin' permissions to the team or be an owner of the
organization that the team is associated with.
NOTE: This does not delete the user, it just removes their membership from the
team.

    DELETE /teams/:id/memberships/:username

### Response

<%= headers 204 %>

## List team repos

    GET /teams/:id/repos

### Response

<%= headers 200 %>
<%= json(:repo) { |h| [h] } %>

## Check if a team manages a repository {#get-team-repo}

    GET /teams/:id/repos/:owner/:repo

### Response if repository is managed by this team

<%= headers 204 %>

### Response if repository is not managed by this team

<%= headers 404 %>

## Add team repository {#add-team-repo}

In order to add a repository to a team, the authenticated user must be an
owner of the org that the team is associated with.  Also, the repository must
be owned by the organization, or a direct fork of a repository owned by the
organization.

    PUT /teams/:id/repos/:org/:repo

<%= fetch_content(:put_content_length) %>

### Response

<%= headers 204 %>

If you attempt to add a repository to a team that is not owned by the
organization, you get:

<%= headers 422 %>
<%=
  json :message => "Validation Failed",
    :errors => [{
      :code     => "not_owned",
      :field    => :repository,
      :resource => :TeamMember}]
%>

## Remove team repository {#remove-team-repo}

In order to remove a repository from a team, the authenticated user must be an
owner of the org that the team is associated with. Also, since the Owners team
always has access to all repositories in the organization, repositories cannot
be removed from the Owners team.
NOTE: This does not delete the repository, it just removes it from the team.

    DELETE /teams/:id/repos/:owner/:repo

### Response

<%= headers 204 %>

## List user teams

List all of the teams across all of the organizations to which the
authenticated user belongs. This method requires `user` or `repo`
[scope][] when authenticating via [OAuth][].

    GET /user/teams

### Response

<%= headers 200 %>
<%= json(:full_team) { |h| [h] } %>

[OAuth]: /v3/oauth/
[scope]: /v3/oauth/#scopes
