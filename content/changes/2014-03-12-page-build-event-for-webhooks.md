---
kind: change
title: Page Build Event for Webhooks
created_at: 2014-3-12
author_name: benbalter
---

We've made it even easier to track the status of your [GitHub Pages](http://pages.github.com/) builds. By subscribing to the new [`page_build`](/v3/activity/events/types/#pagebuildevent) event, your application will receive an event payload containing the results of each build. (As always, these builds occur automatically following each push to a GitHub Pages-enabled branch.)

If you have a [webhook](/webhooks/) with the ["send me everything" option](https://github.com/blog/1778-webhooks-level-up) selected (or if you use the "[wildcard event](/changes/2014-02-24-wildcard-event-for-webhooks/)" via the API), you will receive the `page_build` event after the next build of your GitHub Pages site. Alternatively, if you prefer to subscribe to specific event types, you can add to the new `page_build` event to your webhooks via your repository's webhook settings page or via the [webhooks API](/v3/repos/hooks/).

For more information, be sure to check out our guide on [working with webhooks](/webhooks/). If you have any questions or feedback, please [drop us a line][contact].

[contact]: https://github.com/contact?form%5Bsubject%5D=API+Page+Build+Event
