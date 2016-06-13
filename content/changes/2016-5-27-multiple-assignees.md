---
title: API changes for Multiple Issue Assignees
author_name: nakajima
---
GitHub recently added the ability to assign up to ten people to issues. We're updating Issue payloads and adding a couple new endpoints to help you build apps. You can enable these changes during the preview period by providing a custom [media type][media-type] in the `Accept` header:

    application/vnd.github.cerberus-preview

For example:

``` command-line
curl "https://api.github.com/repos/github/hubot/issues" \
  -H 'Authorization: token TOKEN' \
  -H "Accept: application/vnd.github.cerberus-preview" \
```

The issues returned in this list will include the new `assignees` key.

You can learn more about the new responses and endpoints in the updated [Issues][issues] and [Issue Assignees][issue-assignees] documentation.

If you have any questions or feedback, please [let us know][contact]!


[media-type]: /v3/media
[issues]: /v3/issues
[issue-assignees]: /v3/issues/assignees
[contact]: https://github.com/contact?form%5Bsubject%5D=Multiple+Assignees+API

