---
kind: change
title: Releases API is Official
created_at: 2013-11-04
author_name: technoweenie
---

Hot on the heels of the [Search API][search-api], the [Releases API][releases-api]
is now officially part of GitHub API v3.  We now consider it stable for
production use.  

### Preview Media Type No Longer Needed

If you used the Releases API during the preview period, you needed to provide a custom media type in the `Accept` header:

    application/vnd.github.manifold-preview+json

Now that the preview period has ended, you no longer need to pass this custom media type.

Instead, we [recommend][media-types] that you specify `v3` as the version in the `Accept` header:

    application/vnd.github.v3+json

### Onward!

Thanks again to everyone that tried out the Releases API during the preview period.
We got some great feedback, and we are already discussing additions to the API.

We can't wait to see what you ship!

[media-types]: /v3/media
[preview-period]: /changes/2013-07-19-preview-the-new-search-api/#preview-period
[releases-api]: /v3/repos/releases/
[search-api]: http://developer.github.com/changes/2013-10-29-search-api-becomes-an-official-part-of-github-api-v3/
