---
title: Repos API v3 | developer.github.com
---

# Repos API

## List

List repositories for the authenicated user.

    GET /user/repos

### Parameters

type
: `all`, `public`, `private`, `member`. Default: `all`.

List public repositories for the specified user.

    GET /users/:user/repos

List repositories for the specified org.

    GET /orgs/:org/repos

### Parameters

type
: `all`, `public`, `private`. Default: `all`.

### Response

<%= headers 200, :pagination => true %>
<%= json(:repo) { |h| [h] } %>

## Create

Create a new repository for the authenicated user.

    POST /user/repos

Create a new repository in this organization. The authenicated user must
be a member of `:org`.

    POST /orgs/:org/repos

### Input

name
: _Required_ **string**

description
: _Optional_ **string**

homepage
: _Optional_ **string**

public
: _Optional_ **boolean** - `true` to create a public repository, `false`
to create a private one. Creating private repositories requires a paid
GitHub account.

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

public
: _Optional_ **boolean** - `true` to create a public repository, `false`
to create a private one. Creating private repositories requires a paid
GitHub account.

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
  "C"      => "78769",
  "Python" => "7769",
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
