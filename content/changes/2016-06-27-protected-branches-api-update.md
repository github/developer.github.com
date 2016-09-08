---
title: Update to Protected Branches API Preview
author_name: tma
---

Over the past few months, we've made a few [improvements](https://github.com/blog/2137-protected-branches-improvements) to the way [protected branches](https://github.com/blog/2051-protected-branches-and-required-status-checks) work in our web interface. Today, we're modifying the protected branches API [preview period](https://developer.github.com/changes/2015-11-11-protected-branches-api/) to include these improvements.

Included in these API changes is the ability to allow organizations to specify which members and teams should be able to push to a protected branch, as well as providing a new setting for required status checks which will remove the requirement of a pull request to be up to date before merging.

You'll notice a new endpoint structure. One set of endpoints for modifying the branch settings as a whole (`PATCH /repos/:owner/:repo/branches/:branch` has been updated to be `PUT /repos/:owner/:repo/branches/:branch/protection`), and a series of more granular endpoints to modify a subset of the branch protection settings.

**This will be a breaking change for the protected branch API.** The deprecated API endpoint will be removed when the protected branches API will leave the preview period. If you're trying out the old protected branches API, you'll need to update your code.

#### How can I try it?

To access this functionality during the preview period, you’ll need to provide the following custom media type in the Accept header:

```
application/vnd.github.loki-preview+json
```

Take a look at [the docs here](/v3/repos/branches/). If you have any questions, please [get in touch](https://github.com/contact?form%5Bsubject%5D=Protected+Branches+API+Preview).
