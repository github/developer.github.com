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

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:team) { |h| [h] } %>

## Get team

    GET /teams/:id

### Response

<%= headers 200 %>
<%= json(:full_team) %>

## Create team

In order to create a team, the authenticated user must be a member of
`:org`.

    POST /orgs/:org/teams

### Parameters

Name | Type | Description
-----|------|--------------
`name`|`string` | **Required**. The name of the team.
`description`|`string` | The description of the team.
`repo_names`|`array` of `strings` | The repositories to add the team to.
`privacy`|`string`| The level of privacy this team should have. Can be one of:<br/> * `secret` - only visible to organization owners and members of this team.<br/> * `closed` - visible to all members of this organization.<br/>Default: `secret`<br/>**This parameter requires a custom media type to be specified. Please see more in the alert below.**
`permission`|`string` | **Deprecated**. In the preview period described in the alert below, a team's `permission` attribute no longer dictates what permission it has on its repositories; it only dictates what permission the repositories in this request will be added with, and what permission a new repository will be added to the team with if none is specified by the user. Avoid confusion by specifying a `permission` when using the [Add team repository](/v3/orgs/teams/#add-team-repo) API instead.<br/><br/>The permission to grant the team. Can be one of:<br/> * `pull` - team members can pull, but not push to or administer these repositories.<br/> * `push` - team members can pull and push, but not administer these repositories.<br/> * `admin` - team members can pull, push and administer these repositories.<br/>Default: `pull`

<div class="alert">
  <p>
    We're currently offering a preview period allowing applications to opt in to the Organization Permissions API. Please see the <a href="/changes/2015-06-24-api-enhancements-for-working-with-organization-permissions/">blog post</a> for full details.
  </p>

  <p>
    To access the API during the preview period, you must provide a custom <a href="/v3/media">media type</a> in the <code>Accept</code> header:
    <pre>application/vnd.github.ironman-preview+json</pre>
  </p>

  <p>
    <strong>Warning:</strong> If you specify the <code>privacy</code> attribute on an organization that hasn't had <a href="https://github.com/blog/2020-improved-organization-permissions">improved organization permissions</a> enabled yet, you will get a <code>422</code> error response.
  </p>
</div>

#### Example

<%= json \
  :name => 'new team',
  :description => 'team description',
  :privacy => 'closed' %>

### Response

<%= headers 201 %>
<%= json(:full_team) %>

## Edit team

In order to edit a team, the authenticated user must either be an owner of
the org that the team is associated with, or a maintainer of the team.

    PATCH /teams/:id

### Parameters

Name | Type | Description
-----|------|--------------
`name`|`string` | **Required**. The name of the team.
`description`|`string` | The description of the team.
`privacy`|`string`| The level of privacy this team should have. Can be one of:<br/> * `secret` - only visible to organization owners and members of this team.<br/> * `closed` - visible to all members of this organization.<br/>Default: `secret`<br/>**This parameter requires a custom media type to be specified. Please see more in the alert below.**
`permission`|`string` | **Deprecated**. In the preview period described in the alert below, a team's `permission` attribute no longer dictates what permission it has on its repositories; it only dictates what permission a new repository will be added to the team with if none is specified by the user. Avoid confusion by specifying a `permission` when using the [Add team repository](/v3/orgs/teams/#add-team-repo) API instead.<br/><br/>The permission to grant the team. Can be one of:<br/> * `pull` - team members can pull, but not push to or administer these repositories.<br/> * `push` - team members can pull and push, but not administer these repositories.<br/> * `admin` - team members can pull, push and administer these repositories. Default: `pull`

<div class="alert">
  <p>
    We're currently offering a preview period allowing applications to opt in to the Organization Permissions API. Please see the <a href="/changes/2015-06-24-api-enhancements-for-working-with-organization-permissions/">blog post</a> for full details.
  </p>

  <p>
    To access the API during the preview period, you must provide a custom <a href="/v3/media">media type</a> in the <code>Accept</code> header:
    <pre>application/vnd.github.ironman-preview+json</pre>
  </p>

  <p>
    <strong>Warning:</strong> If you specify the <code>privacy</code> attribute on an organization that hasn't had <a href="https://github.com/blog/2020-improved-organization-permissions">improved organization permissions</a> enabled yet, you will get a <code>422</code> error response.
  </p>
</div>

#### Example

<%= json \
  :name => 'new team name',
  :description => 'new team description',
  :privacy => 'closed' %>

### Response

<%= headers 200 %>
<%= json(:full_team) %>

