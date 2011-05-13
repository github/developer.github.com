---
title: Git DB Commits API v3 | developer.github.com
---

# Commits API

## List commits

    GET /repos/:user/:repo/git/commits

### Parameters

start
: _String_ of the reference or SHA to start at, or an _Array_ of them if
you want multiple starting points. Defaults to the default branch on the
server.

not
: _String_ of the reference or SHA to end at, or an _Array_ of them if
you want multiple ending points

after
: _Timestamp_ to return commits only authored after the specified date

before
: _Timestamp_ to return commits only authored before the specified date

grep
: _String_ of regex to match against the commit messages

author
: _String_ of regex to match against the author names and email addresses

max
: _Integer_ of maximum number of results to return

path
: _String_ of path limiter - only return commits that modified the given
path

### Response

<%= headers 200, :pagination => true %>
<%= json :commits %>

## Get a Commit

    GET /repos/:user/:repo/git/commits/:sha

### Response

<%= headers 200 %>
<%= json :commit %>

## Create a Commit

    POST /repos/:user/:repo/git/commits

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
in with the authenticated users information and the current date.


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
    {"name" => "file.rb", "email" => "scott@github.com", \
    "date" => "2008-07-09T16:13:30+12:00"}, \
    "parents"=>["7d1b31e74ee336d15cbd21741bc88a537ed063a0"], \
    "tree"=>"827efc6d56897b048c772eb4087f854f46256132" %>

### Response

<%= headers 201,
      :Location => "https://api.github.com/git/:user/:repo/commit/:sha" %>
<%= json :sha => "771696840881ef6119cd74e9eb06305dddca8632", :size => 40 %>

