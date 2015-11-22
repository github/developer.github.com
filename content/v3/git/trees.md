---
title: Git Trees | GitHub API
---

# Trees

* TOC
{:toc}

## Get a Tree

    GET /repos/:owner/:repo/git/trees/:sha

### Response

{{#tip}}

If `truncated` is `true`, the number of items in the `tree` array exceeded our maximum limit. If you need to fetch more items, you can clone the repository and iterate over the Git data locally.

{{/tip}}

<%= headers 200 %>
<%= json :tree %>

## Get a Tree Recursively

    GET /repos/:owner/:repo/git/trees/:sha?recursive=1

### Response

{{#tip}}

If `truncated` is `true`, the number of items in the `tree` array exceeded our maximum limit. If you need to fetch more items, use the non-recursive method of fetching trees, and fetch one sub-tree at a time.

{{/tip}}

<%= headers 200 %>
<%= json :tree_extra %>

## Create a Tree

The tree creation API will take nested entries as well. If both a
tree and a nested path modifying that tree are specified, it will
overwrite the contents of that tree with the new path contents and write
a new tree out.

    POST /repos/:owner/:repo/git/trees

### Parameters

Name | Type | Description
-----|------|--------------
`tree`|`array` of `object`s | **Required**. Objects (of `path`, `mode`, `type`, and `sha`) specifying a tree structure
`base_tree`| `string` | The SHA1 of the tree you want to update with new data. If you don't set this, the commit will be created on top of everything; however, it will only contain your change, the rest of your files will show up as deleted.

The `tree` parameter takes the following keys:

Name | Type | Description
-----|------|--------------
`path`|`string`| The file referenced in the tree
`mode`|`string`| The file mode; one of `100644` for file (blob), `100755` for executable (blob), `040000` for subdirectory (tree), `160000` for submodule (commit), or `120000` for a blob that specifies the path of a symlink
`type`| `string`| Either `blob`, `tree`, or `commit`
`sha`|`string`| The SHA1 checksum ID of the object in the tree
`content`|`string` | The content you want this file to have. GitHub will write this blob out and use that SHA for this entry.  Use either this, or `tree.sha`.


### Input

<%= json \
   "base_tree" => "9fb037999f264ba9a7fc6274d15fa3ae2ab98312", \
   "tree"=> \
    [{"path"=>"file.rb", \
      "mode"=>"100644", \
      "type"=>"blob", \
      "sha"=>"44b4fc6d56897b048c772eb4087f854f46256132"}] %>

### Response

<%= headers 201, :Location => get_resource(:tree_new)['url'] %>
<%= json :tree_new %>
