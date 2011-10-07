---
title: Repo Deploy Keys | GitHub API
---

# Repo Deploy Keys API

## List

    GET /repos/:user/:repo/keys

### Response

<%= headers 200 %>
<%= json(:public_key) { |h| [h] } %>

## Get

    GET /repos/:user/:repo/keys/:id

### Response

<%= headers 200 %>
<%= json :public_key %>

## Create

    POST /repos/:user/:repo/keys

### Input

<%= json :title => "octocat@octomac", :key => "ssh-rsa AAA..." %>

### Response

<%= headers 201, :Location => "https://api.github.com/user/repo/keys/1" %>
<%= json :public_key %>

## Edit

    PATCH /repos/:user/:repo/keys/:id

### Input

<%= json :title => "octocat@octomac", :key => "ssh-rsa AAA..." %>

### Response

<%= headers 200 %>
<%= json :public_key %>

## Delete

    DELETE /repos/:user/:repo/keys/:id

### Response

<%= headers 204 %>
