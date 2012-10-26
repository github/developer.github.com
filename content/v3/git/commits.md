---
title: Git Commits | GitHub API
---

# Commits API

* TOC
{:toc}

## Get a Commit

    GET /repos/:owner/:repo/git/commits/:sha

### Response

<%= headers 200 %>
<%= json :git_commit %>

## Create a Commit

    POST /repos/:owner/:repo/git/commits

### Parameters

message
: _String_ of the commit message

tree
: _String_ of the SHA of the tree object this commit points to

parents
: _Array_ of the SHAs of the commits that were the parents of this
commit.  If omitted or empty, the commit will be written as a root
commit.  For a single parent, an array of one SHA should be provided,
for a merge commit, an array of more than one should be provided.

### Optional Parameters

The `committer` section is optional and will be filled with the `author`
data if omitted. If the `author` section is omitted, it will be filled
in with the authenticated user's information and the current date.


author.name
: _String_ of the name of the author of the commit

author.email
: _String_ of the email of the author of the commit

author.date
: _Timestamp_ of when this commit was authored

committer.name
: _String_ of the name of the committer of the commit

committer.email
: _String_ of the email of the committer of the commit

committer.date
: _Timestamp_ of when this commit was committed

### Example Input

<%= json "message"=> "my commit message", \
    "author"=> \
    {"name" => "Scott Chacon", "email" => "schacon@gmail.com", \
    "date" => "2008-07-09T16:13:30+12:00"}, \
    "parents"=>["7d1b31e74ee336d15cbd21741bc88a537ed063a0"], \
    "tree"=>"827efc6d56897b048c772eb4087f854f46256132" %>

### Response

<%= headers 201,
      :Location => "https://api.github.com/git/:owner/:repo/commit/:sha" %>
<%= json :new_commit %>

