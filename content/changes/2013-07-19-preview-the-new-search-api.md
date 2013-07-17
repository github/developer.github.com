---
kind: change
title: Preview the New Search API
created_at: 2013-07-19
author_name: jasonrudolph
---

Today we're excited to announce a [brand new Search API][docs]. Whether you're
searching for [code][code-docs], [repositories][repo-docs],
[issues][issue-docs], or [users][user-docs], all the query abilities of
github.com are now available via the API as well.

Maybe you want to find popular Tetris implementations written in Assembly. We've
[got you covered][tetris-repos]. Or perhaps you're looking for new gems that are
using Octokit.rb. [No problem][octokit-gemspecs]. The possibilites are endless.

## Highlights

On github.com, we enjoy the context provided by code snippets and highlights in
search results.

[![code-snippet-highlighting](https://f.cloud.github.com/assets/2988/811920/3c01eab0-eee5-11e2-82a7-dc0785392eaa.png)][example-web-search]

We want API consumers to have access to that information as well. So, API
requests can opt to recieve those text fragments in the response. Each fragment
is accompanied by numeric offsets identifying the exact location of each
matching search term. (TODO: Add a link.)

## Preview period

We're making this new API available today for developers to
[preview][preview-mode]. We think developers are going to love it, but we want
to get your feedback before we declare the Search API "final" and
"unchangeable." We expect the preview period to last for roughly 60 days.

As we discover opportunities to improve this new API during the preview period,
we may ship changes that break clients using the preview version of the API. We
want to iterate quickly. To do so, we will announce any changes here (on the
developer blog), but we will not provide any advance notice.

At the end of preview period, the Search API will become an official component
of GitHub API v3. At that point, the new Search API will be stable and suitable
for production use.

## Take it for a spin

We hope you'll kick the tires and [send us your feedback][contact]. Happy
<del>searching</del> finding!

[code-docs]: http://localhost:3000/v3/search/#search-code
[contact]: https://github.com/contact?form[subject]=New+Search+API
[docs]: http://localhost:3000/v3/search/
[example-web-search]: https://github.com/search?q=faraday+builder+repo%3Aoctokit%2Foctokit.rb&type=Code&ref=searchresults
[issue-docs]: http://localhost:3000/v3/search/#search-issues
[octokit-gemspecs]: http://localhost:3000/v3/search/#code-search-example
[preview-mode]: http://localhost:3000/v3/search/#preview-mode
[repo-docs]: http://localhost:3000/v3/search/#search-repositories
[tetris-repos]: http://localhost:3000/v3/search/#repository-search-example
[user-docs]: http://localhost:3000/v3/search/#search-users

