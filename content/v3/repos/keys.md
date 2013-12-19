---
title: Deploy Keys | GitHub API
---

# Deploy Keys

* TOC
{:toc}

## List deploy keys {#list}

    GET /repos/:owner/:repo/keys

### Response

<%= headers 200 %>
<%= json(:public_key) { |h| [h] } %>

## Get a deploy key {#get}

    GET /repos/:owner/:repo/keys/:id

### Response

<%= headers 200 %>
<%= json :public_key %>

## Add a new deploy key {#create}

    POST /repos/:owner/:repo/keys

### Input

<%= json :title => "octocat@octomac", :key => "ssh-rsa AAA..." %>

### Response

<%= headers 201, :Location => "https://api.github.com/user/repo/keys/1" %>
<%= json :public_key %>

## Edit a deploy key {#edit}

    PATCH /repos/:owner/:repo/keys/:id

### Input

<%= json :title => "octocat@octomac", :key => "ssh-rsa AAA..." %>

### Response

<%= headers 200 %>
<%= json :public_key %>

## Remove a deploy key {#delete}

    DELETE /repos/:owner/:repo/keys/:id

### Response

<%= headers 204 %>
