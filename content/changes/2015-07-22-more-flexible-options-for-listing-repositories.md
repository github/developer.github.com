---
kind: change
title: More flexible options for listing repositories
created_at: 2015-07-22
author_name: jakeboxer
---

The [List your repositories][list-your-repos] API now offers additional parameters to help you fetch the exact set of repositories you're looking for:

- The `visibility` parameter lets you request only your public repositories, only your private repositories, or both.
- With the `affiliation` parameter, you can ask for repositories you own, repositories where you are a collaborator, repositories you have access to as an organization member, or any combination that suits your needs.

Use these new parameters separately, together, or in combination with other parameters to craft flexible queries that fetch the specific repositories you're seeking.

For full details, check out the [documentation][list-your-repos]. If you have any questions, please [get in touch][contact]!

[list-your-repos]: /v3/repos/#list-your-repositories
[contact]: https://github.com/contact?form[subject]=List+your+repositories+API
