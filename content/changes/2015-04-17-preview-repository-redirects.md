---
kind: change
title: Preview repository redirects
created_at: 2015-04-17
author_name: jasonrudolph
---

From time to time, repository names change. If you make a GitHub API request using a repository's old name in the URL, the API has historically responded with `404 Not Found`. To help API clients gracefully handle renamed repositories, the API will soon begin [redirecting][redirects] to the repository's new location.

You can preview these redirects now. In the coming weeks, we'll announce the timeline for enabling these redirects for everyone.

## How can I try out the redirects?

Starting today, developers can preview the redirect functionality for relocated repositories. To access this redirect functionality during the preview period, you’ll need to provide the following custom [media type][] in the `Accept` header:

    application/vnd.github.quicksilver-preview+json

During the preview period, we may change aspects of the redirect behavior based on developer feedback. If we do, we will announce the changes here on the developer blog, but we will not provide any advance notice.

## When will the redirects occur?

To understand when these redirects would take place, you'll want to understand how to identify a repository's location. Repositories are located using the combination of the owner's name and the repository's name. For example, the [@twbs][] organization owns the popular [bootstrap repository](https://github.com/twbs/bootstrap). We identify this repository as [twbs/bootstrap](https://github.com/twbs/bootstrap).

The repository's location changes in the following scenarios:

- When the owner changes the repository name.
- When the owner renames their user account or organization account.
- When the owner transfers the repository to a new owner.

Continuing our [twbs/bootstrap](https://github.com/twbs/bootstrap) example, this repository used to be owned by the [@twitter][] organization, and it was therefore located at [twitter/bootstrap](https://github.com/twitter/bootstrap). With repository redirects, you'll be able to make an API request using the repository's old location and receive [either a `301` or `307` HTTP redirect][redirects], depending on the type of request being made. You can then follow the redirect to the new location.

## Send us your feedback

We hope you'll take these redirects for a spin and [let us know what you think][contact]. Happy redirecting!

[@twbs]: https://github.com/twbs
[@twitter]:  https://github.com/twitter
[contact]: https://github.com/contact?form%5Bsubject%5D=API+Repository+Redirects
[media type]: /v3/media/
[redirects]: /v3/#http-redirects
