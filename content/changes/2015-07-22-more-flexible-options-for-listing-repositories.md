---
kind: change
title: More flexible options for listing repositories
created_at: 2015-07-22
author_name: jakeboxer
---

We're offering an improved way to filter the repositories returned by the [List your repositories][list-your-repos] API. We've added two new parameters that supercede the old `type` parameter: `visibility` and `affiliation`.

The `visibility` parameter filters repositories by their visibility. It defaults to `"all"`, but you can pass `"public"` or `"private"` to only list public or private repositories (respectively).

The `affiliation` parameter filters repositories by how they're affiliated with the authenticated user. You can choose from three different affiliations:

- If you pass `"owner"`, you'll include repositories that are owned by the authenticated user.
- If you pass `"collaborator"`, you'll include repositories that the authenticated user has been added as a collaborator to.
- If you pass `"organization_member"`, you'll include repositories that the authenticated user has access to through an organization membership. For example, this will include all repositories that have been added to teams the authenticated user is on.

If you want to include repositories that span multiple types of affiliation, you can pass a comma-separated string. For example, if you want a list of all the repositories that the user owns or is a collaborator on, you can pass `affiliation=owner,collaborator`. If no `affiliation` parameter is passed, it defaults to `affiliation=owner,collaborator,organization_member`.

The `type` parameter will continue to function as normal, but if you'd like to learn how to take advantage of these new parameters, check out [the API documentation][list-your-repos].

If you have any questions or feedback, please [get in touch with us][contact]!

[list-your-repos]: /v3/repos/#list-your-repositories
[contact]: https://github.com/contact?form[subject]=List+your+repositories+API
