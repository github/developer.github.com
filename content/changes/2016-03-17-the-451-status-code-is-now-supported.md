---
title: The 451 status code is now supported
author_name: gjtorikian
---

In December 2015, [the IETF ratified status code `451`](https://datatracker.ietf.org/doc/rfc7725/). A `451` response indicates that a resource is unavailable due to an external legal request.

The GitHub API will now respond with a `451` status code for resources it has been asked to take down due to a DMCA notice. For example:

``` command-line
$ curl https://api.github.com/repos/github/a-repository-that-s-been-taken-down
> HTTP/1.1 451
> Server: GitHub.com

> {
>  "message": "Repository access blocked",
>  "block": {
>    "reason": "dmca",
>    "created_at": "2016-03-17T15:39:46-07:00"
>  }
> }
```

This `451` code will be returned for repositories and gists. Previously, the API responded with a `403 - Forbidden`. Aside from the semantic difference, we feel that it's important for users to know precisely why their data cannot be served.

If you're receiving a `451` due to a DMCA takedown, please read our article on [submitting a DMCA counter notice](https://help.github.com/articles/guide-to-submitting-a-dmca-counter-notice/) and know your rights. For more information, see [GitHub's DMCA Takedown Policy](https://help.github.com/articles/dmca-takedown-policy/).
