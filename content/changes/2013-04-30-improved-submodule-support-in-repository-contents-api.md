---
kind: change
title: Improved Support for Submodules in the Repository Contents API
created_at: 2013-04-30
author_name: jasonrudolph
---

When you view a repository with a submodule on github.com, you get useful links and information for the submodule.

[![Repository Contents with Submodule](/images/posts/submodule-links.png)][screenshot]

Today we're making that data available in the [Repository Contents API][docs].

<pre class="terminal">
curl https://api.github.com/repos/jquery/jquery/contents/test/qunit

{
  "name": "qunit",
  "path": "test/qunit",
  "type": "submodule",
  "submodule_git_url": "git://github.com/jquery/qunit.git",
  "sha": "6ca3721222109997540bd6d9ccd396902e0ad2f9",
  "size": 0,
  "url": "https://api.github.com/repos/jquery/jquery/contents/test/qunit?ref=master",
  "git_url": "https://api.github.com/repos/jquery/qunit/git/trees/6ca3721222109997540bd6d9ccd396902e0ad2f9",
  "html_url": "https://github.com/jquery/qunit/tree/6ca3721222109997540bd6d9ccd396902e0ad2f9",
  "_links": {
    "self": "https://api.github.com/repos/jquery/jquery/contents/test/qunit?ref=master",
    "git": "https://api.github.com/repos/jquery/qunit/git/trees/6ca3721222109997540bd6d9ccd396902e0ad2f9",
    "html": "https://github.com/jquery/qunit/tree/6ca3721222109997540bd6d9ccd396902e0ad2f9"
  }
}
</pre>

If you have any questions or feedback, please drop us a line at
[support@github.com](mailto:support@github.com?subject=Submodules in Repository Contents API).

[docs]: /v3/repos/contents/#get-contents
[screenshot]: /images/posts/submodule-links.png
