---
kind: change
title: GitHub Pages' A Records Added to Meta API
created_at: 2015-06-11
author_name: leereilly
---

The [Meta API](/v3/meta/) now includes the A record IP addresses for [GitHub Pages](https://pages.github.com/).

{:.terminal}
    $ curl https://api.github.com/meta

    #!javascript
    {
      "verifiable_password_authentication": true,
      "github_services_sha": "23c6105183b626cf74c045f6d53af7a178bfdb4c",
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
    }

These IP addresses are used to [configure A records with your DNS provider for GitHub Pages](https://help.github.com/articles/tips-for-configuring-an-a-record-with-your-dns-provider/). These addresses have changed a few times in the past. This API always provides the current addresses so that you can automate the process of keeping your DNS records up to date.

If you have any questions, please [get in touch](https://github.com/contact?form%5Bsubject%5D=GitHub+Pages+A+Records+Added+to+API). We’ll be happy to help.
