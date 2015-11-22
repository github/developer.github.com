---
kind: change
title: Pagination changes for some resource lists
created_at: 2014-03-18
author_name: pengwynn
---

In an effort to keep the API fast for everyone, we're enabling
[pagination][paginating] on some API methods that previously did not support it.
Beginning today, the methods below will paginate if you include `page` or
`per_page` query parameters. Starting April 17th, 2014, these methods will
_always_ return [paginated results][paginating]. If you have any questions or
run into trouble, feel free to [get in touch][contact].

Here's the complete list of updated methods:

#### [Gist comments][]

    GET /gists/:gist_id/comments

#### [Gist commits][]

    GET /gists/:gist_id/commits

#### [Gist forks][]

    GET /gists/:gist_id/forks

#### [Git refs][]

    GET /repos/:owner/:repo/git/refs

#### [Issue labels][]

    GET /repos/:owner/:repo/issues/:number/labels

#### [Milestone labels][]

    GET /repos/:owner/:repo/milestones/:id/labels

#### [Organization teams][]

    GET /orgs/:org/teams

#### [Pull Request commits][]

    GET /repos/:owner/:repo/pulls/:number/commits

#### [Pull Request files][]

    GET /repos/:owner/:repo/pulls/:number/files

#### [Release assets][]

    GET /repos/:owner/:repo/releases/:id/assets

#### [Repository collaborators][]

    GET /repos/:owner/:repo/collaborators

#### [Repository contributors][]

    GET /repos/:owner/:repo/contributors

#### [Repository branches][]

    GET /repos/:owner/:repo/branches

#### [Repository downloads][]

    GET /repos/:owner/:repo/downloads

#### [Repository keys][]

    GET /repos/:owner/:repo/keys

#### [Repository labels][]

    GET /repos/:owner/:repo/labels

#### [Repository tags][]

    GET /repos/:owner/:repo/tags

#### [Repository teams][]

    GET /repos/:owner/:repo/teams

#### [Team members][]

    GET /teams/:id/members

#### [Team repositories][]

    GET /teams/:id/repos

#### [User emails][] (v3 media type only)

    GET /user/emails

#### [User keys][]

    GET /users/:user/keys
    GET /user/keys

[Gist comments]: /v3/gists/comments/#list-comments-on-a-gist
[Gist commits]: /v3/gists/#list-gist-commits
[Gist forks]: /v3/gists/#list-gist-forks
[Git refs]: /v3/git/refs/#get-all-references
[Repository collaborators]: /v3/repos/collaborators/#list
[Repository downloads]: /v3/repos/downloads/#list-downloads-for-a-repository
[Repository keys]: /v3/repos/keys/#list
[Repository labels]: /v3/issues/labels/#list-all-labels-for-this-repository
[Team repositories]: /v3/orgs/teams/#list-team-repos
[User emails]: /v3/users/emails/#list-email-addresses-for-a-user
[User keys]: /v3/users/keys/#list-public-keys-for-a-user
[Issue labels]:/v3/issues/labels/#list-labels-on-an-issue
[Milestone labels]: /v3/issues/labels/#get-labels-for-every-issue-in-a-milestone
[Organization teams]: /v3/orgs/teams/#list-teams
[Pull Request commits]: /v3/pulls/#list-commits-on-a-pull-request
[Pull Request files]: /v3/pulls/#list-pull-requests-files
[Release assets]: /v3/repos/releases/#list-assets-for-a-release
[Repository contributors]: /v3/repos/#list-contributors
[Repository branches]: /v3/repos/#list-branches
[Repository tags]: /v3/repos/#list-tags
[Repository teams]: /v3/repos/#list-teams
[Team members]: /v3/orgs/teams/#list-team-members

[paginating]: /v3/#pagination
[contact]: https://github.com/contact?form[subject]=API+v3:+Pagination+changes
