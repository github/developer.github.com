---
title: Search | GitHub API
---

# Search

* TOC
{:toc}

### Preview mode

<div class="alert">
  <p>
    The Search API is currently available for developers to preview.
    During the preview period, the API may change without advance notice.
    Please see the <a href="/changes/2013-07-19-preview-the-new-search-api">blog post</a> for full details.
  </p>
  <p>
    To access the API during the preview period, you must provide a custom <a href="/v3/media">media type</a> in the <code>Accept</code> header:
    <pre>application/vnd.github.preview</pre>
  </p>
</div>

If you have any questions or feedback about this new API, please [get in
touch](https://github.com/contact?form[subject]=New+Search+API).

### About the Search API

The Search API is optimized to help you find the specific item you're looking
for (e.g., a specific user, a specific file in a repository, etc.). Think of it
the way you think of performing a search on Google. It's designed to help you
find the one result you're looking for (or maybe the few results you're looking
for). Just like searching on Google, you sometimes want to see a few pages of
search results so that you can find the item that best meets your needs. To
satisfy that need, the GitHub Search API provides **up to 1,000 results for each
search**.

### Rate limit

The Search API has a custom rate limit. For requests using [Basic
Authentication](/v3/#authentication), [OAuth](/v3/#authentication), or [client
ID and secret](/v3/#unauthenticated-rate-limited-requests), you can make up to
20 requests per minute. For unauthenticated requests, the rate limit allows you
to make up to 5 requests per minute.

See the [rate limit documentation](/v3/#rate-limiting) for details on
determining your current rate limit status.

## Search repositories

Find repositories via various criteria. (This method returns up to 100 results [per page](/v3/#pagination).)

    GET /search/repositories

### Parameters

q
: The search terms. This can be any combination of the supported repository search parameters:

   * [Search In](https://help.github.com/articles/searching-repositories#search-in)
     Qualifies which fields are searched. With this qualifier you can restrict the
     search to just the repository name, description, readme, or
     any combination of these.
   * [Size](https://help.github.com/articles/searching-repositories#size)
      Finds repositories that match a certain size (in kilobytes).
   * [Forks](https://help.github.com/articles/searching-repositories#forks)
      Filters repositories based on the number of forks, and/or whether forked repositories should be included in the results at all.
   * [Created and Last Updated](https://help.github.com/articles/searching-repositories#created-and-last-updated)
      Filters repositories based on times of creation, or when they were last updated.
   * [Users or Repositories](https://help.github.com/articles/searching-repositories#users-organizations-and-repositories)
      Limits searches to a specific user or repository.
   * [Languages](https://help.github.com/articles/searching-repositories#languages)
      Searches repositories based on the language they're written in.
   * [Stars](https://help.github.com/articles/searching-repositories#stars)
      Searches repositories based on the number of stars.

sort
: _Optional_ Sort field. One of `stars`, `forks`, or `updated`. If not
provided, results are sorted by best match.

order
: _Optional_ Sort order if `sort` parameter is provided. One of `asc` or `desc`; the default is `desc`.

<h4 id="repository-search-example">Example</h4>

Suppose you want to search for popular Tetris repositories written in Assembly.
Your query might look like this.

    https://api.github.com/search/repositories?q=tetris+language:assembly&sort=stars&order=desc

In this request, we're searching for repositories with the word `tetris` in the
name, the description, or the README. We're limiting the results to only find
repositories where the primary language is Assembly. We're sorting by stars in
descending order, so that the most popular repositories appear first in the
search results.

<%= headers 200 %>
<%= json(:repo_search_v3_results) %>

### Highlighting Repository Search Results

Some API consumers will want to highlight the matching search terms when
displaying search results. The API offers additional metadata to support this
use case. To get this metadata in your search results, specify the `text-match`
media type in your Accept header. For example, via curl, the above query would
look like this:

    curl -H 'Accept: application/vnd.github.preview.text-match+json' \
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

q
: The search terms. This can be any combination of the supported code search parameters:

   * [Search In](https://help.github.com/articles/searching-code#search-in)
     Qualifies which fields are searched. With this qualifier you can restrict the
     search to just the file contents, the file path, or both.
   * [Languages](https://help.github.com/articles/searching-code#language)
      Searches code based on the language it's written in.
   * [Forks](https://help.github.com/articles/searching-code#forks)
      Filters repositories based on the number of forks, and/or whether code from forked repositories should be included in the results at all.
   * [Size](https://help.github.com/articles/searching-code#size)
      Finds files that match a certain size (in bytes).
   * [Path](https://help.github.com/articles/searching-code#path)
      Specifies the path that the resulting file must be at.
   * [Extension](https://help.github.com/articles/searching-code#extension)
      Matches files with a certain extension.
   * [Users or Repositories](https://help.github.com/articles/searching-code#users-organizations-and-repositories)
      Limits searches to a specific user or repository.

sort
: _Optional_ Sort field. Can only be `indexed`, which indicates how recently
a file has been indexed by the GitHub search infrastructure. If not
provided, results are sorted by best match.

order
: _Optional_ Sort order if `sort` parameter is provided. One of `asc` or `desc`; the default is `desc`.

<h4 id="code-search-example">Example</h4>

Suppose you want to find the definition of the `addClass` function inside
[jQuery](https://github.com/jquery/jquery). Your query would look something like
this:

    https://api.github.com/search/code?q=addClass+in:file+language:js+@jquery/jquery

Here, we're searching for the keyword `addClass` within a file's contents. We're
making sure that we're only looking in files where the language is JavaScript.
And we're scoping the search to the `@jquery/jquery` repository.

<%= headers 200 %>
<%= json(:code_search_v3_results) %>

### Highlighting Code Search Results

Some API consumers will want to highlight the matching search terms when
displaying search results. The API offers additional metadata to support this
use case. To get this metadata in your search results, specify the `text-match`
media type in your Accept header. For example, via curl, the above query would
look like this:

    curl -H 'Accept: application/vnd.github.preview.text-match+json' \
      https://api.github.com/search/code?q=addClass+in:file+language:js+@jquery/jquery

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

q
: The search terms. This can be any combination of the supported issue search parameters:

   * [Search In](https://help.github.com/articles/searching-issues#search-in)
     Qualifies which fields are searched. With this qualifier you can restrict the
     search to just the title, body, comments, or any combination of these.
   * [Author](https://help.github.com/articles/searching-issues#author)
     Finds issues created by a certain user.
   * [Assignee](https://help.github.com/articles/searching-issues#assignee)
     Finds issues that are assigned to a certain user.
   * [Mentions](https://help.github.com/articles/searching-issues#mentions)
     Finds issues that mention a certain user.
   * [State](https://help.github.com/articles/searching-issues#state)
     Filter issues based on whether they're open or closed.
   * [Labels](https://help.github.com/articles/searching-issues#labels)
     Filters issues based on their labels.
   * [Language](https://help.github.com/articles/searching-issues#language)
     Searches for issues within repositories that match a certain language.
   * [Created and Last Updated](https://help.github.com/articles/searching-issues#created-and-last-updated)
     Filters issues based on times of creation, or when they were last updated.
   * [Comments](https://help.github.com/articles/searching-issues#comments)
     Filters issues based on the quantity of comments.
   * [Users or Repositories](https://help.github.com/articles/searching-issues#users-organizations-and-repositories)
     Limits searches to a specific user or repository.

sort
: _Optional_ Sort field. One of `comments`, `created`, or `updated`. If not
provided, results are sorted by best match.

order
: _Optional_ Sort order if `sort` parameter is provided. One of `asc` or `desc`; the default is `desc`.

<h4 id="issue-search-example">Example</h4>

Let's say you want to find the oldest unresolved Python bugs on Windows. Your
query might look something like this.

    https://api.github.com/search/issues?q=windows+label:bug+language:python+state:open&sort=created&order=asc

In this query, we're searching for the keyword `win32`, within any open issue
that's labeled as `bug`. The search runs across repositories whose primary
language is Ruby. We’re sorting by creation date in ascending order, so that
the oldest issues appear first in the search results.

<%= headers 200 %>
<%= json(:issue_search_v3_results) %>

### Highlighting Issue Search Results

Some API consumers will want to highlight the matching search terms when
displaying search results. The API offers additional metadata to support this
use case. To get this metadata in your search results, specify the `text-match`
media type in your Accept header. For example, via curl, the above query would
look like this:

    curl -H 'Accept: application/vnd.github.preview.text-match+json' \
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

q
: The search terms. This can be any combination of the supported user search parameters:

   * [Search In](https://help.github.com/articles/searching-users#search-in)
     Qualifies which fields are searched. With this qualifier you can restrict
     the search to just the username, public email, full name, or any
     combination of these.
   * [Repository count](https://help.github.com/articles/searching-users#repository-count)
     Filters users based on the number of repositories they have.
   * [Location](https://help.github.com/articles/searching-users#location)
     Filter users by the location indicated in their profile.
   * [Language](https://help.github.com/articles/searching-users#language)
     Search for users that have repositories that match a certain language.
   * [Created](https://help.github.com/articles/searching-users#created)
     Filter users based on when they joined.
   * [Followers](https://help.github.com/articles/searching-users#followers)
     Filter users based on the number of followers they have.

sort
: _Optional_ Sort field. One of `followers`, `repositories`, or `joined`. If not
provided, results are sorted by best match.

order
: _Optional_ Sort order if `sort` parameter is provided. One of `asc` or `desc`; the default is `desc`.

<h4 id="user-search-example">Example</h4>

Imagine you're looking for a list of popular users. You might try out this query:

    https://api.github.com/search/users?q=tom+repos:%3E42+followers:%3E1000

Here, we're looking at users with the name Tom. We're only interested in those
with more than 42 repositories, and only if they have over 1,000 followers.

<%= headers 200 %>
<%= json(:user_search_v3_results) %>

### Highlighting User Search Results

Some API consumers will want to highlight the matching search terms when
displaying search results. The API offers additional metadata to support this
use case. To get this metadata in your search results, specify the `text-match`
media type in your Accept header. For example, via curl, the above query would
look like this:

    curl -H 'Accept: application/vnd.github.preview.text-match+json' \
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

    application/vnd.github.preview.text-match+json

The results will provide the same JSON payloads as shown above, with an extra
key called `text_matches`. Inside the `text_matches` array, each hash includes
the following attributes:

object_url
: The URL for the resource that contains a string property matching one of the search terms.

object_type
: The name for the type of resource that exists at the given `object_url`.

property
: The name of a property of the resource that exists at `object_url`.
  That property is a string that matches one of the search terms.
  (In the JSON returned from `object_url`, the full content for the `fragment` will be found in the property with this name.)

fragment
: A subset of the value of `property`. This is the text fragment that matches one or more of the search terms.

matches
: An array of one or more search terms that are present in `fragment`. The indices (i.e., "offsets") are relative to the fragment. (They are not relative to the _full_ content of `property`.)

### Example

Using curl, and the [example issue search](#issue-search-example) above, our API
request would look like this:

    curl -H 'Accept: application/vnd.github.preview.text-match+json' \
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
