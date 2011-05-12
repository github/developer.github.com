---
title: Git DB Refs API v3 | developer.github.com
---

# References API

## Get a Reference

    GET /git/:user/:repo/refs/:ref

The `ref` in the URL must be formatted as `heads/branch`, not just `branch`. For example, the call to get the data for a branch named `sc/featureA` would be:

    GET /git/:user/:repo/refs/heads/sc/featureA

### Response

<%= headers 200 %>
<%= json :ref => "refs/heads/master", "type" => "commit", \
         :sha => "bca1e965df1235af5190b0e7760a456ef9602e9a" %>

## Get all References

    GET /git/:user/:repo/refs

This will return an array of all the references on the system, including
things like notes and stashes if they exist on the server.  Anything in
the namespace, not just `heads` and `tags`, though that would be the
most common.

You can also request a sub-namespace. For example, to get all the tag
references, you can call:

    GET /git/:user/:repo/refs/tags

For a full refs listing, you'll get something that looks like:

<%= headers 200 %>
<%= json :refs %>


## Update a Reference

    POST /git/:user/:repo/refs/:ref

### Paramaters

sha
: _String_ of the SHA1 value to set this reference to

force
: _Boolean_ indicating whether to force the update or to make sure the
update is a fast-forward update. The default is `false`, so leaving this
out or setting it to `false` will make sure you're not overwriting work.

### Input

<%= json "sha"=>"827efc6d56897b048c772eb4087f854f46256132", \
         "force"=>false %>

### Response

<%= headers 201,
      :Location => "https://api.github.com/git/:user/:repo/ref/:ref" %>
<%= json :ref => "refs/heads/master", "type" => "commit", \
         "sha"=>"827efc6d56897b048c772eb4087f854f46256132" %>

