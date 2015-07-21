---
kind: change
title: Automatic redirects for renamed repositories
created_at: 2015-07-21
author_name: jasonrudolph
---

To help API clients gracefully handle renamed repositories, the API now [automatically redirects to the repository’s new location][original-announcement].

Our thanks goes out to everyone that tried out this enhancement [during the preview period][original-announcement]. During the preview period, you needed to [provide a custom media type in the `Accept` header][preview-media-type] to opt-in to the redirects. Now that the preview period has ended, you no longer need to specify this custom [media type][].

To learn more about these redirects and how they benefit your applications, be sure to check out the [preview period announcement][original-announcement]. As always, if you have any questions, we're [here to help][contact].

[contact]: https://github.com/contact?form%5Bsubject%5D=API+Repository+Redirects
[media type]: /v3/media/
[original-announcement]: /changes/2015-04-17-preview-repository-redirects/
[preview-media-type]: /changes/2015-04-17-preview-repository-redirects/#how-can-i-try-out-the-redirects
