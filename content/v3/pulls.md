---
title: Pull Request API v3 | developer.github.com
---

# Pull Request API

## List pull requests

    GET /repo/:user/:repo/pulls

### Response

<%= headers 200 %>
<!-- <%= json(:public_key) { |h| [h] } %>-->

## Get a single pull request

    GET /repo/:user/:repo/pulls/:id

### Response

<%= headers 200 %>
<!-- <%= json :public_key %>-->

## Create a pull request

    POST /repo/:user/:repo/pulls

### Input

<!-- <%= json :title => "octocat@octomac", :key => "ssh-rsa AAA..." %>-->

### Response

<%= headers 201, :Location => "https://api.github.com/user/keys/1" %>
<!-- <%= json :public_key %>-->

## Update a pull request

    PATCH /repo/:user/:repo/pulls/:id

### Input

<!-- <%= json :title => "octocat@octomac", :key => "ssh-rsa AAA..." %>-->

### Response

<%= headers 200 %>
<!-- <%= json :public_key %>-->

## Delete a pull request

    DELETE /repo/:user/:repo/pulls/:id

### Response

<%= headers 204 %>
