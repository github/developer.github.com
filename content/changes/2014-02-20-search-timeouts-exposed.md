---
kind: change
title: Search Timeouts Exposed
created_at: 2014-02-20
author_name: izuzak
---

Some queries are computationally expensive for our Search to execute. For performance reasons, there are limits to how long queries can be executed. In rare situations when a timeout is reached, Search collects and returns matches that were already found, and the execution of the query is stopped.

The Search API will now [inform you when such a timeout happens](/v3/search/#timeouts). Reaching a timeout does not necessarily mean that search results are incomplete. This just means that the Search was discontinued before it finished going through all data. More results might have been found, but also might have not.

As always, we're working on improving Search so that these timeouts are reached as rarely as possible. If you have any questions, [let us know](https://github.com/contact?form%5Bsubject%5D=APIv3).
