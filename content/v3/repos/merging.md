---
title: Repo Merging | GitHub API
---

# Repo Merging API

* TOC
{:toc}

The Repo Merging API supports merging branches in a repository. This accomplishes
essentially the same thing as merging one branch into another in a local repository
and then pushing to GitHub. The benefit is that the merge is done on the server side
and a local repository is not needed. This makes it more appropriate for automation
and other tools where maintaining local repositories would be cumbersome and inefficient.

The authenticated user will be the author of any merges done through this endpoint.

## Perform a merge

    POST /repos/:owner/:repo/merges

### Input

base
: _Required_ **string** - The name of the base branch that the head will be merged into.

head
: _Required_ **string** - The head to merge. This can be a branch name or a commit SHA1.

commit_message
: _Optional_ **string** - Commit message to use for the merge commit.
If omitted, a default message will be used.

<%= json \
  :base           => "master",
  :head           => "cool_feature",
  :commit_message => "Shipped cool_feature!"
%>

### Successful Response *(The resulting merge commit)*

<%= headers 201 %>
<%= json(:merge_commit) %>

### No-op response (base already contains the head, nothing to merge)

<%= headers 204 %>

### Merge conflict response

<%= headers 409 %>
<%= json({ :message => "Merge Conflict" }) %>

### Missing base response

<%= headers 404 %>
<%= json(:message => "Base does not exist") %>

### Missing head response

<%= headers 404 %>
<%= json(:message => "Head does not exist") %>