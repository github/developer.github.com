---
kind: change
title: Query enhancements for listing issues and pull requests
created_at: 2014-02-28
author_name: pengwynn
---
We've made it even easier to list all [issues][] and [pull requests][] via the API.
The `state` parameter now supports a value of `all` that will return issues and
pull requests regardless of state.

<pre class="terminal">
$ curl https://api.github.com/repos/atom/vim-mode/issues\?state\=all
</pre>

We've also introduced new sorting options for [listing pull requests][pull
requests]. You can now sort pull requests by `created`, `updated`,
`popularity`, and `long-running`.

<pre class="terminal">
$ curl https://api.github.com/repos/rails/rails/pulls\?sort\=long-running\&direction\=desc
</pre>

Happy querying. If you have any questions or feedback [get in touch][contact].

[issues]: /v3/issues/#list-issues
[pull requests]: /v3/pulls/#list-pull-requests
[contact]: https://github.com/contact?form[subject]=API+query+enhancements
