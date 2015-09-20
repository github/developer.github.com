---
kind: change
title: List all organizations
created_at: 2015-06-17
author_name: keavy
---

We've added a [new API method](/v3/orgs#list-all-organizations) to list all organizations:

{:.terminal}
    $ curl https://api.github.com/organizations

    [
      {
        "login": "github",
        "id": 9919,
        "url": "https://api.github.com/orgs/github",
        "repos_url": "https://api.github.com/orgs/github/repos",
        "events_url": "https://api.github.com/orgs/github/events",
        "members_url": "https://api.github.com/orgs/github/members{/member}",
        "public_members_url": "https://api.github.com/orgs/github/public_members{/member}",
        "avatar_url": "https://avatars.githubusercontent.com/u/9919?v=3",
        "description": "GitHub, the company."
      },
      ...
    ]

As always, if you have any questions or feedback, please [drop us a line][contact].

[contact]: https://github.com/contact?form[subject]=API+-+Listing+Organizations
