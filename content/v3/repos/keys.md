---
title: Deploy Keys | GitHub API
---

# Deploy Keys

* TOC
{:toc}

## List deploy keys {#list}

    GET /repos/:owner/:repo/keys

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:deploy_key) { |h| [h] } %>

## Get a deploy key {#get}

    GET /repos/:owner/:repo/keys/:id

### Response

<%= headers 200 %>
<%= json :deploy_key %>

## Add a new deploy key {#create}

    POST /repos/:owner/:repo/keys

### Input

<%= json :title => "octocat@octomac", :key => "ssh-rsa AAA..." %>

### Response

<%= headers 201, :Location => "https://api.github.com/repos/octocat/Hello-World/keys/1" %>
<%= json :deploy_key %>

## Edit a deploy key {#edit}

Deploy keys are immutable. If you need to update a key, [remove the
key](#delete) and [create a new one](#create) instead.

## Remove a deploy key {#delete}

    DELETE /repos/:owner/:repo/keys/:id

### Response

<%= headers 204 %>
