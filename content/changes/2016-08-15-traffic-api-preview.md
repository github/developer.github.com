---
title: Preview the Repository Traffic API
author_name: shreyasjoshis
---

 We've added an API for repository traffic, which will let you fetch details about traffic for repositories you have push access to. This data is already available in graphical form in the [Graphs section](https://help.github.com/articles/about-repository-graphs/#traffic) on GitHub.com.

To access [the Traffic API][docs] during the preview period, you must provide a custom [media type][media-type] in the `Accept` header:

    application/vnd.github.spiderman-preview

During the preview period, we may change aspects of these API methods based on developer feedback. If we do, we will announce the changes here on the developer blog, but we will not provide any advance notice.

If you have any questions or feedback, please [let us know][contact]!

[media-type]: /v3/media
[docs]: /v3/repos/traffic/
[contact]: https://github.com/contact?form%5Bsubject%5D=Traffic+API
