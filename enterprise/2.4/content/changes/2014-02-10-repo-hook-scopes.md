---
kind: change
title: New scopes for managing repository hooks
created_at: 2014-02-10
author_name: pengwynn
---

Many third party services need to set up [hooks][] in order to act upon events
in your repositories. Today, we've introduced three new [scopes][] that provide
more granular access to your repository hooks without allowing access to your
repository contents:

* `read:repo_hook` grants read and ping access to hooks in public or private repositories.
* `write:repo_hook` grants read, write, and ping access to hooks in public or private repositories.
* `admin:repo_hook` grants read, write, ping, and delete access to hooks in public or private repositories.

As always, if you have any questions or feedback, [get in touch][contact].

[hooks]: http://developer.github.com/v3/repos/hooks/
[scopes]: http://developer.github.com/v3/oauth/#scopes
[contact]: https://github.com/contact?form%5Bsubject%5D=API+repo+hook+scopes

