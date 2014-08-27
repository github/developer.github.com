---
kind: change
title: New features for the Deployments API preview
created_at: 2014-09-01
author_name: leereilly
---

The [Meta API](https://developer.github.com/v3/meta/) now includes the A record IP addresses for [GitHub Pages](https://pages.github.com/).

<pre class="terminal">
$ curl https://api.github.com/meta
</pre>

```javascript
  "verifiable_password_authentication": true,
  "hooks": [
    "192.30.252.0/22"
  ],
  "git": [
    "192.30.252.0/22"
  ],
  "pages": [
    "192.30.252.153/32",
    "192.30.252.154/32"
  ]
```

These IP addresses have changed a handful of times in the past, so this is a good way to identify them and keep them up to date.
