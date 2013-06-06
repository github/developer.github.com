---
title: Repos | GitHub API
---

# Repos API

* TOC
{:toc}

## List your repositories

List repositories for the authenticated user.

    GET /user/repos

### Parameters

type
: `all`, `owner`, `public`, `private`, `member`. Default: `all`.

sort
: `created`, `updated`, `pushed`, `full_name`, default: `full_name`.

direction
: `asc` or `desc`, default: when using `full_name`: `asc`, otherwise `desc`.

## List user repositories

List public repositories for the specified user.

    GET /users/:user/repos

### Parameters

type
: `all`, `owner`, `member`. Default: `all`.

sort
: `created`, `updated`, `pushed`, `full_name`, default: `full_name`.

direction
: `asc` or `desc`, default: when using `full_name`: `asc`, otherwise `desc`.

## List organization repositories

List repositories for the specified org.

    GET /orgs/:org/repos

### Parameters

type
: `all`, `public`, `private`, `forks`, `sources`, `member`. Default: `all`.

### Response

<%= headers 200, :pagination => true %>
<%= json(:repo) { |h| [h] } %>

## List all public repositories

This provides a dump of every public repository, in the order that they were created.

    GET /repositories

### Parameters

since
: The integer ID of the last Repository that you've seen.

### Response

<%= headers 200 %>
<%= json(:simple_repo) { |h| [h] } %>

## Create

Create a new repository for the authenticated user. OAuth users must supply
`repo` scope.

    POST /user/repos

Create a new repository in this organization. The authenticated user must
be a member of the specified organization.

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

auto\_init
: _Optional_ **boolean** - `true` to create an initial commit with empty
README. Default is `false`.

gitignore\_template
: _Optional_ **string** - Desired language or platform [.gitignore
template](https://github.com/github/gitignore) to
apply. Use the name of the template without the extension. For example, "Haskell"
_Ignored if `auto_init` parameter is not provided._

<%= json \
  :name          => "Hello-World",
  :description   => "This is your first repo",
  :homepage      => "https://github.com",
  :private       => false,
  :has_issues    => true,
  :has_wiki      => true,
  :has_downloads => true
%>

### Response

<%= headers 201,
      :Location =>
'https://api.github.com/repos/octocat/Hello-World' %>
<%= json :repo %>

## Get

    GET /repos/:owner/:repo

### Response

The `parent` and `source` objects are present when the repo is a fork.
`parent` is the repo this repo was forked from,
`source` is the ultimate source for the network.

<%= headers 200 %>
<%= json :full_repo %>

## Edit

    PATCH /repos/:owner/:repo

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

default\_branch
: _Optional_ **String** - Update the default branch for this repository.

<%= json \
  :name          => "Hello-World",
  :description   => "This is your first repo",
  :homepage      => "https://github.com",
  :public        => true,
  :has_issues    => true,
  :has_wiki      => true,
  :has_downloads => true
%>

### Response

<%= headers 200 %>
<%= json :full_repo %>

## List contributors

    GET /repos/:owner/:repo/contributors

### Parameters

anon
: Optional flag. Set to `1` or `true` to include anonymous contributors
in results.

### Response

<%= headers 200 %>
<%= json(:contributor) { |h| [h] } %>

## List languages

List languages for the specified repository. The value on the right of a language is the number of bytes of code written in that language.

    GET /repos/:owner/:repo/languages

### Response

<%= headers 200 %>
<%= json \
  "C"      => 78769,
  "Python" => 7769
%>

## List Teams

    GET /repos/:owner/:repo/teams

### Response

<%= headers 200 %>
<%= json(:team) { |h| [h] } %>

## List Tags

    GET /repos/:owner/:repo/tags

### Response

<%= headers 200 %>
<%= json(:tag) { |h| [h] } %>

## List Branches

    GET /repos/:owner/:repo/branches

### Response

<%= headers 200 %>
<%= json(:branches) %>

## Get Branch

    GET /repos/:owner/:repo/branches/:branch

### Response

<%= headers 200 %>
<%= json(:branch) %>

## Delete a Repository

Deleting a repository requires admin access.  If OAuth is used, the
`delete_repo` scope is required.

    DELETE /repos/:owner/:repo

### Response

<%= headers 204 %>

