---
kind: change
title: Improvements to the Search API
created_at: 2013-08-20
author_name: jasonrudolph
---

Today we're shipping two improvements to the [new Search API][original-search-api-announcement].

## More Text Match Metadata

When searching for code, the API previously provided [text match metadata][text-matches] (i.e., "highlights") for file content.
Now, you can also [get this metadata][code-text-matches] for matches that occur within the file path.

For example, when [searching for files that have "client" in their path][example-path-search], the results include this match for `lib/octokit/client/commits.rb`:

<pre class="json">
{
  "name": "commits.rb",
  "path": "lib/octokit/client/commits.rb",
  "text_matches": [
    {
      "object_url": "https://api.github.com/repositories/417862/contents/lib/octokit/client/commits.rb?ref=8d487ab06ccef463aa9f5412a56f1a2f1fa4dc88",
      "object_type": "FileContent",
      "property": "path",
      "fragment": "lib/octokit/client/commits.rb",
      "matches": [
        {
          "text": "client",
          "indices": [ 12, 18 ]
        }
      ]
    }
  ]
  // ...
}
</pre>

## Better Text Match Metadata

Before today, the API applied HTML entity encoding to all `fragment` data.
For example, imagine your search returns an issue like [rails/rails#11889][example-issue]:

![Example Issue Title](https://f.cloud.github.com/assets/2988/994632/a84f2888-09af-11e3-9417-4bd92f1f1ed6.png)

The response would include a `text_matches` array with the following object:

<pre class="json">
{
  "fragment": "undefined method `except' for #&amp;lt;Array:XXX&amp;gt;",
  // ...
}
</pre>

Inside the `fragment` value, we see HTML-encoded entities (e.g., `&lt;`).
Since we're returning JSON (not HTML), API clients might not expect any HTML-encoded text.
As of today, the API returns these fragments _without_ this extraneous encoding.

<pre class="json">
{
  "fragment": "undefined method `except' for #&lt;Array:XXX&gt;",
  // ...
}
</pre>

## Preview Period

We're about halfway through the [preview period][preview-period] for the new Search API.
We appreciate everyone that has provided feedback so far. Please [keep it coming][contact]!

[contact]: https://github.com/contact?form[subject]=New+Search+API
[code-text-matches]: /v3/search/#highlighting-code-search-results
[example-issue]: https://github.com/rails/rails/issues/11889
[example-path-search]: https://github.com/search?q=%40octokit%2Foctokit.rb+in%3Apath+client&type=Code
[original-search-api-announcement]: /changes/2013-07-19-preview-the-new-search-api/
[preview-period]: /changes/2013-07-19-preview-the-new-search-api/#preview-period
[text-matches]: /v3/search/#text-match-metadata
