---
title: Repo Downloads | GitHub API
---

# Repo Downloads API

* TOC
{:toc}

The downloads API is for package downloads only. If you want to get
source tarballs you should use [this](/v3/repos/contents/#get-archive-link)
instead.

## List downloads for a repository

    GET /repos/:owner/:repo/downloads

### Response

<%= headers 200 %>
<%= json(:download) { |h| [h] } %>

## Get a single download

    GET /repos/:owner/:repo/downloads/:id

### Response

<%= headers 200 %>
<%= json :download %>

## Create a new download (Part 1: Create the resource)

Creating a new download is a two step process. You must first create a
new download resource.

    POST /repos/:owner/:repo/downloads

### Input

name
: _Required_ **string**

size
: _Required_ **number** - Size of file in bytes.

description
: _Optional_ **string**

content\_type
: _Optional_ **string**

<%= json \
  :name => "new_file.jpg",
  :size => 114034,
  :description => "Latest release",
  :content_type => "text/plain"
%>

### Response

<%= headers 201, :Location => "https://api.github.com/user/repo/downloads/1" %>
<%= json :create_download %>

## Create a new download (Part 2: Upload file to s3)

Now that you have created the download resource, you can use the
information in the response to upload your file to s3. This can be done
with a `POST` to the `s3_url` you got in the create response. Here is a
brief example using curl:

    curl \
    -F "key=downloads/octocat/Hello-World/new_file.jpg" \
    -F "acl=public-read" \
    -F "success_action_status=201" \
    -F "Filename=new_file.jpg" \
    -F "AWSAccessKeyId=1ABCDEF..." \
    -F "Policy=ewogIC..." \
    -F "Signature=mwnF..." \
    -F "Content-Type=image/jpeg" \
    -F "file=@new_file.jpg" \
    https://github.s3.amazonaws.com/

NOTES

The order in which you pass these fields matters! Follow the order shown
above exactly. All parameters shown are required and if you excluded or
modify them your upload will fail because the values are hashed and signed
by the policy.

key
: Value of `path` field in the response.

acl
: Value of `acl` field in the response.

success_action_status
: 201, or whatever you want to get back.

Filename
: Value of `name` field in the response.

AWSAccessKeyId
: Value of `accesskeyid` field in the response.

Policy
: Value of `policy` field in the response.

Signature
: Value of `signature` field in the response.

Content-Type
: Value of `mime_type` field in the response.

file
: Local file. Example assumes the file existing in the directory where
you are running the curl command. Yes, the `@` matters.

More information about using the REST API to interact with s3 can
be found [here](http://docs.amazonwebservices.com/AmazonS3/latest/API/).

## Delete a download

    DELETE /repos/:owner/:repo/downloads/:id

### Response

<%= headers 204 %>
