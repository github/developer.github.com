---
title: User Public Keys | GitHub API
---

# Public Keys

* TOC
{:toc}

## List public keys for a user

    GET /users/:username/keys

Lists the _verified_ public keys for a user.  This is accessible by anyone.

### Response

<%= headers 200 %>
<%= json(:simple_public_key) { |h| [h] } %>


## List your public keys

    GET /user/keys

Lists the current user's keys. Requires that you are authenticated via
Basic Auth or via OAuth with at least `read:public_key`
[scope](/v3/oauth/#scopes).

### Response

<%= headers 200 %>
<%= json(:public_key) { |h| [h] } %>

## Get a single public key

View extended details for a single public key. Requires that you are
authenticated via Basic Auth or via OAuth with at least `read:public_key`
[scope](/v3/oauth/#scopes).

    GET /user/keys/:id

### Response

<%= headers 200 %>
<%= json :public_key %>

## Create a public key

Creates a public key. Requires that you are authenticated via Basic Auth,
or OAuth with at least `write:public_key` [scope](/v3/oauth/#scopes).

    POST /user/keys

### Input

<%= json :title => "octocat@octomac", :key => "ssh-rsa AAA..." %>

### Response

<%= headers 201, :Location => "https://api.github.com/user/keys/1" %>
<%= json :public_key %>

## Update a public key

Public keys are immutable. If you need to update a public key, [remove the
key](#delete-a-public-key) and [create a new one](#create-a-public-key)
instead.

## Delete a public key

Removes a public key. Requires that you are authenticated via Basic Auth
or via OAuth with at least `admin:public_key` [scope](/v3/oauth/#scopes).

    DELETE /user/keys/:id

### Response

<%= headers 204 %>
