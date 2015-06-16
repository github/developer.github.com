---
kind: change
title: List all organizations
created_at: 2015-06-16
author_name: keavy
---

We just added a [new API method](/v3/orgs#list-all-organizations) to list all organizations:

<pre class="terminal">
$ curl -H "Authorization: token [yours]" https://api.github.com/organizations

[
  {
    "login": "github",
    "id": 226,
    "url": "http://api.github.com/orgs/github",
    "repos_url": "http://api.github.com/orgs/github/repos",
    "events_url": "http://api.github.com/orgs/github/events",
    "members_url": "http://api.github.com/orgs/github/members{/member}",
    "public_members_url": "http://api.github.com/orgs/github/public_members{/member}",
    "avatar_url": "http://avatars.githubusercontent.com/u/226?",
    "description": "GitHub, the company."
  },
  ...
]
</pre>

As always, if you have any questions or feedback, please [drop us a line][contact].

[contact]: https://github.com/contact?form[subject]=API+-+Listing+Organizations
