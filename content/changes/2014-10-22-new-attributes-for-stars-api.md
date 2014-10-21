---
kind: change
title: New Attributes for Starring API
created_at: 2014-10-22
author_name: arfon
---

We've made it possible for you to easily find out when a user starred the repositories they're following. This information can be accessed by passing the following custom content type when accessing the [starring API][starring].

    application/vnd.github.v3.star+json

Passing this content type adds an additional `starred_at` attribute to the response.

### Feedback

If you have any questions or feedback about these changes, please [drop us a line][contact].

[starring]: /v3/activity/starring/#list-repositories-being-starred-with-star-creation-timestamps
[contact]: https://github.com/contact?form[subject]=New+Attributes+for+Starring+API
