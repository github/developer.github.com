---
title: Commit Reference SHA-1 API is now official
author_name: mikemcquaid
---

We're making the [Commit Reference SHA-1 API][api-enhancements-blog-post] part of the official GitHub API.

During the preview period you needed to provide the `application/vnd.github.chitauri-preview+sha` preview media type in the `Accept` header to opt-in to the changes. Now that the preview period has ended the custom [media type][custom-media-types] has changed to `application/vnd.github.v3.sha` (but the preview type will continue to work).

If you have any questions or feedback, please [get in touch with us][contact]!

[api-enhancements-blog-post]: /changes/2016-02-24-commit-reference-sha-api/
[custom-media-types]: /v3/media/
[contact]: https://github.com/contact?form[subject]=Commit+Reference+SHA-1+API
