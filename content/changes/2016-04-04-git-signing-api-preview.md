---
title: Preview support for Git signing
author_name: mastahyeti
---

GitHub [recently started verifying GPG signed commits and tags](https://github.com/blog/2144-gpg-signature-verification). We are adding API support for signature verification and user GPG key management as well. You can enable these changes during the preview period by providing a custom [media type][media-type] in the `Accept` header:

    application/vnd.github.cryptographer-preview

For example:

``` command-line
curl "https://api.github.com/user/gpg_keys" \
  -H 'Authorization: token TOKEN' \
  -H "Accept: application/vnd.github.cryptographer-preview" \
```

You can learn more about the new signature verification response objects in the updated [repository commit][repo-commit-doc], [Git commit][git-commit-doc], and [Git tag][git-tag-doc] documentation. There is also new [GPG key management][gpg-keys-doc] documentation.

During the preview period, we may change aspects of these APIs based on developer feedback. We will announce the changes here on the developer blog, but we will not provide advance notice.

If you have any questions or feedback, please [let us know][contact].

[media-type]: /v3/media
[repo-commit-doc]: /v3/repos/commits
[git-commit-doc]: /v3/git/commits
[git-tag-doc]: /v3/git/tags
[gpg-keys-doc]: /v3/users/gpg_keys
[contact]: https://github.com/contact?form%5Bsubject%5D=Squash+API+Preview
