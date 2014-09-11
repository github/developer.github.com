---
kind: change
title: Changing organization feeds in the feeds API
created_at: 2014-09-11
author_name: mastahyeti
---

We have deprecated the `current_user_organization_url` attribute and the
`current_user_organization` hypermedia link in the [feeds API][docs]. Starting
September 11, 2014 blank values will be returned for these fields.

These fields included a deprecated authentication token. The new style of token
is valid only for a specific feed URL. Because the organization attributes were
templates and did not specify a full URL, a token could not be generated for
them.

In order to preserve the functionality of this API, we have added a new
attribute and hypermedia link that list specific Atom feed urls for each
organization the authenticated user is a member of. Check out the updated
[feeds API documentation][docs] for the new fields.

If you have any questions or feedback, please [get drop us a line][contact].

[docs]: /v3/repos/
[contact]: https://github.com/contact?form[subject]=Removing+organization+feeds+from+the+feeds+API
