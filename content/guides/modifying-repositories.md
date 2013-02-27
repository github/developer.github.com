---
title: Modifying Repositories | GitHub API
---

# Modifying Repositories

As discussed on the [Git Database API][git DB API] page, file manipulation is a process
that involves several steps. If you're familiar with the way git works, it's not 
too difficult. However, it's something that requires a bit of careful consideration.

We're going to write a small server that handles file updates. It will authenticate
you to the GitHub API. We'll be writing this in Ruby, though the concepts apply
to every [language and library][libraries] that
communicates with the GitHub API.

## Creating a server


[git DB API]: /v3/git/
[libraries]: http://developer.github.com/v3/libraries/