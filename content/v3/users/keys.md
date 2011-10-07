---
title: User Public Keys | GitHub API
---

# User Public Keys API

Management of public keys via the API requires that you are
authenticated.

## List public keys for a user

    GET /user/keys

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
