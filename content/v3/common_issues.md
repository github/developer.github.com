---
title: Common Issues | GitHub API
---

# Common Issues

* TOC
{:toc}

If you're encountering some oddities in the API, here's a list of resolutions to
some of the problems you may be experiencing.

## Why am I getting a `404` error on a repository that exists?

Typically, we send a `404` error when your client isn't properly authenticated.
You might expect to see a `403 Forbidden` in these cases. However, since we don't
want to provide _any_ information about private repositories, the API returns a
`404` error instead.

To fix this, you can either ensure that [you're authenticating correctly](/guides/getting-started/),
or [make sure that your scopes are valid](/v3/oauth/#scopes).

## Why am I not seeing all my results?

Most API calls support pagination, so you'll need to walk through all of the results
in your request to make sure you can find what you expect.

It's important to *not* try and guess the format of the pagination URL. Not every
API call uses the same structure. Instead, extract the pagination information from
[the Link Header](/v3/#pagination) sent with every request.
  
## Can I get my rate limits bumped?
