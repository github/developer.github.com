---
title: Preview Squash Support for the Pull Request Merge API
author_name: scottjg
---

With the [recent addition](https://github.com/blog/2141-squash-your-commits) of squashing Pull Requests via the merge button, we're adding support to squash Pull Requests in the API as well. You can squash a pull request in the [Pull Request Merge API][docs] during the preview period by providing a custom [media type][media-type] in the `Accept` header:

    application/vnd.github.polaris-preview

For example:

``` command-line
curl "https://api.github.com/repos/github/hubot/pulls/123/merge" \
  -XPUT \
  -H 'Authorization: token TOKEN' \
  -H "Accept: application/vnd.github.polaris-preview" \
  -d '{
    "squash": true,
    "commit_title": "Never tell me the odds"
  }'
```

During the preview period, we may change aspects of these API methods based on developer feedback. We will announce the changes here on the developer blog, but we will not provide advance notice.

If you have any questions or feedback, please [let us know][contact].

[media-type]: /v3/media
[docs]: /v3/pulls/#merge-a-pull-request-merge-button
[contact]: https://github.com/contact?form%5Bsubject%5D=Squash+API+Preview
