---
title: "Breaking change: Removed sensitive fields from Organization API responses for non-owners"
author_name: kdaigle
---

We're removing some values from [Organization API](https://developer.github.com/v3/orgs/) responses to help protect our
users' privacy. Previously, these fields were returned to all members of the organization.
As of today, you must be an Organization owner to
receive values for the following fields in Organization responses:

* `private_gists`
* `disk_usage`
* `collaborators`
* `billing_email`

If you're not an organization owner, the above keys will now return `null`.
We will continue to send these fields without their values to minimize the impact
of this change.

If you have any questions or feedback, please [drop us a line][contact].

[contact]: https://github.com/contact?form[subject]=Removed+sensitive+fields+from+org+api
