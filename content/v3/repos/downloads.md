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

## Create a new download Part 1

Creating a new download is a two step process. You must first create the
download record:

    POST /repos/:user/:repo/downloads

### Input

name
: _Required_ **string**

description
: _Optional_ **string**

content\_type
: _Optional_ **string**

<%= json \
  :name => "file1.txt",
  :description => "Latest release",
  :content_type => "text/plain",
%>

### Response

<%= headers 201, :Location => "https://api.github.com/user/repo/downloads/1" %>
<%= json :create_download %>

## Create a new download Part 2

The response from part one returns information that allows you to upload
your file to s3. Once you have successfully uploaded to s3, you must
make one more call which will validate that the file is on s3 and enable
your download:

    PATCH /repos/:user/:repo/downloads/:id

### Response

<%= headers 200 %>
<%= json :download %>

## Delete a download

    DELETE /repos/:user/:repo/downloads/:id

### Response

<%= headers 204 %>
