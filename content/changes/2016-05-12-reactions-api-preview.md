---
title: Preview support for Reactions API
author_name: kneemer
---

GitHub recently added [Reactions to Pull Requests, Issues, and Comments][reactions-blog-post] to help people express their feelings more simply and effectively in conversations. We are adding endpoints for Reactions so that you can now react and unreact via the API. You can enable these changes during the preview period by providing a custom [media type][media-type] in the `Accept` header:

    application/vnd.github.squirrel-girl-preview

For example:

To view reactions on an issue:

``` command-line
$ curl "https://api.github.com/repos/github/hubot/issues/1/reactions" \
  -H "Accept: application/vnd.github.squirrel-girl-preview"
```


You can learn more about the new reaction response objects in the updated [Commit comment][commit-comment-doc], [Issue][issue-doc], [Issue comment][issue-comment-doc], and [Review Comment][review-comment-doc] documentation. There is also new [Reaction][reaction-doc] documentation.

During the preview period, we may change aspects of these APIs based on developer feedback. We will announce the changes here on the developer blog, but we will not provide advance notice.

If you have any questions or feedback, please [let us know][contact].

[media-type]: /v3/media
[reaction-doc]: /v3/reactions
[issue-doc]: /v3/issues#preview-period-org-issues
[issue-comment-doc]: /v3/issues/comments#preview-period-issue-comments
[review-comment-doc]: /v3/pulls/comments#preview-period-pull-comments
[commit-comment-doc]: /v3/repos/comments#preview-period-commits-comments
[contact]: https://github.com/contact?form%5Bsubject%5D=Reactions+API+Preview
[reactions-blog-post]: https://github.com/blog/2119-add-reactions-to-pull-requests-issues-and-comments
