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

### Parameters

Name | Type | Description
-----|------|-------------
`title`|`string`|A name for the key.
`key`|`string`|The contents of the key.
`read_only`|`boolean`|If `true`, the key will only be able to read repository contents. Otherwise, the key will be able to read and write.

#### Example

Here's how you can create a read-only deploy key:

<%= json :title => "octocat@octomac", :key => "ssh-rsa AAA...", :read_only => true %>

### Response

<%= headers 201, :Location => get_resource(:deploy_key)['url'] %>
<%= json :deploy_key %>

## Edit a deploy key {#edit}

Deploy keys are immutable. If you need to update a key, [remove the
key](#delete) and [create a new one](#create) instead.

## Remove a deploy key {#delete}

    DELETE /repos/:owner/:repo/keys/:id

### Response

<%= headers 204 %>
