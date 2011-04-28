---
title: developer.github.com
---

# developer.github.com

This describes the Resources that make up the official GitHub API v3.
You can look at the [API v2](http://develop.github.com/) to access
resources that have not yet been added to v3.

For the new API v3, start browsing the implemented resources on the
right >>

Visit [GitHub API
Support](http://support.github.com/discussions/api) if you
have any problems or requests.

## Breaking BETA Changes

We're making some small tweaks to the API during the BETA phase.  Old
behavior is still supported, but due to be removed by June 1.  Please be
sure to update your app in time.

* Update requests used to accept the PUT verb.  Now POST or PATCH should
  be used.
* All URLs had a `.json` extension.  They don't anymore (but old
  requests work still).
