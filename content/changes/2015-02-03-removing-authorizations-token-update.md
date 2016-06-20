---
kind: change
title: Removing token attribute from Authorizations API responses (Update)
created_at: 2015-02-03
author_name: ptoomey3
---

In December, we [released a preview][removing-authorizations-token] of several API changes related to managing OAuth application authorizations. As part of those changes we introduced several new response attributes (`token_last_eight`, `hashed_token`, and `fingerprint`) to the Authorizations API. We have decided to modify `hashed_token` to return the SHA-256 hex digest of the associated token instead of Base64. Given that Base64 has several common variants (original, URL safe, etc) we decided that returning the value as hex is less ambiguous and will be more useful for developers.

### Extended preview period

Because of the change to `hashed_token`, we are extending the preview period by two weeks. If no additional changes are made during this extended preview period we will announce the end of the preview and beginning of the eight week migration period on February 17. The migration period will allow applications to opt in to these changes before they become an official part of the GitHub API v3.

If you have any questions or feedback, please [drop us a line][contact]!

[removing-authorizations-token]: /changes/2014-12-08-removing-authorizations-token/
[contact]: https://github.com/contact?form[subject]=Removing+authorizations+token
