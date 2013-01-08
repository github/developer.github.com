---
title: User Public Keys | GitHub API
---

# User Public Keys API

* TOC
{:toc}

## List public keys for a user

    GET /users/:user/keys

Lists the _verified_ public keys for a user.  This is accessible by anyone.

### Response

<%= headers 200 %>
<%= json(:simple_public_key) { |h| [h] } %>


## List your public keys

    GET /user/keys

Lists the current user's keys.  Management of public keys via the API requires
that you are authenticated through basic auth, or OAuth with the 'user' scope.

### Response

<%= headers 200 %>
<%= json(:public_key) { |h| [h] } %>

## Get a single public key

    GET /user/keys/:id

### Response

<%= headers 200 %>
<%= json :public_key %>

## Create a public key

    POST /user/keys

### Input

<%= json :title => "octocat@octomac", :key => "ssh-rsa AAA..." %>

### Response

<%= headers 201, :Location => "https://api.github.com/user/keys/1" %>
<%= json :public_key %>

## Update a public key

    PATCH /user/keys/:id

### Input

<%= json :title => "octocat@octomac", :key => "ssh-rsa AAA..." %>

### Response

<%= headers 200 %>
<%= json :public_key %>

## Delete a public key

    DELETE /user/keys/:id

### Response

<%= headers 204 %>
