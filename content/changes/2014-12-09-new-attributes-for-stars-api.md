---
kind: change
title: New Attributes for Starring API
created_at: 2014-12-09
author_name: arfon
---

You can now see when a user starred a repository. To receive the new response format containing the `starred_at` field, request the new media type:

{:.terminal}
    curl -H "Accept: application/vnd.github.v3.star+json" https://api.github.com/users/andrew/starred

Note the starred repository is now available in the repo field.

### Feedback

If you have any questions or feedback about these changes, please [drop us a line][contact].

[starring]: /v3/activity/starring/#list-repositories-being-starred-with-star-creation-timestamps
[contact]: https://github.com/contact?form[subject]=New+Attributes+for+Starring+API
