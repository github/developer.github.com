---
kind: change
title: Pagination changes for some listing methods
created_at: 2014-03-13
author_name: pengwynn
---

In an effort to keep the API fast for everyone, we're enabling pagination on a
few API methods that previously did not support pagination. Beginning today,
these methods will paginate if you include `page` or `per_page` query
parameters. Starting April 15th, 2014, these methods will _always_ return
paginated results.

These methods include:

#### [Gist comments][]

    GET /gists/:gist_id/comments

#### [Git refs][]

    GET /repos/:owner/:repo/git/refs

#### [Repository collaborators][]

    GET /repos/:owner/:repo/collaborators

#### [Repository downloads][]

    GET /repos/:owner/:repo/downloads

#### [Repository keys][]

    GET /repos/:owner/:repo/keys

#### [Repository labels][]

    GET /repos/:owner/:repo/labels

#### [Team repositories][]

    GET /teams/:id/repos

#### [User emails][] (v3 media type only)

    GET /users/:user/emails

#### [User keys][]

    GET /users/:user/keys
    GET /user/keys

As always, be sure and follow those [Link headers][paginating] to get
subsequent results. If you have any questions or run into trouble, feel free to
[get in touch][contact].

[Gist comments]: /v3/gists/comments/#list-comments-on-a-gist
[Git refs]: /v3/git/refs/#get-all-references
[Repository collaborators]: /v3/repos/collaborators/#list
[Repository downloads]: /v3/repos/downloads/#list-downloads-for-a-repository
[Repository keys]: /v3/repos/keys/#list
[Repository labels]: /v3/issues/labels/#list-all-labels-for-this-repository
[Team repositories]: /v3/orgs/teams/#list-team-repos
[User emails]: /v3/users/emails/#future-response
[User keys]: /v3/users/keys/#list-public-keys-for-a-user
[paginating]: /v3/#pagination
[contact]: https://github.com/contact?form[subject]=API+v3:+Paginating+org+members
