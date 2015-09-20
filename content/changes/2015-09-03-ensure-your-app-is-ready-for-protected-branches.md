---
kind: change
title: Ensure your app is ready for Protected Branches
created_at: 2015-09-03
author_name: aroben
---

We’ve begun to [roll out Protected Branches][blog] across GitHub. When you
protect a branch in one of your repositories, you will be prevented from
force pushing to that branch or deleting it. You can also configure required
status checks for your protected branch. When configured, changing a branch to
point at a new commit will fail unless that commit (or another commit with
the same [Git tree][tree]) has a [Status][statuses] in the `success` state for
each required status check.

These restrictions apply to branch manipulations performed via the GitHub API
as well. So when you protect a branch, you will no longer be able to [delete
the branch][delete] via the API or [update it][update] to point at a
non-ancestor commit, even with `"force": true`. And if your branch has required
status checks, you won’t be able to [update it][update] or [merge pull
requests][merge] into that branch until `success` Statuses have been posted to
the target commit for all required status checks.

These restrictions are all represented by 422 errors:

{:.terminal}
    $ curl -i -H 'Authorization: token TOKEN' \
        -X DELETE https://api.github.com/repos/octocat/hubot/git/refs/heads/master
    HTTP/1.1 422 Unprocessable Entity

    {
      "message": "Cannot delete a protected branch",
      "documentation_url": "https://help.github.com/articles/about-protected-branches"
    }

Protected branches and required status checks are a great way to ensure your
project’s conventions are followed. For example, you could write a Status
integration that only posts a `success` Status when the pull request’s author
has signed your project’s Contributor License Agreement. Or you could write one
that only posts a `success` Status when three or more members of your
`@initech/senior-engineers` team have left a comment saying they’ve reviewed
the changes. If you configure these integrations as required status checks, you
can be sure that these conditions have been satisfied before a pull request is
merged. See our [Status API guide][guide] to learn how to create integrations
like these.

If you have any questions, please [let us know][contact].

[blog]: https://github.com/blog/2051-protected-branches-and-required-status-checks
[statuses]: /v3/repos/statuses/
[tree]: http://git-scm.com/book/en/v2/Git-Internals-Git-Objects#Tree-Objects
[delete]: /v3/git/refs/#delete-a-reference
[update]: /v3/git/refs/#update-a-reference
[merge]: /v3/pulls/#merge-a-pull-request-merge-button
[contact]: https://github.com/contact?form[subject]=Protected+Branches+in+API+responses
[guide]: /guides/building-a-ci-server/
