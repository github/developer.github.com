---
title: Deploy Keys
---

# Deploy Keys

{:toc}

<a id="list" />

## List deploy keys

    GET /repos/:owner/:repo/keys

### Response

<%= headers 200, :pagination => default_pagination_rels %>
<%= json(:deploy_key) { |h| [h] } %>

<a id="get" />

## Get a deploy key

    GET /repos/:owner/:repo/keys/:id

### Response

<%= headers 200 %>
<%= json :deploy_key %>

<a id="create" />

## Add a new deploy key

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

<a id="edit" />

## Edit a deploy key

Deploy keys are immutable. If you need to update a key, [remove the
key](#remove-a-deploy-key) and [create a new one](#add-a-new-deploy-key) instead.

<a id="delete" />

## Remove a deploy key

    DELETE /repos/:owner/:repo/keys/:id

### Response

<%= headers 204 %>
