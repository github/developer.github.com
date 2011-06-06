---
title: Repos API v3 | developer.github.com
---

# Repos API

## List

List all public and private repositories for the authenicated user
including repositories that the user is a collaborator on.

    GET /user/repos

List all public repositories for the specified user. Returns the same
response as `GET /user/repos` if `:user` is the authenicated user except
collaborated repositories are not included in the response.

    GET /users/:user/repos

List all public and private repositories in the organization if the
authenticated user is a member of `:org`. Otherwise, list all public
repositories in the organization.

    GET /orgs/:org/repos

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

    GET /repos/:repo

### Response

<%= headers 200 %>
<%= json :full_repo %>

## Edit

    PATCH /repos/:repo

## Delete

    DELETE /repos/:repo

## List contributors

    GET /repos/:repo/contributors

## List languages

    GET /repos/:repo/languages

## List Tags

    GET /repos/:repo/tags

## List Branches

    GET /repos/:repo/branches

## List forks

    GET /repos/:repo/forks

## Create a fork

Create a fork for the authenicated user.

    POST /repos/:repo/forks

Create a fork in an organization. The authenticated user must be a
member of the specified org.

    POST /repos/:repo/forks?context=:org

## List watchers

    GET /repos/:user/:repo/watchers

### Response

<%= headers 200 %>
<%= json(:user) { |h| [h] } %>

## List repos being watched

List repos being watched by a user

    GET /users/:user/watched

List repos being watched by the authenticated user

    GET /user/watched

### Response

<%= headers 200 %>
<%= json(:repo) { |h| [h] } %>

## Check if you are watching a repo

    GET /user/watched/:user/:repo

### Response if this repo is watched by you

<%= headers 204 %>

### Response if this repo is not watched by you

<%= headers 404 %>

## Watch a repo

    PUT /user/watched/:user/:repo

### Response

<%= headers 204 %>

## Stop watching a repo

    DELETE /user/watched/:user/:repo

### Response

<%= headers 204 %>
