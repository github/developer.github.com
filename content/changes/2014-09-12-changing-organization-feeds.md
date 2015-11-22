---
kind: change
title: Changing organization feeds in the Feeds API
created_at: 2014-09-12
author_name: mastahyeti
---

We have deprecated the `current_user_organization_url` attribute and the
`current_user_organization.href` attribute in the [Feeds API][docs]. If you make
use of these attributes, you'll want to update your code to use the new
`current_user_organization_urls` attribute instead.

### Changes to the deprecated attributes

Previously, the deprecated attributes returned URI template. For example:

    #!javascript
    "current_user_organization_url":
      "https://github.com/organizations/{org}/mastahyeti.private.atom?token=abc123"

The template included a deprecated authentication token. Our new tokens are
valid only for a concrete feed URL (not for a URI template). Because the
deprecated attributes were templates and did not specify a concrete URL, the API
could not provide a token that could be used for organization feeds.

Starting today, the API returns empty values for the deprecated attributes.

### New attribute for organization feeds

In order to preserve the functionality of this API, we have added a new
attribute that lists specific Atom feed urls for each of the user's
organizations.

    #!javascript
    "current_user_organization_urls": [
      "https://github.com/organizations/github/mastahyeti.private.atom?token=abc123"
      "https://github.com/organizations/requests/mastahyeti.private.atom?token=token=def456"
    ]

Check out the updated [Feeds API documentation][docs] for the new fields. If you
have any questions or feedback, please [get drop us a line][contact].

[docs]: /v3/activity/feeds/
[contact]: https://github.com/contact?form[subject]=Changing+organization+feeds+in+the+Feeds+API
