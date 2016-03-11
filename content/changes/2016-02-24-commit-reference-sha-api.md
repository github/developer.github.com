---
title: Commit Reference SHA-1 Preview Period
author_name: mikemcquaid
---

We're introducing a new API media type to allow users to get the SHA-1 of a commit reference. This can be useful in working out if you have the latest version of a remote branch based on your local branch's SHA-1. Developers with read access to a repository can start experimenting with this new media type today during the preview period.

To get the commit reference's SHA-1, make a `GET` request to the repository's reference:

``` command-line
$ curl "https://api.github.com/repos/Homebrew/homebrew/commits/master" \
  -H "Accept: application/vnd.github.chitauri-preview+sha"
```

To check if a remote branch's SHA-1 is the same as your local branch's SHA-1, make a `GET` request to the repository's branch and provide the current SHA-1 for the local branch as the ETag:

``` command-line
$ curl "https://api.github.com/repos/Homebrew/homebrew/commits/master" \
  -H "Accept: application/vnd.github.chitauri-preview+sha" \
  -H "If-None-Match: \"814412cfbd631109df337e16c807207e78c0d24e\""
```

If the remote and your local branch point to the same SHA-1 then this call will return a `304 Unmodified` status code (and not use your rate limit).

You can see an example of this API in a pull request to Homebrew/homebrew's updater: https://github.com/Homebrew/homebrew/pull/49219.

#### How can I try it?

To use this new API media type during the preview period, you’ll need to provide the following custom [media type][media-types] in the `Accept` header:

```
application/vnd.github.chitauri-preview+sha
```

During the preview period, we may change aspects of this API media type based on developer feedback. If we do, we will announce the changes here on the developer blog, but we will not provide any advance notice.

Take a look at [the documentation][docs] and, if you have any questions, please [get in touch][contact].

[contact]: https://github.com/contact?form%5Bsubject%5D=Commit+Reference+SHA-1+Preview
[docs]: /v3/repos/commits/#get-the-sha-1-of-a-commit-reference
[media-types]: /v3/media/
