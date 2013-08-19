---
kind: change
title: Improvements to the Search API
created_at: 2013-08-21
author_name: jasonrudolph
---

Today we're shipping two improvements to the [new Search API][original-search-api-announcement].

## More Text Match Metadata

When searching for code, the API previously provided [text match metadata][text-matches] (i.e., "highlights") for file content.
Now, you can also [get this metadata][code-text-matches] for matches that occur within the file path.

## Better Text Match Metadata

Before today, the API applied HTML entity encoding to all `fragment` data.
For example, imagine your search returns an issue like [rails/rails#11889][example-issue].

![screen shot 2013-08-19 at 4 16 01 pm](https://f.cloud.github.com/assets/2988/988956/8e50a87e-090c-11e3-8807-c31d5ada4ea4.png)

The response would include a `text_matches` array with the following object:

<pre class="json">
{
  "fragment": "undefined method `except' for #&amp;lt;Array:XXX&amp;gt;",
  // ...
}
</pre>

Inside the `fragment` value, we see HTML-encoded entities (e.g., `&lt;`).
Since we're returning JSON (not HTML), API clients do not expect HTML-encoded text.

As of today, the API returns these fragments _without_ this extraneous encoding.

<pre class="json">
{
  "fragment": "undefined method `except' for #&lt;Array:XXX&gt;",
  // ...
}
</pre>

## Preview Period

We're about halfway through the [preview period][preview-period] for the new Search API.
We appreciate everyone that has provided feedback so far. Please [keep it coming][contact].

[contact]: https://github.com/contact?form[subject]=New+Search+API
[code-text-matches]: /v3/search/#highlighting-code-search-results
[example-issue]: https://github.com/rails/rails/issues/11889
[original-search-api-announcement]: /changes/2013-07-19-preview-the-new-search-api/
[preview-period]: /changes/2013-07-19-preview-the-new-search-api/#preview-period
[text-matches]: /v3/search/#text-match-metadata
