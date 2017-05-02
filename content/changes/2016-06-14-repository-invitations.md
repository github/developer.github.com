---
title: API changes for Repository Invitations
author_name: CoralineAda
---

We announced [repository invitation functionality][repo-invitations-announcement] on May 23. Using the site, you can invite collaborators to work on your repository. Invitees will receive an email with the invitation and have the option to accept or decline.

We have now have endpoints for managing repository invitations for both repository administrators and invitation recipients through the GitHub API. You can enable these changes during the preview period by providing a custom [media type][media-type] in the `Accept` header:

    application/vnd.github.swamp-thing-preview

For example:

``` command-line
curl "https://api.github.com/repos/github/hubot/invitations" \
  -H 'Authorization: token TOKEN' \
  -H "Accept: application/vnd.github.swamp-thing-preview"
```

You can learn more about the new endpoints in the updated [Collaborators][collaborators] and new [Repository Invitations][repo-invitations] documentation.

If you have any questions or feedback, please [let us know][contact].

[media-type]: /v3/media
[collaborators]: /v3/repos/collaborators
[repo-invitations]: /v3/repos/invitations
[repo-invitations-announcement]: https://github.com/blog/2170-repository-invitations
[contact]: https://github.com/contact?form%5Bsubject%5D=Repository+Invitations+API+Preview
