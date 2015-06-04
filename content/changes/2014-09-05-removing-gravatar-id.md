---
kind: change
title: Removing Gravatar ID from user payloads
created_at: 2014-09-05
author_name: mastahyeti
---

We have deprecated the `gravatar_id` attribute in the [user
representation](https://developer.github.com/v3/users/). Starting September 19,
the API will always provide an empty string as the value for this attribute.

Users have been able to upload avatars directly to GitHub for [a while
now](https://github.com/blog/1803-switch-your-picture-with-ease). If users
haven't uploaded an avatar, we still try to fetch one from Gravatar, but that
happens behind the scenes on GitHub's servers. As a result, the `gravatar_id`
attribute no longer identifies a GitHub user's canonical avatar. Instead, API
consumers should use the `avatar_url` to fetch a user's avatar. The `avatar_url`
attribute has always been present in the [v3 user representation](/v3/users/)
and is the only reliable way to find a GitHub user's avatar.

If you have any questions or feedback, please [get drop us a line][contact].

[contact]: https://github.com/contact?form[subject]=Removing+Gravatar+ID
