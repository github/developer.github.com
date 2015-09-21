---
title: Search | GitHub API
---

# Search

* TOC
{:toc}

### About the Search API

The Search API is optimized to help you find the specific item you're looking
for (e.g., a specific user, a specific file in a repository, etc.). Think of it
the way you think of performing a search on Google. It's designed to help you
find the one result you're looking for (or maybe the few results you're looking
for). Just like searching on Google, you sometimes want to see a few pages of
search results so that you can find the item that best meets your needs. To
satisfy that need, the GitHub Search API provides **up to 1,000 results for each
search**.

### Ranking search results

Unless another sort option is provided as a query parameter, results are sorted
by best match, as indicated by the `score` field for each item returned. This
is a computed value representing the relevance of an item relative to the other
items in the result set. Multiple factors are combined to boost the most
relevant item to the top of the result list.

### Rate limit

The Search API has a custom rate limit. For requests using [Basic
Authentication](/v3/#authentication), [OAuth](/v3/#authentication), or [client
ID and secret](/v3/#increasing-the-unauthenticated-rate-limit-for-oauth-applications), you can make up to
30 requests per minute. For unauthenticated requests, the rate limit allows you
to make up to 10 requests per minute.

See the [rate limit documentation](/v3/#rate-limiting) for details on
determining your current rate limit status.

### Timeouts and incomplete results

To keep the Search API fast for everyone, we limit how long any individual query
can run. For queries that [exceed the time limit](/changes/2014-04-07-understanding-search-results-and-potential-timeouts/),
the API returns the matches that were already found prior to the timeout, and
the response has the `incomplete_results` property set to `true`.

Reaching a timeout does not necessarily mean that search results are incomplete.
More results might have been found, but also might not.

## Search repositories

Find repositories via various criteria. This method returns up to 100 results [per page](/v3/#pagination).

    GET /search/repositories

### Parameters

Name | Type | Description
-----|------|--------------
`q`|`string`| The search keywords, as well as any qualifiers.
`sort`|`string`| The sort field. One of `stars`, `forks`, or `updated`. Default: results are sorted by best match.
`order`|`string`| The sort order if `sort` parameter is provided. One of `asc` or `desc`. Default: `desc`

The `q` search term can also contain any combination of the supported repository search qualifiers as described by the in-browser [repository search documentation](https://help.github.com/articles/searching-repositories/) and [search syntax documentation](https://help.github.com/articles/search-syntax/):

* [`in`](https://help.github.com/articles/searching-repositories#scope-the-search-fields)
 Qualifies which fields are searched. With this qualifier you can restrict the
 search to just the repository name, description, readme, or
 any combination of these.
* [`size`](https://help.github.com/articles/searching-repositories#search-based-on-the-size-of-a-repository)
  Finds repositories that match a certain size (in kilobytes).
* [`forks`](https://help.github.com/articles/searching-repositories#search-based-on-the-number-of-forks-the-parent-repository-has)
  Filters repositories based on the number of forks.
* [`fork`](https://help.github.com/articles/searching-repositories#search-based-on-the-number-of-forks-the-parent-repository-has) Filters whether forked repositories should be included (`true`) or only forked repositories should be returned (`only`).
* [`created` or `pushed`](https://help.github.com/articles/searching-repositories#search-based-on-when-a-repository-was-created-or-last-updated)
  Filters repositories based on date of creation, or when they were last updated.
* [`user` or `repo`](https://help.github.com/articles/searching-repositories#search-within-a-users-or-organizations-repositories)
  Limits searches to a specific user or repository.
* [`language`](https://help.github.com/articles/searching-repositories#search-based-on-the-main-language-of-a-repository)
  Searches repositories based on the language they're written in.
* [`stars`](https://help.github.com/articles/searching-repositories#search-based-on-the-number-of-stars-a-repository-has)
  Searches repositories based on the number of stars.

<h4 id="repository-search-example">Example</h4>

Suppose you want to search for popular Tetris repositories written in Assembly.
Your query might look like this.

    https://api.github.com/search/repositories?q=tetris+language:assembly&sort=stars&order=desc

In this request, we're searching for repositories with the word `tetris` in the
name, the description, or the README. We're limiting the results to only find
repositories where the primary language is Assembly. We're sorting by stars in
descending order, so that the most popular repositories appear first in the
search results.

<%= headers 200, {:pagination => default_pagination_rels, 'X-RateLimit-Limit' => 20, 'X-RateLimit-Remaining' => 19} %>
<%= json(:repo_search_v3_results) %>

### Highlighting Repository Search Results

Some API consumers will want to highlight the matching search terms when
displaying search results. The API offers additional metadata to support this
use case. To get this metadata in your search results, specify the `text-match`
media type in your Accept header. For example, via curl, the above query would
look like this:

{:.terminal}
    curl -H 'Accept: application/vnd.github.v3.text-match+json' \
      'https://api.github.com/search/repositories?q=tetris+language:assembly&sort=stars&order=desc'

This produces the same JSON payload as above, with an extra key called
`text_matches`, an array of objects. These objects provide information such as
the position of your search terms within the text, as well as the property that
included the search term.

When searching for repositories, you can get text match metadata for the
**name** and **description** fields. (See the section on [text match metadata
](#text-match-metadata) for full details.)

Here's an example response:

<%= json(:repo_search_v3_results_highlighting) %>

## Search code

Find file contents via various criteria. (This method returns up to 100 results [per page](/v3/#pagination).)

    GET /search/code

### Considerations for code search

Due to the complexity of searching code, there are a few restrictions on how searches are performed:

<ul>
<li>Only the <em>default branch</em> is considered. In most cases, this will be the <code>master</code> branch.</li>
<li>Only files smaller than 384 KB are searchable.</li>
<li class='not-enterprise'> You must always include at least one search term when searching source code. For example, searching for <a href="https://github.com/search?utf8=✓&q=language%3Ago&type=Code"><code>language:go</code></a> is not valid, while <a href="https://github.com/search?utf8=✓&q=amazing+language%3Ago&type=Code"><code>amazing language:go</code></a> is.</li>
</ul>

### Parameters

Name | Type | Description
-----|------|--------------
`q`|`string`| The search terms.
`sort`|`string`| The sort field. Can only be `indexed`, which indicates how recently a file has been indexed by the GitHub search infrastructure. Default: results are sorted by best match.
`order`|`string`| The sort order if `sort` parameter is provided. One of `asc` or `desc`. Default: `desc`

The `q` search term can also contain any combination of the supported code search qualifiers as described by the in-browser [code search documentation](https://help.github.com/articles/searching-code/) and [search syntax documentation](https://help.github.com/articles/search-syntax/):

* [`in`](https://help.github.com/articles/searching-code#scope-the-search-fields)
 Qualifies which fields are searched. With this qualifier you can restrict the
 search to the file contents (`file`), the file path (`path`), or both.
* [`language`](https://help.github.com/articles/searching-code#search-by-language)
  Searches code based on the language it's written in.
* [`fork`](https://help.github.com/articles/searching-code#search-by-the-number-of-forks-the-parent-repository-has)
  Specifies that code from forked repositories should be searched (`true`). Repository
  forks will not be searchable unless the fork has more stars than the parent
  repository.
* [`size`](https://help.github.com/articles/searching-code#search-by-the-size-of-the-parent-repository)
  Finds files that match a certain size (in bytes).
* [`path`](https://help.github.com/articles/searching-code#search-by-the-location-of-a-file-within-the-repository)
  Specifies the path prefix that the resulting file must be under.
* [`filename`](https://help.github.com/articles/searching-code#search-by-filename)
  Matches files by a substring of the filename.
* [`extension`](https://help.github.com/articles/searching-code#search-by-the-file-extension)
  Matches files with a certain extension after a dot.
* [`user` or `repo`](https://help.github.com/articles/searching-code#search-within-a-users-or-organizations-repositories)
    Limits searches to a specific user or repository.

<h4 id="code-search-example">Example</h4>

Suppose you want to find the definition of the `addClass` function inside
[jQuery](https://github.com/jquery/jquery). Your query would look something like
this:

    https://api.github.com/search/code?q=addClass+in:file+language:js+repo:jquery/jquery

Here, we're searching for the keyword `addClass` within a file's contents. We're
making sure that we're only looking in files where the language is JavaScript.
And we're scoping the search to the `repo:jquery/jquery` repository.

<%= headers 200, {:pagination => default_pagination_rels, 'X-RateLimit-Limit' => 20, 'X-RateLimit-Remaining' => 19} %>
<%= json(:code_search_v3_results) %>

### Highlighting Code Search Results

Some API consumers will want to highlight the matching search terms when
displaying search results. The API offers additional metadata to support this
use case. To get this metadata in your search results, specify the `text-match`
media type in your Accept header. For example, via curl, the above query would
look like this:

{:.terminal}
    curl -H 'Accept: application/vnd.github.v3.text-match+json' \
      https://api.github.com/search/code?q=addClass+in:file+language:js+repo:jquery/jquery

This produces the same JSON payload as above, with an extra key called
`text_matches`, an array of objects. These objects provide information such as
the position of your search terms within the text, as well as the property that
included the search term.

When searching for code, you can get text match metadata for the file
**content** and file **path** fields. (See the section on
[text match metadata](#text-match-metadata) for full details.)

Here's an example response:

<%= json(:code_search_v3_results_highlighting) %>

## Search issues

Find issues by state and keyword. (This method returns up to 100 results [per page](/v3/#pagination).)

    GET /search/issues

### Parameters

Name | Type | Description
-----|------|--------------
`q`|`string`| The search terms.
`sort`|`string`| The sort field. Can be `comments`, `created`, or `updated`. Default: results are sorted by best match.
`order`|`string`| The sort order if `sort` parameter is provided. One of `asc` or `desc`. Default: `desc`

The `q` search term can also contain any combination of the supported issue search qualifiers as described by the in-browser [issue search documentation](https://help.github.com/articles/searching-issues/) and [search syntax documentation](https://help.github.com/articles/search-syntax/):

 * [`type`](https://help.github.com/articles/searching-issues#search-issues-or-pull-requests)
   With this qualifier you can restrict the search to issues (`issue`) or pull request (`pr`) only.
 * [`in`](https://help.github.com/articles/searching-issues#scope-the-search-fields)
   Qualifies which fields are searched. With this qualifier you can restrict the
   search to just the title (`title`), body (`body`), comments (`comment`), or any combination of these.
 * [`author`](https://help.github.com/articles/searching-issues#search-by-the-author-of-an-issue-or-pull-request)
   Finds issues or pull requests created by a certain user.
 * [`assignee`](https://help.github.com/articles/searching-issues#search-by-the-assignee-of-an-issue-or-pull-request)
   Finds issues or pull requests that are assigned to a certain user.
 * [`mentions`](https://help.github.com/articles/searching-issues#search-by-a-mentioned-user-within-an-issue-or-pull-request)
   Finds issues or pull requests that mention a certain user.
 * [`commenter`](https://help.github.com/articles/searching-issues#search-by-a-commenter-within-an-issue-or-pull-request)
   Finds issues or pull requests that a certain user commented on.
 * [`involves`](https://help.github.com/articles/searching-issues#search-by-a-user-thats-involved-within-an-issue-or-pull-request)
   Finds issues or pull requests that were either created by a certain user, assigned to that
     user, mention that user, or were commented on by that user.
 * [`team`](https://help.github.com/articles/searching-issues/#search-by-a-team-thats-mentioned-within-an-issue-or-pull-request)
   For organizations you're a member of, finds issues or pull requests that @mention a team within the organization.
 * [`state`](https://help.github.com/articles/searching-issues#search-based-on-whether-an-issue-or-pull-request-is-open)
   Filter issues or pull requests based on whether they're open or closed.
 * [`labels`](https://help.github.com/articles/searching-issues#search-by-the-labels-on-an-issue)
   Filters issues or pull requests based on their labels.
 * [`no`](https://help.github.com/articles/searching-issues#search-by-missing-metadata-on-an-issue-or-pull-request)
   Filters items missing certain metadata, such as `label`, `milestone`, or `assignee`
 * [`language`](https://help.github.com/articles/searching-issues#search-by-the-main-language-of-a-repository)
   Searches for issues or pull requests within repositories that match a certain language.
 * [`is`](https://help.github.com/articles/searching-issues#search-based-on-the-state-of-an-issue-or-pull-request)
   Searches for items within repositories that match a certain state, such as `open`, `closed`, or `merged`
 * [`created` or `updated`](https://help.github.com/articles/searching-issues#search-based-on-when-an-issue-or-pull-request-was-created-or-last-updated)
   Filters issues or pull requests based on date of creation, or when they were last updated.
 * [`merged`](https://help.github.com/articles/searching-issues#search-based-on-when-a-pull-request-was-merged)
   Filters pull requests based on the date when they were merged.
 * [`status`](https://help.github.com/articles/searching-issues#search-based-on-commit-status)
   Filters pull requests based on the commit status.
 * [`head` or `base`](https://help.github.com/articles/searching-issues#search-based-on-branch-names)
   Filters pull requests based on the branch that they came from or that they are modifying.
 * [`closed`](https://help.github.com/articles/searching-issues#search-based-on-when-an-issue-or-pull-request-was-closed)
   Filters issues or pull requests based on the date when they were closed.
 * [`comments`](https://help.github.com/articles/searching-issues#search-by-the-number-of-comments-an-issue-or-pull-request-has)
   Filters issues or pull requests based on the quantity of comments.
 * [`user` or `repo`](https://help.github.com/articles/searching-issues#search-within-a-users-or-organizations-repositories)
   Limits searches to a specific user or repository.


If you know the specific SHA hash of a commit, you can use also [use it to search for pull requests](https://help.github.com/articles/searching-issues#search-by-the-commit-shas-within-a-pull-request) that contain that SHA. Note that the SHA syntax must be at least seven characters.

<h4 id="issue-search-example">Example</h4>

Let's say you want to find the oldest unresolved Python bugs on Windows. Your
query might look something like this.

    https://api.github.com/search/issues?q=windows+label:bug+language:python+state:open&sort=created&order=asc

In this query, we're searching for the keyword `windows`, within any open issue
that's labeled as `bug`. The search runs across repositories whose primary
language is Python. We’re sorting by creation date in ascending order, so that
the oldest issues appear first in the search results.

<%= headers 200, {:pagination => default_pagination_rels, 'X-RateLimit-Limit' => 20, 'X-RateLimit-Remaining' => 19} %>
<%= json(:issue_search_v3_results) %>

### Highlighting Issue Search Results

Some API consumers will want to highlight the matching search terms when
displaying search results. The API offers additional metadata to support this
use case. To get this metadata in your search results, specify the `text-match`
media type in your Accept header. For example, via curl, the above query would
look like this:

{:.terminal}
    curl -H 'Accept: application/vnd.github.v3.text-match+json' \
      'https://api.github.com/search/issues?q=windows+label:bug+language:python+state:open&sort=created&order=asc'

This produces the same JSON payload as above, with an extra key called
`text_matches`, an array of objects. These objects provide information such as
the position of your search terms within the text, as well as the property that
included the search term.

When searching for issues, you can get text match metadata for the issue
**title**, issue **body**, and issue **comment body** fields. (See the section
on [text match metadata ](#text-match-metadata) for full details.)

Here's an example response:

<%= json(:issue_search_v3_results_highlighting) %>

## Search users

Find users via various criteria. (This method returns up to 100 results [per page](/v3/#pagination).)

    GET /search/users

### Parameters

Name | Type | Description
-----|------|--------------
`q`|`string`| The search terms.
`sort`|`string`| The sort field. Can be `followers`, `repositories`, or `joined`.  Default: results are sorted by best match.
`order`|`string`| The sort order if `sort` parameter is provided. One of `asc` or `desc`. Default: `desc`

The `q` search term can also contain any combination of the supported user search qualifiers as described by the in-browser [user search documentation](https://help.github.com/articles/searching-users/) and [search syntax documentation](https://help.github.com/articles/search-syntax/):

 * [`type`](https://help.github.com/articles/searching-users#search-for-users-or-organizations)
   With this qualifier you can restrict the search to just personal accounts (`user`) or
   just organization accounts (`org`).
 * [`in`](https://help.github.com/articles/searching-users#scope-the-search-fields)
   Qualifies which fields are searched. With this qualifier you can restrict
   the search to just the username (`login`), public email (`email`), full name (`fullname`), or any
   combination of these.
 * [`repos`](https://help.github.com/articles/searching-users#search-based-on-the-number-of-repositories-a-user-has)
   Filters users based on the number of repositories they have.
 * [`location`](https://help.github.com/articles/searching-users#search-based-on-the-location-where-a-user-resides)
   Filter users by the location indicated in their profile.
 * [`language`](https://help.github.com/articles/searching-users#search-based-on-the-languages-of-a-users-repositories)
   Search for users that have repositories that match a certain language.
 * [`created`](https://help.github.com/articles/searching-users#search-based-on-when-a-user-joined-github)
   Filter users based on when they joined.
 * [`followers`](https://help.github.com/articles/searching-users#search-based-on-the-number-of-followers-a-user-has)
   Filter users based on the number of followers they have.

<h4 id="user-search-example">Example</h4>

Imagine you're looking for a list of popular users. You might try out this query:

    https://api.github.com/search/users?q=tom+repos:%3E42+followers:%3E1000

Here, we're looking at users with the name Tom. We're only interested in those
with more than 42 repositories, and only if they have over 1,000 followers.

<%= headers 200, {:pagination => default_pagination_rels, 'X-RateLimit-Limit' => 20, 'X-RateLimit-Remaining' => 19} %>
<%= json(:user_search_v3_results) %>

### Highlighting User Search Results

Some API consumers will want to highlight the matching search terms when
displaying search results. The API offers additional metadata to support this
use case. To get this metadata in your search results, specify the `text-match`
media type in your Accept header. For example, via curl, the above query would
look like this:

{:.terminal}
    curl -H 'Accept: application/vnd.github.v3.text-match+json' \
      https://api.github.com/search/users?q=tom+repos:%3E42+followers:%3E1000

This produces the same JSON payload as above, with an extra key called
`text_matches`, an array of objects. These objects provide information such as
the position of your search terms within the text, as well as the property that
included the search term.

When searching for users, you can get text match metadata for the issue
**login**, **email**, and **name** fields. (See the section on [text match
metadata](#text-match-metadata) for full details.)

<%= json(:user_search_v3_results_highlighting) %>

## Text match metadata

On github.com, we enjoy the context provided by code snippets and highlights in
search results.

[![code-snippet-highlighting](https://f.cloud.github.com/assets/865/819651/959a4826-efb5-11e2-8af8-46c4a3857cdf.png)](https://f.cloud.github.com/assets/865/819651/959a4826-efb5-11e2-8af8-46c4a3857cdf.png)

API consumers have access to that information as well. Requests can opt to
receive those text fragments in the response, and every fragment is accompanied
by numeric offsets identifying the exact location of each matching search term.

To get this metadata in your search results, specify the `text-match` media type
in your Accept header.

    application/vnd.github.v3.text-match+json

The results will provide the same JSON payloads as shown above, with an extra
key called `text_matches`. Inside the `text_matches` array, each object includes
the following attributes:


Name | Description
-----|-----------|
`object_url` | The URL for the resource that contains a string property matching one of the search terms.
`object_type` | The name for the type of resource that exists at the given `object_url`.
`property` | The name of a property of the resource that exists at `object_url`. That property is a string that matches one of the search terms. (In the JSON returned from `object_url`, the full content for the `fragment` will be found in the property with this name.)
`fragment` | A subset of the value of `property`. This is the text fragment that matches one or more of the search terms.
`matches` | An array of one or more search terms that are present in `fragment`. The indices (i.e., "offsets") are relative to the fragment. (They are not relative to the _full_ content of `property`.)

### Example

Using curl, and the [example issue search](#issue-search-example) above, our API
request would look like this:

{:.terminal}
    curl -H 'Accept: application/vnd.github.v3.text-match+json' \
      'https://api.github.com/search/issues?q=windows+label:bug+language:python+state:open&sort=created&order=asc'

The response will include a `text_matches` array for each search result. In the
JSON below, we have two objects in the `text_matches` array.

The first text match occurred in the `body` property of the issue. We see a
fragment of text from the issue body. The search term (`windows`) appears twice
within that fragment, and we have the indices for each occurrence.

The second text match occurred in the `body` property of one of the issue's
comments. We have the URL for the issue comment. And of course, we see a
fragment of text from the comment body. The search term (`windows`) appears once
within that fragment.

<%= json(:issue_search_v3_results_highlighting) %>
