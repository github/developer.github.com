---
title: Introducing the GitHub Pages preview API
author_name: benbalter
---

We're introducing additional preview functionality to the [GitHub Pages API](/v3/repos/pages/) to give developers better control over their GitHub Pages site.

#### Requesting a page build

You can now manually request a build of your GitHub Pages site without needing to push a new commit by making a `POST` request to the endpoint already available to see past builds. For example:

``` command-line
curl "https://api.github.com/repos/github/developer.github.com/pages/builds" \
  -X POST
  -H 'Authorization: token TOKEN' \
  -H "Accept: application/vnd.github.mister-fantastic-preview" \
```

#### Retrieving a site's URL

With the introduction of [HTTPS support for GitHub Pages sites](https://github.com/blog/2186-https-for-github-pages), it's important to know not just a site's custom domain, if it has one, but also if it has HTTPS enforcement enabled. The GitHub Pages API will now return an additional `html_url` field, which will include the computed absolute URL to the site.

The resulting URL can be `https://username.github.io` (or `http://username.github.io`) for user sites without a custom domain, `https://username.gituhb.io/project` for project sites, or `http://example.com` for sites with custom domains, saving third-party applications the trouble of having to construct complicated URL logic based on the username, owner, and CNAME, as was previously necessary.

For example, to request the HTML URL:

``` command-line
curl "https://api.github.com/repos/github/developer.github.com/pages" \
  -H 'Authorization: token TOKEN' \
  -H "Accept: application/vnd.github.mister-fantastic-preview" \
```

#### How can I try it?

To access this functionality during the preview period, you’ll need to provide the following custom media type in the Accept header:

```
application/vnd.github.mister-fantastic-preview+json
```

During the preview period, we may change aspects of these API methods based on developer feedback. If we do, we will announce the changes here on the developer blog, but we will not provide any advance notice.

For more information, take a look at [the docs here](/v3/repos/pages/), and if you have any questions, please [get in touch](https://github.com/contact?form%5Bsubject%5D=GitHub+Pages+API+Preview).
