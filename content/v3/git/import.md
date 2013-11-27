---
title: Git Import | GitHub API
---

# Import API

`git fast-import` input parser

Would this be cool?

See the [Pro Git book](http://git-scm.com/book/ch8-2.html#a_custom_importer) or the
[fast-import man page](http://www.kernel.org/pub/software/scm/git/docs/git-fast-import.html)
for more information about the fast-import syntax.

It would be awesome if there was some way to open up a streaming
listener and just stream this data to it in order to:

* import directly into github from the fast-export scripts that exist
  for multiple VCS systems

* be able to easily import multiple objects - for instance a series of
  commits without having to make multiple git calls

even without streaming capability, this might be pretty interesting
functionality.

