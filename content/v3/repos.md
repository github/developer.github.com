---
title: Repos | GitHub API
---

# Repos API

## List your repositories

List repositories for the authenticated user.

    GET /user/repos

### Parameters

type
: `all`, `owner`, `public`, `private`, `member`. Default: `all`.

## List user repositories

List public repositories for the specified user.

    GET /users/:user/repos

### Parameters

type
: `all`, `owner`, `member`. Default: `public`.

## List organization repositories.

List repositories for the specified org.

    GET /orgs/:org/repos

### Parameters

type
: `all`, `public`, `member`. Default: `all`.

### Parameters

type
: `all`, `public`, `private`. Default: `all`.

### Response

<%= headers 200, :pagination => true %>
<%= json(:repo) { |h| [h] } %>

## Create

Create a new repository for the authenticated user.

    POST /user/repos

Create a new repository in this organization. The authenticated user must
be a member of `:org`.

    POST /orgs/:org/repos

### Input

name
: _Required_ **string**

description
: _Optional_ **string**

homepage
: _Optional_ **string**

private
: _Optional_ **boolean** - `true` to create a private repository, `false`
to create a public one. Creating private repositories requires a paid
GitHub account.  Default is `false`.

has\_issues
: _Optional_ **boolean** - `true` to enable issues for this repository,
`false` to disable them. Default is `true`.

has\_wiki
: _Optional_ **boolean** - `true` to enable the wiki for this
repository, `false` to disable it. Default is `true`.

has\_downloads
: _Optional_ **boolean** - `true` to enable downloads for this
repository, `false` to disable them. Default is `true`.

team\_id
: _Optional_ **number** - The id of the team that will be granted access
to this repository. This is only valid when creating a repo in an
organization.

<%= json \
  :name          => "Hello-World",
  :description   => "This is your first repo",
  :homepage      => "https://github.com",
  :private       => false,
  :has_issues    => true,
  :has_wiki      => true,
  :has_downloads => true,
%>

### Response

<%= headers 201,
      :Location =>
'https://api.github.com/repos/octocat/Hello-World' %>
<%= json :repo %>

## Get

    GET /repos/:user/:repo

### Response

<%= headers 200 %>
<%= json :full_repo %>

## Edit

    PATCH /repos/:user/:repo

### Input

name
: _Required_ **string**

description
: _Optional_ **string**

homepage
: _Optional_ **string**

private
: _Optional_ **boolean** - `true` makes the repository private, and
`false` makes it public.

has\_issues
: _Optional_ **boolean** - `true` to enable issues for this repository,
`false` to disable them. Default is `true`.

has\_wiki
: _Optional_ **boolean** - `true` to enable the wiki for this
repository, `false` to disable it. Default is `true`.

has\_downloads
: _Optional_ **boolean** - `true` to enable downloads for this
repository, `false` to disable them. Default is `true`.

<%= json \
  :name          => "Hello-World",
  :description   => "This is your first repo",
  :homepage      => "https://github.com",
  :public        => true,
  :has_issues    => true,
  :has_wiki      => true,
  :has_downloads => true,
%>

### Response

<%= headers 200 %>
<%= json :full_repo %>

## List contributors

    GET /repos/:user/:repo/contributors

### Parameters

anon
: Optional flag. Set to `1` or `true` to include anonymous contributors
in results.

### Response

<%= headers 200 %>
<%= json(:user) { |h| [h] } %>

## List languages

    GET /repos/:user/:repo/languages

### Response

<%= headers 200 %>
<%= json \
  "C"      => 78769,
  "Python" => 7769,
%>

## List Teams

    GET /repos/:user/:repo/teams

### Response

<%= headers 200 %>
<%= json(:team) { |h| [h] } %>

## List Tags

    GET /repos/:user/:repo/tags

### Response

<%= headers 200 %>
<%= json(:tag) { |h| [h] } %>

## List Branches

    GET /repos/:user/:repo/branches

### Response

<%= headers 200 %>
<%= json(:branch) { |h| [h] }%>
