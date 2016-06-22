---
title: Issue Locking and Unlocking API Preview Period
author_name: davidcelis
---

We're introducing new API methods to allow repository collaborators to [lock and unlock conversations][lock-an-issue]. Developers with [collaborator permissions][permissions] on a repository can start experimenting with these new endpoints today during the preview period.

To lock a conversation, make a `PUT` request to the conversation's issue:

``` command-line
$ curl "https://api.github.com/repos/github/hubot/issues/1/lock" \
  -X PUT \
  -H "Authorization: token $TOKEN" \
  -H "Content-Length: 0" \
  -H "Accept: application/vnd.github.the-key-preview"
```

To unlock a conversation, make a similarly constructed `DELETE` request:

``` command-line
$ curl "https://api.github.com/repos/github/hubot/issues/1/lock" \
  -X DELETE \
  -H "Authorization: token $TOKEN" \
  -H "Accept: application/vnd.github.the-key-preview"
```

#### How can I try it?

Starting today, developers can preview these new API methods. To use them during the preview period, you’ll need to provide the following custom [media type][media-types] in the `Accept` header:

```
application/vnd.github.the-key-preview+json
```

During the preview period, we may change aspects of these API methods based on developer feedback. If we do, we will announce the changes here on the developer blog, but we will not provide any advance notice.

Take a look at [the documentation][docs] and, if you have any questions, please [get in touch][contact].

[contact]: https://github.com/contact?form%5Bsubject%5D=Issue+Locking+and+Unlocking+API+Preview
[docs]: /v3/issues/#lock-an-issue
[lock-an-issue]: https://help.github.com/articles/locking-conversations/
[media-types]: /v3/media/
[permissions]: https://help.github.com/articles/what-are-the-different-access-permissions/
