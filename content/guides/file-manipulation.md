---
title: File Manipulation | GitHub API
---

# File Manipulation

* TOC
{:toc}

With the GitHub API, you can create, modify, and delete files that are stored
in repositories you can have access to. You have two ways to accomplish your goals:

* Using [the Repo Contents API](http://developer.github.com/v3/repos/contents/)
* Using [the low-level Git API](http://developer.github.com/v3/git/)

Your choice of which route to go down depends on what you're trying to accomplish.
The Repo Contents API is far easier to use, while the low-level API enables you to
have more precise control over your updates. 

This guide will focus almost entirely on the Repo Contents API. We'll provide corresponding
gists (with comments) for the low-level git work.