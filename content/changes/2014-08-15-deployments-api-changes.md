---
kind: change
title: New features for the Deployments API preview
created_at: 2014-08-15
author_name: atmos
---

We've added two new feature to the [Deployments API preview][deployments-preview]: the ability to query deployments and a new task attribute for naming events.

## API Changes

You can now search for deployments via query parameters to the [listing endpoint][listing-endpoint]. You can filter on `sha`, `ref`, `task`, and `environment`. This makes it easier to answer questions like "when was the last time someone deployed to staging?"

<pre class="terminal">
$ curl -H "Authorization: token [yours]" \
       https://api.github.com/repos/octocat/my-repo/deployments?environment=staging
</pre>

## New Attribute

We've also added a `task` attribute to the deployments model. The `task` attribute exists to allow you to specify tasks other than just pushing code. Popular deployment tools like [capistrano][capistrano] and [fabric][fabric] support named tasks to do things like run schema migrations. We hope this attribute will give integrators the flexibility they need to provide custom functionality.

If you have any questions or feedback, please [get in touch][contact].

[contact]: https://github.com/contact?form[subject]=Deployments+API
[deployments-preview]: https://developer.github.com/changes/2014-01-09-preview-the-new-deployments-api/
[listing-endpoint]: https://developer.github.com/v3/repos/deployments/#list-deployments
[fabric]: http://www.fabfile.org/
[capistrano]: http://capistranorb.com/
