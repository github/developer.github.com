---
kind: change
title: Page Build Event Webhook
created_at: 2014-3-05
author_name: benbalter
---

We've added an additional event to the available webhooks: GitHub Pages builds.

Builds for GitHub Pages sites are triggered upon pushing to a specified branch (`master` for user and organization pages, and `gh-pages` for project pages). If the `page_build` event hook is enabled, after GitHub Pages attempts to build your site, you will receive a payload containing the status of the build, and if the build resulted in an error, the error message itself.

If you have the "send me everything" option selected for your repository (or use the "wildcard event" via the API), you should receive the event on your next push. Otherwise, you must enable the new hook on your repository's webhook settings page.

For more information, see [the event types documentation](http://developer.github.com/v3/activity/events/types/).
