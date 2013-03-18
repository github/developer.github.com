---
title: Organization Statuses | GitHub API
---

# Org Statuses API

* TOC
{:toc}

All actions against statuses require at a minimum an authenticated user who
is a member of the `:org` being managed. Additionally, OAuth users require "user"
[scope](/v3/oauth/#scopes).

## List Org Statuses

    GET /orgs/:org/statuses

### Response

<%= headers 200 %>
<%= json(:org_status) { |h| [h] } %>

## Create Org Status

    POST /orgs/:org/statuses

### Response

<%= headers 201 %>
<%= json(:org_status) %>

## Delete Org Status

    POST /orgs/:org/statuses/:status_id

### Response

<%= headers 204 %>

## List Comments for Org Status

    GET /orgs/:org/statuses/:status_id/comments

### Response

<%= headers 200 %>
<%= json(:org_status_comment) { |h| [h] } %>

## Create Comment on Org Status

    POST /orgs/:org/statuses/:status_id/comments

### Response

<%= headers 201 %>
<%= json(:org_status_comment) %>

## Delete Org Status Comment

    DELETE /orgs/:org/statuses/:status_id/comments/:comment_id

### Response

<%= headers 204 %>
