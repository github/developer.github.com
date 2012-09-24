---
title: Git Refs | GitHub API
---

# References API

* TOC
{:toc}

## Get a Reference

    GET /repos/:owner/:repo/git/refs/:ref

The `ref` in the URL must be formatted as `heads/branch`, not just `branch`. For example, the call to get the data for a branch named `skunkworkz/featureA` would be:

    GET /repos/:owner/:repo/git/refs/heads/skunkworkz/featureA

### Response

<%= headers 200 %>
<%= json :ref %>

## Get all References

    GET /repos/:owner/:repo/git/refs

This will return an array of all the references on the system, including
things like notes and stashes if they exist on the server.  Anything in
the namespace, not just `heads` and `tags`, though that would be the
most common.

You can also request a sub-namespace. For example, to get all the tag
references, you can call:

    GET /repos/:owner/:repo/git/refs/tags

For a full refs listing, you'll get something that looks like:

<%= headers 200 %>
<%= json :refs %>


## Create a Reference

    POST /repos/:owner/:repo/git/refs

### Parameters

ref
: _String_ of the name of the fully qualified reference (ie: `refs/heads/master`).
  If it doesn't start with 'refs' and have at least two slashes, it will be rejected.

sha
: _String_ of the SHA1 value to set this reference to

### Input

<%= json "ref"=>"refs/heads/master",\
         "sha"=>"827efc6d56897b048c772eb4087f854f46256132" %>

### Response

<%= headers 201 %>
<%= json :ref %>

## Update a Reference

    PATCH /repos/:owner/:repo/git/refs/:ref

### Parameters

sha
: _String_ of the SHA1 value to set this reference to

force
: _Boolean_ indicating whether to force the update or to make sure the
update is a fast-forward update. The default is `false`, so leaving this
out or setting it to `false` will make sure you're not overwriting work.

### Input

<%= json "sha"=>"aa218f56b14c9653891f9e74264a383fa43fefbd",\
         "force"=>true %>

### Response

<%= headers 200, \
      :Location => "https://api.github.com/git/:owner/:repo/commit/:sha" %>
<%= json :ref %>

## Delete a Reference

    DELETE /repos/:owner/:repo/git/refs/:ref

Example: Deleting a branch:

    DELETE /repos/octocat/Hello-World/git/refs/heads/feature-a

Example: Deleting a tag:

    DELETE /repos/octocat/Hello-World/git/refs/tags/v1.0

### Response

<%= headers 204 %>

