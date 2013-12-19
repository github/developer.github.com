---
title: Deploy Keys | GitHub API
---

# Deploy Keys

* TOC
{:toc}

## List deploy keys associated with a repo {#list}

    GET /repos/:owner/:repo/keys

### Response

<%= headers 200 %>
<%= json(:public_key) { |h| [h] } %>

## Get a specific deploy key on a repo {#get}

    GET /repos/:owner/:repo/keys/:id

### Response

<%= headers 200 %>
<%= json :public_key %>

## Add a new deploy key to a repo {#create}

    POST /repos/:owner/:repo/keys

### Input

<%= json :title => "octocat@octomac", :key => "ssh-rsa AAA..." %>

### Response

<%= headers 201, :Location => "https://api.github.com/user/repo/keys/1" %>
<%= json :public_key %>

## Edit a specific deploy key on a repo {#edit}

    PATCH /repos/:owner/:repo/keys/:id

### Input

<%= json :title => "octocat@octomac", :key => "ssh-rsa AAA..." %>

### Response

<%= headers 200 %>
<%= json :public_key %>

## Remove a deploy key from a repo {#delete}

    DELETE /repos/:owner/:repo/keys/:id

### Response

<%= headers 204 %>
