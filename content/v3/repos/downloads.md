---
title: Repo Downloads API v3 | developer.github.com
---

# Repo Downloads API

The downloads API is for package downloads only. If you want to get
source tarballs for tags you should use [this](/v3/repos/#list-tags)
instead.

## List downloads for a repository

    GET /repos/:user/:repo/downloads

### Response

<%= headers 200 %>
<%= json(:download) { |h| [h] } %>

## Get a single download

    GET /repos/:user/:repo/downloads/:id

### Response

<%= headers 200 %>
<%= json :download %>

## Create a new download

    PUT /repos/:user/:repo/downloads/:id

### Response

<%= headers 201, :Location => "https://api.github.com/user/repo/downloads/1" %>
<%= json :create_download %>

## Delete a download

    DELETE /repos/:user/:repo/downloads/:id

### Response

<%= headers 204 %>
