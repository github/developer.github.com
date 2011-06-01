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
behavior will be supported until the dates listed below. Please be sure
to update your app in time.

### Behavior due to be removed by June 1st:

* Update requests used to accept the PUT verb.  Now POST or PATCH should
  be used.
* All URLs had a `.json` extension.  They don't anymore (but old
  requests work still).
* Pagination info is returned in the Link header.  Stop using the X-Next
  or X-Last headers.
* JSON-P response has completely changed to a more consistent format.
* Starring gists now uses PUT verb (instead of POST) and returns 204.

### Behavior due to be removed by June 15th:

* `gravatar_url` is being deprecated in favor of `avatar_url` for all
  responses that include users or orgs. A default size is no longer
  included in the url.
* creating new gists (both anonymously and with an authenticated user)
  should use `POST /gists` from now on. `POST /users/:user/gists` will
  be deprecated.

