---
title: Reactions API Preview now includes user information
author_name: kneemer
---

To avoid making extra API calls, we've updated the [Reactions API preview][initial-reaction-api-post] to include additional user information when listing Reactions.

**This is a breaking change for Reaction payloads**. If you're trying out this new API during its preview period, you'll need to update your code to continue working with it.

## JSON Payload Changes

We're replacing the `user_id` attribute with `user` and changing the schema type from a number to a JSON object.

## Example Reaction JSON
```json
[
  {
    "id": 1,
    "user": {
      "login": "octocat",
      "id": 1,
      "avatar_url": "https://github.com/images/error/octocat_happy.gif",
      "gravatar_id": "",
      "url": "https://api.github.com/users/octocat",
      "html_url": "https://github.com/octocat",
      "followers_url": "https://api.github.com/users/octocat/followers",
      "following_url": "https://api.github.com/users/octocat/following{/other_user}",
      "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
      "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
      "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
      "organizations_url": "https://api.github.com/users/octocat/orgs",
      "repos_url": "https://api.github.com/users/octocat/repos",
      "events_url": "https://api.github.com/users/octocat/events{/privacy}",
      "received_events_url": "https://api.github.com/users/octocat/received_events",
      "type": "User",
      "site_admin": false
    },
    "content": "heart"
  }
]
```

As always, if you have any questions or feedback, please [get in touch][contact].

[initial-reaction-api-post]: /changes/2016-05-12-reactions-api-preview
[contact]: https://github.com/contact?form%5Bsubject%5D=Reactions+API+Preview
