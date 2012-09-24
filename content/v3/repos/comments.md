---
title: Repo Comments | GitHub API
---

# Repo Comments API

* TOC
{:toc}

## List commit comments for a repository

Commit Comments leverage [these](#custom-mime-types) custom mime types. You can
read more about the use of mime types in the API [here](/v3/media/).

Comments are ordered by ascending ID.

    GET /repos/:owner/:repo/comments

### Response

<%= headers 200 %>
<%= json(:commit_comment) { |h| [h] } %>

## List comments for a single commit

    GET /repos/:owner/:repo/commits/:sha/comments

### Response

<%= headers 200 %>
<%= json(:commit_comment) { |h| [h] } %>

## Create a commit comment

    POST /repos/:owner/:repo/commits/:sha/comments

### Input

body
: _Required_ **string**

path
: _Required_ **string** - Relative path of the file to comment on.

position
: _Required_ **number** - Line index in the diff to comment on.

line
: _Optional_ **number** - Line number in the file to comment on. Defaults to 1.


#### Example

<%= json \
  :body      => 'Nice change',
  :commit_id => '6dcb09b5b57875f334f61aebed695e2e4193db5e',
  :line      => 1,
  :path      => 'file1.txt',
  :position  => 4
%>

### Response

<%= headers 201, :Location => "https://api.github.com/user/repo/comments/1" %>
<%= json :commit_comment %>

## Get a single commit comment

    GET /repos/:owner/:repo/comments/:id

### Response

<%= headers 200 %>
<%= json :commit_comment %>

## Update a commit comment

    PATCH /repos/:owner/:repo/comments/:id

### Input

body
: _Required_ **string**

#### Example

<%= json \
  :body => 'Nice change'
%>

### Response

<%= headers 200 %>
<%= json :commit_comment %>

## Delete a commit comment

    DELETE /repos/:owner/:repo/comments/:id

### Response

<%= headers 204 %>

## Custom Mime Types

These are the supported mime types for commit comments. You can read more
about the use of mime types in the API [here](/v3/media/).

    application/vnd.github-commitcomment.raw+json
    application/vnd.github-commitcomment.text+json
    application/vnd.github-commitcomment.html+json
    application/vnd.github-commitcomment.full+json
