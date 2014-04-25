---
kind: change
title: New user content domains
created_at: 2014-04-25
author_name: azizshamim
---

## Securing your content

The [GitHub Bug Bounty program](https://bounty.github.com) recently identified a few cross-domain vulnerabilities related to user-generated content, and we've shipped improvements today to address those issues.

In order to better isolate your content from potentially malicious content uploaded by other users (e.g., content that might contain Cross-Site Scripting or other embedded attacks), we now serve user-generated content from subdomains of **githubusercontent.com**. This content is no longer served from subdomains of **github.com**.

## What's affected?

This change affects the following subdomains:

* **raw.github.com** : Serves raw file content from your repository.
* **embed.github.com** : Allows users to embed rich GitHub content on other sites.
* **render.github.com** : Displays rich content on GitHub.com.
* **f.cloud.github.com** : Hosts all those amazing gifs you use in Pull Requests and Issues.

Content formerly served by these subdomains is now served from subdomains of **githubusercontent.com**.

## Older links

If you have old links to this content, don't worry: as of today, we're forcing the old domains to redirect to the new domains. Your existing links should continue to work automatically in your browser. If you're using a URL from Gist or GitHub to directly access user-generated content via `curl`, `wget`, or a library (like [HTTParty](https://github.com/jnunemaker/httparty)), be sure to configure that tool to follow the redirect.

## Your proxies or filters

Some security systems (web proxies, for example) may not recognize the **githubusercontent.com** domain. In those cases, you may need update your proxies and security software accordingly.

As always, if you have any questions, please [get in touch][contact].

*Happy and safe GitHubbing!*

[contact]: https://github.com/contact?form[subject]=Changes+to+user+content+domains
