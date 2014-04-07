---
title: Troubleshooting | GitHub API
---

# Troubleshooting

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

Most API calls accessing a list of resources (_e.g._, users, issues, _e.t.c._) support
pagination. If you're making requests and receiving an incomplete set of results, you're
probably only seeing the first page. You'll need to request the remaining pages
in order to get more results.

It's important to *not* try and guess the format of the pagination URL. Not every
API call uses the same structure. Instead, extract the pagination information from
[the Link Header](/v3/#pagination), which is sent with every request.

## Can I get my rate limits bumped?

The GitHub API has a pretty lenient quota for rate limits, for your enjoyment and
our safety. You can read more about it [here](/v3/#rate-limiting).

If you're using OAuth or Basic Authentication and are hitting your rate limits,
you might be able to fix the issue by either caching our results, or [using conditional requests](/v3/#conditional-requests).

In certain exceptional cases, we may temporarily bump your rate limit higher. You
should be prepared to answer technical questions about your goal and your planned usage of the API. We may still choose not to bump your limit if we feel that you can achieve your wildest
dreams with the current rate limit (but don't worry, we'll help you out).

## Why can't my server with SSL receive Webhooks?

When we send events to your server, we attempt to negotiate either SSL version 2 or 3.
If your server requires a specific SSL version and does not support SSL negotiation,
you can specify a specific version within the [webhook's config block](https://developer.github.com/v3/repos/hooks/#edit-a-hook). Include a parameter called `ssl_version`, with a value of either `2` or `3`.
