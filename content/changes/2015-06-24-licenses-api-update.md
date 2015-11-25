---
kind: change
title: Licenses API update
created_at: 2015-06-24
author_name: mislav
---

We are expanding the [Licenses API](/v3/licenses) to make it more useful for auditing license usage across all repositories owned by a user or organization.

Before, license information was only returned for an individual repository:

    GET /repos/github/hubot

Now, license information will also be included in reponses from endpoints that list multiple repositories, such as [List organization repositories](/v3/repos/#list-organization-repositories):

    GET /orgs/github/repos

As before, to access the API during the preview period, you must provide a custom [media type](/v3/media) in the `Accept` header:

    application/vnd.github.drax-preview+json

For more information, see the [Licenses API documentation](/v3/licenses/), and if you have any questions or feedback, please [let us know](https://github.com/contact?form%5Bsubject%5D=Licenses+API).
