---
kind: change
title: Search API Becomes an Official Part of API v3
created_at: 2013-10-29
author_name: jasonrudolph
---

We're excited to announce that the [new Search API][search-api] has graduated from [preview mode][preview-period].
As of today, the Search API is an official part of [GitHub API v3](/v3).
As such, the Search API is now stable and suitable for production use.

### Preview Media Type No Longer Needed

If you used the Search API during the preview period, you needed to provide a custom media type in the `Accept` header:

    application/vnd.github.preview+json

Now that the preview period has ended, you no longer need to pass this custom media type.

Instead, we [recommend][media-types] that you specify `v3` as the version in the `Accept` header:

    application/vnd.github.v3+json

### Onward!

Thanks again to everyone that tried out the Search API during the preview period.

We can't wait to see what you build!

[media-types]: /v3/media
[preview-period]: /changes/2013-07-19-preview-the-new-search-api/#preview-period
[search-api]: /v3/search
