---
title: Orgs API v3 | developer.github.com
---

# Orgs API

## List

List all public organizations for a user.

		GET /users/:user/orgs

List public and private organizations for the authenticated user.
		
		GET /user/orgs	

List all public and private organization if called by an authenicated
user. Otherwise return all public organizations.

		GET /orgs

List all public organizations.

		GET /orgs/public

## Get

		GET /orgs/:org

## Edit

		PATCH /orgs/:org

## Delete †

		DELETE /orgs/:org

† not sure if we want to do this or not.
