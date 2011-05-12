---
title: Git DB Trees API v3 | developer.github.com
---

# Trees API

## Get a Tree

    GET /repos/:user/:repo/trees/:sha

### Response

<%= headers 200 %>
<%= json :tree %>

## Get a Tree Recursively

    GET /repos/:user/:repo/trees/:sha?recursive=1

### Response

<%= headers 200 %>
<%= json :full_tree %>

## Create a Tree

The tree creation API will take nested entries as well. If both a
tree and a nested path modifying that tree are specified, it will
overwrite the contents of that tree with the new path contents and write
a new tree out.

    POST /repos/:user/:repo/trees

### Parameters

tree
: _Array_ of _Hash_ objects (of `path`, `mode`, `type` and `sha`) specifying a tree structure

tree.path
: _String_ of the file referenced in the tree

tree.mode
: _String_ of the file mode - one of `100644` for file (blob), `100755` for executable (blob), `040000` for subdirectory (tree) or `160000` for submodule (commit)

tree.type
: _String_ of `blob`, `tree`, `commit`

tree.sha
: _String_ of SHA1 checksum ID of the object in the tree

### Input

<%= json "tree"=> \
  [{"path"=>"file.rb", \
    "mode"=>"100644", \
    "type"=>"blob", \
    "sha"=>"44b4fc6d56897b048c772eb4087f854f46256132"}] %>

### Response

<%= headers 201,
      :Location => "https://api.github.com/git/:user/:repo/tree/:sha" %>
<%= json :sha => "3a0f86fb8db8eea7ccbb9a95f325ddbedfb25e15", :size =>
30 %>

