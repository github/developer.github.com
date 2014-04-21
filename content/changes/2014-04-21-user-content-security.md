---
kind: change
title: New user content domains
created_at: 2014-04-21
author_name: azizshamim
---

## Securing your content

A couple of different cross-domain vulnerabilities were highlighted as a result of our [Bounty program](https://bounty.github.com). In order to better isolate user content, we've moved user generated content to be served from multiple subdomains of `githubusercontent.com`.

### Older links

As of today, we're forcing the old domains to redirect to the new domains. Don't worry, your old links should still work in the browser and if you're using a URL from Gist or GitHub to directly access raw content, configure your `curl`, `wget` or library (like [HTTParty](https://github.com/jnunemaker/httparty)) application to follow the redirect.

### Your proxies or filters

This means that some security systems like web proxies may not recognize the domain `githubusercontent.com`. You might need update your proxies and security software accordingly.

### What's affected
* raw.github.com : raw links to the content from your repository
* embed.github.com : embedded renders of maps and 3D models and other cool technohotness
* render.github.com : renders the embedded content
* f.cloud.github.com : all those amazing gifs you use in Pull Requests and Issues

*Happy and Safe GitHubbing!*
As always, if you have any questions, please [get in touch][contact].

[contact]: https://github.com/contact?form[subject]=Changes+to+user+content+domains
