---
kind: change
title: GitHub Pages' A Records Added to Meta API
created_at: 2015-06-04
author_name: leereilly
---

The [Meta API](https://developer.github.com/v3/meta/) now includes the A record IP addresses for [GitHub Pages](https://pages.github.com/).

<pre class="terminal">
$ curl https://api.github.com/meta
</pre>

<pre><code class="language-javascript">
{
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
  ],
  "importer": [
    "54.80.154.161",
    "54.163.55.203",
    "54.166.141.155",
    "54.80.168.241",
    "54.159.221.200",
    "54.196.81.106",
    "54.158.161.132"
  ]
}
</code></pre>

These IP addresses have changed a handful of times in the past, so this is a good way to identify them and keep them up to date.
