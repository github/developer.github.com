---
kind: change
title: Paginated results for organization members
created_at: 2013-12-13
author_name: pengwynn
---

The [organization members][members] and [organization public members][public
members] methods will soon return paginated results by default. Beginning
today, these methods will paginate if you include `page` or `per_page` query
parameters. Starting January 15th, 2014, these methods will _always_ return paginated
results.

As always, be sure and follow those [Link headers][paginating] to get
subsequent results. If you have any questions or run into trouble, feel free to
[get in touch][contact].

Happy paginating.


[members]: http://developer.github.com/v3/orgs/members/#members-list
[public members]: http://developer.github.com/v3/orgs/members/#public-members-list
[paginating]: http://developer.github.com/v3/#pagination
[contact]: https://github.com/contact?form[subject]=API+v3:+Paginating+org+members

