---
kind: change
title: Removing Gravatar ID from user payloads
created_at: 2014-09-03
author_name: mastahyeti
---

The `gravatar_id` field in the [user
schema](https://developer.github.com/v3/users/) is being deprecated. Starting on
September 17th, an empty string will be returned for this field.

Users have been able to upload avatars directly to GitHub for [a while
now](https://github.com/blog/1803-switch-your-picture-with-ease). If users
haven't uploaded an avatar, we still try to fetch one from Gravatar, but this is
proxied through our own servers. This means that the `gravatar_id` field from
the [user schema](https://developer.github.com/v3/users/) is no longer useful
for finding users' GitHub avatar. Instead, the `avatar_url` field should be
used. This field has always been present in the [v3 user
schema](https://developer.github.com/v3/users/) and is the only reliable way to
find users' GitHub avatars. 
