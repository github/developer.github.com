---
title: Repos API v3 | developer.github.com
---

# Repos API

## List

List all public and private repositories for the authenicated user.

		GET /user/repos

List all public repositories for the specified user. Returns identical
response as `GET /user/repos` if `:user` is the authenicated user.

		GET /users/:user/repos

List all public and private repositories in the organization if the
authenticated user is a member of `:org`. Otherwise, list all public
repositories in the organization.

		GET /orgs/:org/repos

List all public repositories

		GET /repos/public

List all public and private repositories for the authenticated user.
Return all public repositories if not authenicated in which case the
reponse is identical to `GET /repos/public`.

		GET /repos

## Create

Create a new repository for the authenicated user.

    POST /user/repos

Create a new repository in this organization. The authenicated user must
be a member of `:org`.

    POST /orgs/:org/repos

## Get

		GET /repos/:repo

## Edit

		PATCH /repos/:repo

## Delete

		DELETE /repos/:repo

## List watchers

		GET /repos/:repo/watchers

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

## Watching * -> This should go into the user api

List repos that a user is watching

		GET /users/:user/watching

List repos that the authenticated user is watching

		GET /user/watching

Get if authenticated user is watching a repo

		GET /user/watching/:repo

Watch a repo

		PUT /user/watching/:repo

Stop wathing a repo

		DELETE /user/watching/:repo

