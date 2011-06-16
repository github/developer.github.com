---
title: Repo Commits API v3 | developer.github.com
---

# Repo Commits API

## List commits on a repository

    GET /repos/:user/:repo/commits

### Parameters

sha
: _Optional_ **string** specifying the sha or branch to start listing commits
from.

path
: _Optional_ **string** file path. Only commits containing this file
will be returned.

### Response

<%= headers 200 %>
<%= json(:commit) { |h| [h] } %>

## Get a single commit

    GET /repos/:user/:repo/commits/:sha

### Response

<%= headers 200 %>
<%= json(:commit) %>

## List commit comments for a repository

    GET /repos/:user/:repo/comments

### Response

<%= headers 200 %>
<%= json(:commit_comment) { |h| [h] } %>

## List comments for a single commit

    GET /repos/:user/:repo/commits/:sha/comments

### Response

<%= headers 200 %>
<%= json(:commit_comment) %>

## Create a commit comment

    POST /repos/:user/:repo/commits/:sha/comments

### Input

body
: _Required_ **string** for the body of the comment.

commit_id
: _Required_ **string** specifying the commit sha this comment was made
against.

line
: _Required_ **number** of the line in the file where this comment is
being made.

path
: _Required_ **string** specifying the relative path of the file that is
being commented on.

position
: _Required_ **number** of the line index into the diff where this
comment is being made.

#### Example

<%= json \
  :body      => 'Nice change',
  :commit_id => '6dcb09b5b57875f334f61aebed695e2e4193db5e',
  :line      => 1,
  :path      => 'file1.txt',
  :position  => 4,
%>

### Response

<%= headers 201, :Location => "https://api.github.com/user/repo/comments/1" %>
<%= json :commit_comment %>

## Get a single commit comment

    GET /repos/:user/:repo/comments/:id

### Response

<%= headers 200 %>
<%= json :commit_comment %>

## Update a commit comment

    PATCH /repos/:user/:repo/comments/:id

### Input

body
: _Required_ **string** for the body of the comment.

#### Example

<%= json \
  :body => 'Nice change'
%>

### Response

<%= headers 200 %>
<%= json :commit_comment %>

## Delete a commit comment

    DELETE /repos/:user/:repo/comments/:id

### Response

<%= headers 204 %>

