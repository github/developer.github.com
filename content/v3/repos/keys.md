---
title: Repo Deploy Keys | GitHub API
---

# Repo Deploy Keys API

* TOC
{:toc}

## List

    GET /repos/:owner/:repo/keys

### Response

<%= headers 200 %>
<%= json(:public_key) { |h| [h] } %>

## Get

    GET /repos/:owner/:repo/keys/:id

### Response

<%= headers 200 %>
<%= json :public_key %>

## Create

    POST /repos/:owner/:repo/keys

### Input

<%= json :title => "octocat@octomac", :key => "ssh-rsa AAA..." %>

### Response

<%= headers 201, :Location => "https://api.github.com/user/repo/keys/1" %>
<%= json :public_key %>

## Edit

    PATCH /repos/:owner/:repo/keys/:id

### Input

<%= json :title => "octocat@octomac", :key => "ssh-rsa AAA..." %>

### Response

<%= headers 200 %>
<%= json :public_key %>

## Delete

    DELETE /repos/:owner/:repo/keys/:id

### Response

<%= headers 204 %>
