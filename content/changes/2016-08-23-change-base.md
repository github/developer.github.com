---
title: API changes for changing the base branch on Pull Requests
author_name: scottjg
---
GitHub recently added the ability to [change the base branch][blog post] on a Pull Request after it's created. Now we're updating the Pull Request API to enable the new functionality.

For example:

``` command-line
curl "https://api.github.com/repos/github/hubot/pulls/123" \
  -H 'Authorization: token TOKEN' \
  -d '{ "base": "master" }'
```

The Pull Request base will be updated to point to the master branch.

You can learn more about the new responses and endpoints in the updated [Pull Request][pulls] documentation.

If you have any questions or feedback, please [let us know][contact]!


[pulls]: /v3/pulls
[blog post]: https://github.com/blog/2224-change-the-base-branch-of-a-pull-request
[contact]: https://github.com/contact?form%5Bsubject%5D=Change+base+on+Pull+Requests

