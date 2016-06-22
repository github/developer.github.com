---
kind: change
title: Protected Branches API Preview Period
created_at: 2015-11-11
author_name: nakajima
---

We're starting a preview period for the [protected branches](https://github.com/blog/2051-protected-branches-and-required-status-checks) API. Protecting a branch prevents force-pushes to it as well as deleting it. You can also specify required status checks that are required to merge code into the branch.

To protect a branch, make a `PATCH` request to the URL of the branch:

``` command-line
curl "https://api.github.com/repos/github/hubot/branches/master" \
  -XPATCH \
  -H 'Authorization: token TOKEN' \
  -H "Accept: application/vnd.github.loki-preview" \
  -d '{
    "protection": {
      "enabled": true,
      "required_status_checks": {
        "enforcement_level": "everyone",
        "contexts": [
          "required-status"
        ]
      }
    }
  }'
```

#### How can I try it?

To access this functionality during the preview period, you’ll need to provide the following custom media type in the Accept header:

```
application/vnd.github.loki-preview+json
```

Take a look at [the docs here](/v3/repos/#enabling-and-disabling-branch-protection).

If you have any questions, please [get in touch](https://github.com/contact?form%5Bsubject%5D=Protected+Branches+API+Preview).
