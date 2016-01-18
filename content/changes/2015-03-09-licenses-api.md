---
kind: change
title: Licenses API
created_at: 2015-03-09
author_name: benbalter
---

We're introducing a new [license API](/v3/licenses) preview to support [open source license usage on GitHub.com](https://github.com/blog/1964-license-usage-on-github-com).

To access the API during the preview period, you must provide a custom [media type](/v3/media) in the `Accept` header:

    application/vnd.github.drax-preview+json

This will then expose two new API endpoints. You can get a list of all known licenses:

    GET /licenses

Or get information about a particular license:

    GET /licenses/mit

When the preview media type is passed, the repository api will also return information about a repository's license file when you get an individual repository:

    GET /repos/github/hubot

For more information, see the [licenses API documentation](/v3/licenses/), and if you have any questions or feedback, please [let us know](https://github.com/contact?form%5Bsubject%5D=Licenses+API).
