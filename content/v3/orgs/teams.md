---
title: Organization Teams
---

# Teams

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

{% if page.version == 'dotcom' or page.version >= 2.4 %}

In order to create a team, the authenticated user must be a member of `:org`.

{% else %}

In order to create a team, the authenticated user must be an owner of `:org`.

{% endif %}

    POST /orgs/:org/teams

### Parameters

{% if page.version == 'dotcom' or page.version >= 2.4 %}

Name | Type | Description
-----|------|--------------
`name`|`string` | **Required**. The name of the team.
`description`|`string` | The description of the team.
`repo_names`|`array` of `strings` | The full name (e.g., "organization-name/repository-name") of repositories to add the team to.
`privacy`|`string`| The level of privacy this team should have. Can be one of:<br/> * `secret` - only visible to organization owners and members of this team.<br/> * `closed` - visible to all members of this organization.<br/>Default: `secret`<br/>{% if page.version != 'dotcom' and page.version == 2.4 %}**This parameter requires a custom media type to be specified. Please see more in the alert below.**{% endif %}
`permission`|`string` | **Deprecated**. The permission that new repositories will be added to the team with when none is specified. Can be one of:<br/> * `pull` - team members can pull, but not push to or administer newly-added repositories.<br/> * `push` - team members can pull and push, but not administer newly-added repositories.<br/> * `admin` - team members can pull, push and administer newly-added repositories.<br/>Default: `pull`

{% if page.version != 'dotcom' and page.version > 2.3 and page.version < 2.6 %}

