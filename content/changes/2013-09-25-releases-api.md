---
kind: change
title: Releases API
created_at: 2013-09-25
author_name: technoweenie
---

This summer we made it easier to [release your software][blawg].  Today, you can fully automate those releases via the
[Releases API Preview][api].

This API is a little different due to the binary assets.  We use the `Accept` header for content negotiation when requesting
a release asset.  Pass a standard API media type to get the API representation:

<pre class="terminal">
$ curl -i -H "Authorization: token TOKEN" \
     -H "Accept: application/vnd.github.manifold-preview" \
     "https://uploads.github.com/repos/hubot/singularity/releases/assets/123"

HTTP/1.1 200 OK

{
  "id": 123,
  ...
}
</pre>

Pass "application/octet-stream" to download the binary content.

<pre class="terminal">
$ curl -i -H "Authorization: token TOKEN" \
     -H "Accept: application/octet-stream" \
     "https://uploads.github.com/repos/hubot/singularity/releases/assets/123"

HTTP/1.1 302 Found
</pre>

Uploads are handled by a single request to a companion "uploads.github.com" service.

<pre class="terminal">
$ curl -H "Authorization: token TOKEN" \
     -H "Accept: application/vnd.github.manifold-preview" \
     -H "Content-Type: application/zip" \
     --data-binary @build/mac/package.zip \
     "https://uploads.github.com/repos/hubot/singularity/releases/123/assets?name=1.0.0-mac.zip"
</pre>

## Preview mode

The new API is available as a [preview][preview].  This gives developers a chance to [provide feedback][contact] on the direction of
the API before we freeze changes.  We expect to lift the preview status in 30 days.

As with [the Search API][searchapi], we'll take this opportunity to iterate quickly.  Breaking changes will be announced
on this developer blog without any advance warning.  Once the preview period is over, we'll consider the Releases API unchangeable.
At that point, it will be stable and suitable for production use.

The preview media type is "application/vnd.github.manifold-preview".  [Manifold](http://en.wikipedia.org/wiki/Eden_Fesi) is
a member of the Avengers, with the ability to teleport through time and space.  He's the one in the middle holding the spear.

![Manifold teleporting the Avengers to a terraformed Mars surface](https://f.cloud.github.com/assets/21/1210628/ae8556fa-25fc-11e3-986d-0ab522271d43.png)

[blawg]: https://github.com/blog/1547-release-your-software
[api]: http://developer.github.com/v3/repos/releases/
[preview]: http://developer.github.com/v3/repos/releases/#preview-mode
[searchapi]: http://developer.github.com/changes/2013-07-19-preview-the-new-search-api/
[contact]: https://github.com/contact?form[subject]=New+Releases+API
