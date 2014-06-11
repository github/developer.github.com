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
is a computed value representing the relevance of a item relative to the other
items in the result set. Multiple factors are combined to boost the most
relevant item to the top of the result list.

### Rate limit

The Search API has a custom rate limit. For requests using [Basic
Authentication](/v3/#authentication), [OAuth](/v3/#authentication), or [client
ID and secret](/v3/#unauthenticated-rate-limited-requests), you can make up to
20 requests per minute. For unauthenticated requests, the rate limit allows you
to make up to 5 requests per minute.

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

The `q` search term can also contain any combination of the supported repository search qualifiers:

* [`in`](https://help.github.com/articles/searching-repositories#search-in)
 Qualifies which fields are searched. With this qualifier you can restrict the
 search to just the repository name, description, readme, or
 any combination of these.
* [`size`](https://help.github.com/articles/searching-repositories#size)
  Finds repositories that match a certain size (in kilobytes).
* [`forks`](https://help.github.com/articles/searching-repositories#forks)
  Filters repositories based on the number of forks, and/or whether forked repositories should be included in the results at all.
* [`created` or `pushed`](https://help.github.com/articles/searching-repositories#created-and-last-updated)
  Filters repositories based on date of creation, or when they were last updated.
* [`user` or `repo`](https://help.github.com/articles/searching-repositories#users-organizations-and-repositories)
  Limits searches to a specific user or repository.
* [`language`](https://help.github.com/articles/searching-repositories#languages)
  Searches repositories based on the language they're written in.
* [`stars`](https://help.github.com/articles/searching-repositories#stars)
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

<%= headers 200, {'X-RateLimit-Limit' => 20, 'X-RateLimit-Remaining' => 19} %>
<%= json(:repo_search_v3_results) %>

### Highlighting Repository Search Results

Some API consumers will want to highlight the matching search terms when
displaying search results. The API offers additional metadata to support this
use case. To get this metadata in your search results, specify the `text-match`
media type in your Accept header. For example, via curl, the above query would
look like this:

    curl -H 'Accept: application/vnd.github.v3.text-match+json' \
      https://api.github.com/search/repositories?q=tetris+language:assembly&sort=stars&order=desc

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

### Parameters

Name | Type | Description
-----|------|--------------
`q`|`string`| The search terms.
`sort`|`string`| The sort field. Can only be `indexed`, which indicates how recently a file has been indexed by the GitHub search infrastructure. Default: results are sorted by best match.
`order`|`string`| The sort order if `sort` parameter is provided. One of `asc` or `desc`. Default: `desc`

The `q` search term can also contain any combination of the supported code search qualifiers:

* [`in`](https://help.github.com/articles/searching-code#search-in)
 Qualifies which fields are searched. With this qualifier you can restrict the
 search to just the file contents, the file path, or both.
* [`language`](https://help.github.com/articles/searching-code#language)
  Searches code based on the language it's written in.
* [`fork`](https://help.github.com/articles/searching-code#forks)
  Specifies that code from forked repositories should be searched. Repository
  forks will not be searchable unless the fork has more stars than the parent
  repository.
* [`size`](https://help.github.com/articles/searching-code#size)
  Finds files that match a certain size (in bytes).
* [`path`](https://help.github.com/articles/searching-code#path)
  Specifies the path that the resulting file must be at.
* [`extension`](https://help.github.com/articles/searching-code#extension)
  Matches files with a certain extension.
* [`user` or `repo`](https://help.github.com/articles/searching-code#users-organizations-and-repositories)
    Limits searches to a specific user or repository.

<h4 id="code-search-example">Example</h4>

Suppose you want to find the definition of the `addClass` function inside
[jQuery](https://github.com/jquery/jquery). Your query would look something like
this:

    https://api.github.com/search/code?q=addClass+in:file+language:js+repo:jquery/jquery

Here, we're searching for the keyword `addClass` within a file's contents. We're
making sure that we're only looking in files where the language is JavaScript.
And we're scoping the search to the `repo:jquery/jquery` repository.

<%= headers 200, {'X-RateLimit-Limit' => 20, 'X-RateLimit-Remaining' => 19} %>
<%= json(:code_search_v3_results) %>

### Highlighting Code Search Results

Some API consumers will want to highlight the matching search terms when
displaying search results. The API offers additional metadata to support this
use case. To get this metadata in your search results, specify the `text-match`
media type in your Accept header. For example, via curl, the above query would
look like this:

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

The `q` search term can also contain any combination of the supported issue search qualifiers:

 * [`type`](https://help.github.com/articles/searching-issues#type)
   With this qualifier you can restrict the search to issues or pull request only.
 * [`in`](https://help.github.com/articles/searching-issues#search-in)
   Qualifies which fields are searched. With this qualifier you can restrict the
   search to just the title, body, comments, or any combination of these.
 * [`author`](https://help.github.com/articles/searching-issues#author)
   Finds issues created by a certain user.
 * [`assignee`](https://help.github.com/articles/searching-issues#assignee)
   Finds issues that are assigned to a certain user.
 * [`mentions`](https://help.github.com/articles/searching-issues#mentions)
   Finds issues that mention a certain user.
 * [`commenter`](https://help.github.com/articles/searching-issues#commenter)
   Finds issues that a certain user commented on.
 * [`involves`](https://help.github.com/articles/searching-issues#involves)
   Finds issues that were either created by a certain user, assigned to that
     user, mention that user, or were commented on by that user.
 * [`state`](https://help.github.com/articles/searching-issues#state)
   Filter issues based on whether they're open or closed.
 * [`labels`](https://help.github.com/articles/searching-issues#labels)
   Filters issues based on their labels.
 * [`no`](https://help.github.com/articles/searching-issues#no)
   Filters items missing certain metadata, such as `label`, `milestone`, or `assignee`
 * [`language`](https://help.github.com/articles/searching-issues#language)
   Searches for issues within repositories that match a certain language.
 * [`is`](https://help.github.com/articles/searching-issues#is)
   Searches for items within repositories that match a certain state, such as `open`, `closed`, or `merged`
 * [`created` or `updated`](https://help.github.com/articles/searching-issues#created-and-last-updated)
   Filters issues based on date of creation, or when they were last updated.
 * [`merged`](https://help.github.com/articles/searching-issues#merged)
   Filters pull requests based on the date when they were merged.
 * [`closed`](https://help.github.com/articles/searching-issues#closed)
   Filters issues based on the date when they were closed.
 * [`comments`](https://help.github.com/articles/searching-issues#comments)
   Filters issues based on the quantity of comments.
 * [`user` or `repo`](https://help.github.com/articles/searching-issues#users-organizations-and-repositories)
   Limits searches to a specific user or repository.


<h4 id="issue-search-example">Example</h4>

Let's say you want to find the oldest unresolved Python bugs on Windows. Your
query might look something like this.

    https://api.github.com/search/issues?q=windows+label:bug+language:python+state:open&sort=created&order=asc

In this query, we're searching for the keyword `windows`, within any open issue
that's labeled as `bug`. The search runs across repositories whose primary
language is Python. We’re sorting by creation date in ascending order, so that
the oldest issues appear first in the search results.

<%= headers 200, {'X-RateLimit-Limit' => 20, 'X-RateLimit-Remaining' => 19} %>
<%= json(:issue_search_v3_results) %>

### Highlighting Issue Search Results

Some API consumers will want to highlight the matching search terms when
displaying search results. The API offers additional metadata to support this
use case. To get this metadata in your search results, specify the `text-match`
media type in your Accept header. For example, via curl, the above query would
look like this:

    curl -H 'Accept: application/vnd.github.v3.text-match+json' \
      https://api.github.com/search/issues?q=windows+label:bug+language:python+state:open&sort=created&order=asc

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

The `q` search term can also contain any combination of the supported user search qualifiers:

 * [`type`](https://help.github.com/articles/searching-users#type)
   With this qualifier you can restrict the search to just personal accounts or
   just organization accounts.
 * [`in`](https://help.github.com/articles/searching-users#search-in)
   Qualifies which fields are searched. With this qualifier you can restrict
   the search to just the username, public email, full name, or any
   combination of these.
 * [`repos`](https://help.github.com/articles/searching-users#repository-count)
   Filters users based on the number of repositories they have.
 * [`location`](https://help.github.com/articles/searching-users#location)
   Filter users by the location indicated in their profile.
 * [`language`](https://help.github.com/articles/searching-users#language)
   Search for users that have repositories that match a certain language.
 * [`created`](https://help.github.com/articles/searching-users#created)
   Filter users based on when they joined.
 * [`followers`](https://help.github.com/articles/searching-users#followers)
   Filter users based on the number of followers they have.

<h4 id="user-search-example">Example</h4>

Imagine you're looking for a list of popular users. You might try out this query:

    https://api.github.com/search/users?q=tom+repos:%3E42+followers:%3E1000

Here, we're looking at users with the name Tom. We're only interested in those
with more than 42 repositories, and only if they have over 1,000 followers.

<%= headers 200, {'X-RateLimit-Limit' => 20, 'X-RateLimit-Remaining' => 19} %>
<%= json(:user_search_v3_results) %>

### Highlighting User Search Results

Some API consumers will want to highlight the matching search terms when
displaying search results. The API offers additional metadata to support this
use case. To get this metadata in your search results, specify the `text-match`
media type in your Accept header. For example, via curl, the above query would
look like this:

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
key called `text_matches`. Inside the `text_matches` array, each hash includes
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

    curl -H 'Accept: application/vnd.github.v3.text-match+json' \
      https://api.github.com/search/issues?q=windows+label:bug+language:python+state:open&sort=created&order=asc

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
