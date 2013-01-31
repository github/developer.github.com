---
title: Git Trees | GitHub API
---

# Trees API

* TOC
{:toc}

## Get a Tree

    GET /repos/:owner/:repo/git/trees/:sha

### Response

<%= headers 200 %>
<%= json :tree %>

## Get a Tree Recursively

    GET /repos/:owner/:repo/git/trees/:sha?recursive=1

### Response

<%= headers 200 %>
<%= json :tree_extra %>

## Create a Tree

The tree creation API will take nested entries as well. If both a
tree and a nested path modifying that tree are specified, it will
overwrite the contents of that tree with the new path contents and write
a new tree out.

    POST /repos/:owner/:repo/git/trees

### Parameters

base_tree
: optional _String_ of the SHA1 of the tree you want to update with new data.
If you don't set this, the commit will be created on top of everything,
however, it will only contain your change, the rest of your files will show up
as deleted.

tree
: _Array_ of _Hash_ objects (of `path`, `mode`, `type` and `sha`) specifying a
tree structure

tree.path
: _String_ of the file referenced in the tree

tree.mode
: _String_ of the file mode - one of `100644` for file (blob), `100755` for
executable (blob), `040000` for subdirectory (tree), `160000` for submodule
(commit) or `120000` for a blob that specifies the path of a symlink

tree.type
: _String_ of `blob`, `tree`, `commit`

tree.sha
: _String_ of SHA1 checksum ID of the object in the tree

tree.content
: _String_ of content you want this file to have - GitHub will write this blob
out and use that SHA for this entry.  Use either this or `tree.sha`

### Input

<%= json \
   "base_tree" => "9fb037999f264ba9a7fc6274d15fa3ae2ab98312", \
   "tree"=> \
    [{"path"=>"file.rb", \
      "mode"=>"100644", \
      "type"=>"blob", \
      "sha"=>"44b4fc6d56897b048c772eb4087f854f46256132"}] %>

### Response

<%= headers 201,
      :Location => "https://api.github.com/repos/:owner/:repo/git/trees/:sha" %>
<%= json :tree_new %>