## Delete team

In order to delete a team, the authenticated user must be an owner of
the org that the team is associated with, or a maintainer of the team.

    DELETE /teams/:id

### Response

<%= headers 204 %>

## List team members

In order to list members in a team, the team must be visible to the
authenticated user.

{{#enterprise-only}}

<%= fetch_content(:if_site_admin) %>
you will be able to list all members for the team.

{{/enterprise-only}}

    GET /teams/:id/members

Name | Type | Description
-----|------|--------------
`role`|`string`| Filters members returned by their role in the team. Can be one of:<br/> * `member` - normal members of the team.<br/> * `maintainer` - team maintainers.<br/> * `all` - all members of the team.<br/>Default: `all`<br/>**This parameter requires a custom media type to be specified. Please see more in the alert below.**

<div class="alert">
  <p>
    We're currently offering a preview period allowing applications to opt in to the Organization Permissions API. Please see the <a href="/changes/2015-06-24-api-enhancements-for-working-with-organization-permissions/">blog post</a> for full details.
  </p>

  <p>
    To access the API during the preview period, you must provide a custom <a href="/v3/media">media type</a> in the <code>Accept</code> header:
    <pre>application/vnd.github.ironman-preview+json</pre>
  </p>
</div>

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:user) { |h| [h] } %>

## Get team member

### Deprecation notice

<div class="alert">
  <p>
    The "Get team member" API (described below) is
    <a href="/v3/versions/#v3-deprecations">deprecated</a> and is scheduled for
    removal in the next major version of the API.

    We recommend using the
    <a href="/v3/orgs/teams/#get-team-membership">Get team membership API</a>
    instead. It allows you to get both active and pending memberships.
  </p>
</div>

In order to list members in a team, the team must be visible to the
authenticated user.

    GET /teams/:id/members/:username

### Response if user is a member

<%= headers 204 %>

### Response if user is not a member

<%= headers 404 %>

## Add team member

{{#not-enterprise}}

### Deprecation notice

<div class="alert">
  <p>
    The "Add team member" API (described below) is
    <a href="/v3/versions/#v3-deprecations">deprecated</a> and is scheduled for
    removal in the next major version of the API.

    We recommend using the
    <a href="/v3/orgs/teams/#add-team-membership">Add team membership API</a>
    instead. It allows you to invite new organization members to your teams.
  </p>
</div>

{{#not-enterprise}}

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
  json :message => "Cannot add an organization as a member.",
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
  json :message => "User isn't a member of this organization. Please invite them first.",
    :errors => [{
      :code     => "unaffiliated",
      :field    => :user,
      :resource => :TeamMember
    }]
%>

## Remove team member

### Deprecation notice

<div class="alert">
  <p>
    The "Remove team member" API (described below) is
    <a href="/v3/versions/#v3-deprecations">deprecated</a> and is scheduled for
    removal in the next major version of the API.

    We recommend using the
    <a href="/v3/orgs/teams/#remove-team-membership">Remove team membership API</a>
    instead. It allows you to remove both active and pending memberships.
  </p>
</div>

In order to remove a user from a team, the authenticated user must have
'admin' permissions to the team or be an owner of the org that the team
is associated with.
NOTE: This does not delete the user, it just removes them from the team.

    DELETE /teams/:id/members/:username

### Response

<%= headers 204 %>

## Get team membership

In order to get a user's membership with a team, the team must be visible to the
authenticated user.

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

If the user is already a member of the team's organization, this endpoint will
add the user to the team. In order to add a membership between an organization
member and a team, the authenticated user must be an organization owner or a
maintainer of the team.

If the user is unaffiliated with the team's organization, this endpoint will
send an invitation to the user via email. This newly-created membership will be
in the "pending" state until the user accepts the invitation, at which point the
membership will transition to the "active" state and the user will be added as a
member of the team. In order to add a membership between an unaffiliated user
and a team, the authenticated user must be an organization owner.

    PUT /teams/:id/memberships/:username

### Parameters

Name | Type | Description
-----|------|--------------
`role`|`string`| The role that this user should have in the team. Can be one of:<br/> * `member` - a normal member of the team.<br/> * `maintainer` - a team maintainer. Able to add/remove other team members, promote other team members to team maintainer, and edit the team's name and description.<br/>Default: `member`<br/>**This parameter requires a custom media type to be specified. Please see more in the alert below.**

<div class="alert">
  <p>
    We're currently offering a preview period allowing applications to opt in to the Organization Permissions API. Please see the <a href="/changes/2015-06-24-api-enhancements-for-working-with-organization-permissions/">blog post</a> for full details.
  </p>

  <p>
    To access the API during the preview period, you must provide a custom <a href="/v3/media">media type</a> in the <code>Accept</code> header:
    <pre>application/vnd.github.ironman-preview+json</pre>
  </p>

  <p>
    <strong>Warning:</strong> If you specify the <code>role</code> attribute on an organization that hasn't had <a href="https://github.com/blog/2020-improved-organization-permissions">improved organization permissions</a> enabled yet, you will get a <code>422</code> error response.
  </p>
</div>

### Response if user's membership with team is now active

<%= headers 200 %>
<%= json(:active_team_membership) %>

### Response if user's membership with team is now pending

<%= headers 200 %>
<%= json(:pending_team_membership) %>

If you attempt to add an organization to a team, you will get this:

<%= headers 422 %>
<%=
  json :message => "Cannot add an organization as a member.",
    :errors => [{
      :code     => "org",
      :field    => :user,
      :resource => :TeamMember
    }]
%>

## Remove team membership

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

{{#enterprise-only}}

<%= fetch_content(:if_site_admin) %>
you will be able to list all repositories for the team.

{{/enterprise-only}}

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:repo) { |h| [h] } %>

## Check if a team manages a repository {#get-team-repo}

    GET /teams/:id/repos/:owner/:repo

### Response if repository is managed by this team

<%= headers 204 %>

### Response if repository is not managed by this team

<%= headers 404 %>

### Alternative response with extra repository information

<div class="alert">
  <p>
    We're currently offering a preview period allowing applications to opt in to the Organization Permissions API. Please see the <a href="/changes/2015-06-24-api-enhancements-for-working-with-organization-permissions/">blog post</a> for full details.
  </p>

  <p>
    To access the API during the preview period, you must provide a custom <a href="/v3/media">media type</a> in the <code>Accept</code> header:
    <pre>application/vnd.github.ironman-preview+json</pre>
  </p>
</div>

You can also get information about the specified repository, including what
permissions the team grants on it, by passing the following custom
[media type](/v3/media/) via the `Accept` header:

    Accept: application/vnd.github.ironman-preview.repository+json

<%= headers 200 %>
<%= json :repo %>

## Add team repository {#add-team-repo}

In order to add a repository to a team, the authenticated user must have admin
access to the repository, and must be able to see the team. Also, the repository
must be owned by the organization, or a direct fork of a repository owned by the
organization.

    PUT /teams/:id/repos/:org/:repo

### Parameters

Name | Type | Description
-----|------|--------------
`permission`|`string` | The permission to grant the team on this repository. Can be one of:<br/> * `pull` - team members can pull, but not push to or administer this repository.<br/> * `push` - team members can pull and push, but not administer this repository.<br/> * `admin` - team members can pull, push and administer this repository.<br/><br/>If no permission is specified, the team's `permission` attribute will be used to determine what permission to grant the team on this repository.<br/><br/>**This parameter requires a custom media type to be specified. Please see more in the alert below.**

<%= fetch_content(:optional_put_content_length) %>

<div class="alert">
  <p>
    We're currently offering a preview period allowing applications to opt in to the Organization Permissions API. Please see the <a href="/changes/2015-06-24-api-enhancements-for-working-with-organization-permissions/">blog post</a> for full details.
  </p>

  <p>
    To access the API during the preview period, you must provide a custom <a href="/v3/media">media type</a> in the <code>Accept</code> header:
    <pre>application/vnd.github.ironman-preview+json</pre>
  </p>

  <p>
    <strong>Warning:</strong> If you specify the <code>permission</code> attribute on an organization that hasn't had <a href="https://github.com/blog/2020-improved-organization-permissions">improved organization permissions</a> enabled yet, you will get a <code>422</code> error response.
  </p>
</div>

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

In order to remove a repository from a team, the authenticated user must have
admin access to the repository or be a maintainer of the team.
NOTE: This does not delete the repository, it just removes it from the team.

    DELETE /teams/:id/repos/:owner/:repo

### Response

<%= headers 204 %>

## List user teams

List all of the teams across all of the organizations to which the
authenticated user belongs. This method requires `user`, `repo`, or
`read:org` [scope][] when authenticating via [OAuth][].

    GET /user/teams

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:full_team) { |h| [h] } %>

[OAuth]: /v3/oauth/
[scope]: /v3/oauth/#scopes
