---
kind: change
title: Page Build Event Webhook
created_at: 2014-3-05
author_name: benbalter
---

We've added an additional event to the list of available webhook events: GitHub Pages builds.

As you may know, builds for GitHub Pages sites are triggered upon pushing to a specified branch (`master` for user and organization pages, and `gh-pages` for project pages). Now, if the `[page_build](http://developer.github.com/v3/activity/events/types/#buildevent_)` event is enabled for a given webhook, when GitHub Pages attempts to build your site, you will receive an event payload containing the status of the build, and if the build resulted in an error, the error message itself.

If you have the "send me everything" option selected (or use the "wildcard event" via the API), you should receive the event on your next push. Otherwise, you must enable the new event on your repository's webhook settings page.

For more information, see [the event types documentation](http://developer.github.com/v3/activity/events/types/).
