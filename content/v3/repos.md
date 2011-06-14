---
title: Repos API v3 | developer.github.com
---

# Repos API

## List

List repositories for the authenticated user.

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

Create a new repository for the authenticated user.

    POST /user/repos

Create a new repository in this organization. The authenticated user must
be a member of `:org`.

    POST /orgs/:org/repos

### Input

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

### Response

<%= headers 200 %>
<%= json :full_repo %>

<!-- ## Delete-->

<!--     DELETE /repos/:user/:repo-->

## List contributors


    GET /repos/:user/:repo/contributors

### Parameters

anon
: Optional flag. Set to `1` or `true` to include anonymous contributors
in results.

### Response

<%= headers 200 %>
<%= json(:user) { |h| [h] } %>

## List collaborators

    GET /repos/:user/:repo/collaborators

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
<%= json \
  "v0.1" => "c5b97d5ae6c19d5c5df71a34c7fbeeda2479ccbc",
  "v0.2" => "6dcb09b5b57875f334f61aebed695e2e4193db5e",
%>

## List Branches

    GET /repos/:user/:repo/branches

### Response

<%= headers 200 %>
<%= json \
  "gh-pages"    => "c5b97d5ae6c19d5c5df71a34c7fbeeda2479ccbc",
  "master"      => "6dcb09b5b57875f334f61aebed695e2e4193db5e",
  "development" => "1071c56519866afd41db2f30705eba8406b6a4a1",
%>

## List forks

    GET /repos/:user/:repo/forks

### Response

<%= headers 200 %>
<%= json(:repo) { |h| [h] } %>

## Create a fork

Create a fork for the authenticated user.

    POST /repos/:user/:repo/forks

### Parameters

org
: Optional _String_ Organization login. The repository will be forked
into this organization.

### Response

<%= headers 201 %>
<%= json :repo %>