{{#tip}}

We're currently offering a preview period allowing applications to opt in to the Organization Permissions API. Please see the [blog post](/changes/2015-06-24-api-enhancements-for-working-with-organization-permissions/) for full details.

To access the API during the preview period, you must provide a custom [media type](/v3/media) in the `Accept` header:

```
application/vnd.github.ironman-preview+json
```

**Warning:** If you specify the `privacy` attribute on an organization that hasn't had [improved organization permissions](https://github.com/blog/2020-improved-organization-permissions) enabled yet, you will get a `422` error response.

{{/tip}}

{% endif %}

#### Example

<%= json \
  :name => 'new team',
  :description => 'team description',
  :privacy => 'closed' %>

{% else %}

Name | Type | Description
-----|------|--------------
`name`|`string` | **Required**. The name of the team.
`description`|`string` | The description of the team.
`repo_names`|`array` of `strings` | The full name (e.g., "organization-name/repository-name") of repositories to add the team to.
`permission`|`string` | The permission to grant the team. Can be one of:<br/> * `pull` - team members can pull, but not push to or administer these repositories.<br/> * `push` - team members can pull and push, but not administer these repositories.<br/> * `admin` - team members can pull, push and administer these repositories.<br/>Default: `pull`

#### Example

<%= json \
  :name => 'new team',
  :description => 'team description',
  :permission => 'push',
  :repo_names => ['github/dotfiles'] %>

{% endif %}

### Response

<%= headers 201 %>
<%= json(:full_team) %>

## Edit team

{% if page.version == 'dotcom' or page.version >= 2.4 %}

In order to edit a team, the authenticated user must either be an owner of
the org that the team is associated with, or a maintainer of the team.

{% else %}

In order to edit a team, the authenticated user must be an owner of the org that the team is associated with.

{% endif %}

    PATCH /teams/:id

{% if page.version == 'dotcom' or page.version >= 2.4 %}

### Parameters

Name | Type | Description
-----|------|--------------
`name`|`string` | **Required**. The name of the team.
`description`|`string` | The description of the team.
`privacy`|`string`| The level of privacy this team should have. Can be one of:<br/> * `secret` - only visible to organization owners and members of this team.<br/> * `closed` - visible to all members of this organization.<br/>Default: `secret`<br/>{% if page.version != 'dotcom' and page.version == 2.4 %}**This parameter requires a custom media type to be specified. Please see more in the alert below.**{% endif %}
`permission`|`string` | **Deprecated**. The permission that new repositories will be added to the team with when none is specified. Can be one of:<br/> * `pull` - team members can pull, but not push to or administer newly-added repositories.<br/> * `push` - team members can pull and push, but not administer newly-added repositories.<br/> * `admin` - team members can pull, push and administer newly-added repositories.<br/>Default: `pull`

{% if page.version != 'dotcom' and page.version > 2.3 and page.version < 2.6 %}

{{#tip}}

We're currently offering a preview period allowing applications to opt in to the Organization Permissions API. Please see the [blog post](/changes/2015-06-24-api-enhancements-for-working-with-organization-permissions/) for full details.

To access the API during the preview period, you must provide a custom [media type](/v3/media) in the `Accept` header:

```
application/vnd.github.ironman-preview+json
```

**Warning:** If you specify the `privacy` attribute on an organization that hasn't had [improved organization permissions](https://github.com/blog/2020-improved-organization-permissions) enabled yet, you will get a `422` error response.

{{/tip}}

{% endif %}

#### Example

<%= json \
  :name => 'new team name',
  :description => 'new team description',
  :privacy => 'closed' %>

{% else %}

### Parameters

Name | Type | Description
-----|------|--------------
`name`|`string` | **Required**. The name of the team.
`description`|`string` | The description of the team.
`permission`|`string` | The permission to grant the team. Can be one of:<br/> * `pull` - team members can pull, but not push to or administer these repositories.<br/> * `push` - team members can pull and push, but not administer these repositories.<br/> * `admin` - team members can pull, push and administer these repositories. Default: `pull`

#### Example

<%= json \
  :name => 'new team name',
  :description => 'new team description',
  :permission => 'push' %>

{% endif %}

### Response

<%= headers 200 %>
<%= json(:full_team) %>

## Delete team

In order to delete a team, the authenticated user must be an owner of
the org that the team is associated with{% if page.version == 'dotcom' or page.version >= 2.4 %}, or a maintainer of the team{% endif %}.

    DELETE /teams/:id

### Response

<%= headers 204 %>

## List team members

{% if page.version == 'dotcom' or page.version >= 2.4 %}

In order to list members in a team, the team must be visible to the
authenticated user.

{% else %}

In order to list members in a team, the authenticated user must be a member of the team.

{% endif %}

{% if page.version != 'dotcom' and page.version >= 2.3 %}

<%= fetch_content(:if_site_admin) %>
you will be able to list all members for the team.

{% endif %}

    GET /teams/:id/members

{% if page.version == 'dotcom' or page.version >= 2.4 %}

Name | Type | Description
-----|------|--------------
`role`|`string`| Filters members returned by their role in the team. Can be one of:<br/> * `member` - normal members of the team.<br/> * `maintainer` - team maintainers.<br/> * `all` - all members of the team.<br/>Default: `all`

{% endif %}

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:user) { |h| [h] } %>

## Get team member

### Deprecation notice

{{#tip}}

The "Get team member" API (described below) is
[deprecated](/v3/versions/#v3-deprecations) and is scheduled for
removal in the next major version of the API.

We recommend using the
[Get team membership API](/v3/orgs/teams/#get-team-membership)
instead. It allows you to get both active and pending memberships.

{{/tip}}

{% if page.version == 'dotcom' or page.version >= 2.4 %}

In order to list members in a team, the team must be visible to the authenticated user.

{% else %}

In order to get if a user is a member of a team, the authenticated user must be a member of the team.

{% endif %}

    GET /teams/:id/members/:username

### Response if user is a member

<%= headers 204 %>

### Response if user is not a member

<%= headers 404 %>

## Add team member

### Deprecation notice

{{#tip}}

The "Add team member" API (described below) is
[deprecated](/v3/versions/#v3-deprecations) and is scheduled for
removal in the next major version of the API.

We recommend using the
[Add team membership API](/v3/orgs/teams/#add-team-membership)
instead. It allows you to invite new organization members to your teams.

{{/tip}}

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

{{#tip}}

The "Remove team member" API (described below) is
[deprecated](/v3/versions/#v3-deprecations) and is scheduled for
removal in the next major version of the API.

We recommend using the
[Remove team membership API](/v3/orgs/teams/#remove-team-membership)
instead. It allows you to remove both active and pending memberships.

{{/tip}}

In order to remove a user from a team, the authenticated user must have
'admin' permissions to the team or be an owner of the org that the team
is associated with.
NOTE: This does not delete the user, it just removes them from the team.

    DELETE /teams/:id/members/:username

### Response

<%= headers 204 %>

## Get team membership

{% if page.version == 'dotcom' or page.version >= 2.4 %}

In order to get a user's membership with a team, the team must be visible to the
authenticated user.

{% else %}

In order to get a user's membership with a team, the authenticated user must be a member of the team or an owner of the team's organization.

{% endif %}

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

{% if page.version == 'dotcom' or page.version >= 2.4 %}

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

{% else %}

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

{% endif %}

    PUT /teams/:id/memberships/:username

### Parameters

Name | Type | Description
-----|------|--------------
`role`|`string`| The role that this user should have in the team. Can be one of:<br/> * `member` - a normal member of the team.<br/> * `maintainer` - a team maintainer. Able to add/remove other team members, promote other team members to team maintainer, and edit the team's name and description.<br/>Default: `member`

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

{% if page.version != 'dotcom' and page.version >= 2.3 %}

<%= fetch_content(:if_site_admin) %>
you will be able to list all repositories for the team.

{% endif %}

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:repo) { |h| [h] } %>

## Check if a team manages a repository

    GET /teams/:id/repos/:owner/:repo

### Response if repository is managed by this team

<%= headers 204 %>

### Response if repository is not managed by this team

<%= headers 404 %>

{% if page.version == 'dotcom' or page.version >= 2.4 %}

### Alternative response with extra repository information

You can also get information about the specified repository, including what
permissions the team grants on it, by passing the following custom
[media type](/v3/media/) via the `Accept` header:

    Accept: application/vnd.github.v3.repository+json

{% endif %}

<%= headers 200 %>
<%= json :repo %>

## Add or update team repository

{% if page.version == 'dotcom' or page.version >= 2.4 %}

In order to add a repository to a team or update the team's permission on a repository, the authenticated user must have admin access to the repository, and must be able to see the team. Also, the repository must be owned by the organization, or a direct fork of a repository owned by the organization.

{% else %}

In order to add a repository to a team, the authenticated user must have admin
access to the repository, and must be able to see the team. Also, the repository
must be owned by the organization, or a direct fork of a repository owned by the
organization.

{% endif %}

    PUT /teams/:id/repos/:org/:repo

{% if page.version == 'dotcom' or page.version >= 2.4 %}

### Parameters

Name | Type | Description
-----|------|--------------
`permission`|`string` | The permission to grant the team on this repository. Can be one of:<br/> * `pull` - team members can pull, but not push to or administer this repository.<br/> * `push` - team members can pull and push, but not administer this repository.<br/> * `admin` - team members can pull, push and administer this repository.<br/><br/>If no permission is specified, the team's `permission` attribute will be used to determine what permission to grant the team on this repository.

<%= fetch_content(:optional_put_content_length) %>

{% endif %}


{% if page.version != 'dotcom' and page.version > 2.3 and page.version < 2.6 %}

{{#tip}}

We're currently offering a preview period allowing applications to opt in to the Organization Permissions API. Please see the [blog post](/changes/2015-06-24-api-enhancements-for-working-with-organization-permissions/) for full details.

To access the API during the preview period, you must provide a custom [media type](/v3/media) in the `Accept` header:

```
application/vnd.github.ironman-preview+json
```

**Warning:** If you specify the `permission` attribute on an organization that hasn't had [improved organization permissions](https://github.com/blog/2020-improved-organization-permissions) enabled yet, you will get a `422` error response.

{{/tip}}

{% endif %}

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

<a id="remove-team-repo" />

## Remove team repository

{% if page.version == 'dotcom' or page.version >= 2.4 %}

In order to remove a repository from a team, the authenticated user must have
admin access to the repository or be a maintainer of the team.
NOTE: This does not delete the repository, it just removes it from the team.

{% else %}

In order to remove a repository from a team, the authenticated user must be an owner of the org that the team is associated with. Also, since the Owners team always has access to all repositories in the organization, repositories cannot be removed from the Owners team.

{% endif %}

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
