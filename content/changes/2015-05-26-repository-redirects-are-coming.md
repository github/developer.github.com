---
kind: change
title: Repository redirects are coming to API v3 in July
created_at: 2015-05-26
author_name: jasonrudolph
---

Last month, we announced the [upcoming repository redirect behavior for the API][original announcement], and we made it available for developers to preview. Starting **July 21, 2015**, the API will automatically provide these redirects for all API consumers.

To learn more about repository redirects and how they will benefit your applications, be sure to check out the [original announcement][].

To start enjoying repository redirects right away, just provide the following custom [media type][] in the `Accept` header:

    application/vnd.github.quicksilver-preview+json

Thanks to everyone that tried out this enhancement during the preview period.

As always, if you have any questions, please [get in touch][contact]. We love hearing from you.

[media type]: /v3/media/
[original announcement]: /changes/2015-04-17-preview-repository-redirects/
[contact]: https://github.com/contact?form%5Bsubject%5D=API+Repository+Redirects
