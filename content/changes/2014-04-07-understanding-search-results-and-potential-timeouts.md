---
kind: change
title: Understanding search results and potential timeouts
created_at: 2014-04-07
author_name: izuzak
---

Some queries are computationally expensive for our search infrastructure to
execute. To keep the [Search API](/v3/search) fast for everyone, we limit how
long any individual query can run. In rare situations when a query exceeds the
time limit, the API returns all matches that were found prior to the timeout.

Starting today, the Search API also now [informs you when such a timeout
happens](/v3/search/#timeouts-and-incomplete-results). Reaching a timeout does
not necessarily mean that search results are incomplete. It just means that the
query was discontinued before it searched through all possible data. More
results might have been found, but also might not.

In some cases, if you know that your search results are potentially incomplete,
you might think about the data differently. By exposing timeouts when they
happen, the API helps you better understand how to interpret the results.

We hope this is useful as you integrate with the Search API. In the meantime,
we're working on improving search so that these timeouts occur as rarely as
possible. If you have any questions, [let us know](https://github.com/contact?form%5Bsubject%5D=Search+API).
