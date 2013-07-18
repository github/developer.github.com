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
: The search terms. This can be any combination of the existing repository search parameters:

   * [Search In](https://help.github.com/articles/searching-repositories#search-in)
     Qualifies which fields are searched. With this qualifier you can restrict the
     search to just the repository name, description, readme, or
     any combination of these.
   * [Size](https://help.github.com/articles/searching-repositories#size)
      Finds repositories that match a certain size (in kilobytes)
   * [Forks](https://help.github.com/articles/searching-repositories#forks)
      Specifies the number of forks a repository could have
   * [Created and Last Updated](https://help.github.com/articles/searching-repositories#created-and-last-updated) dates
      Filters repositories based on times of creation, or when they were last updated
   * [Users or Repositories](https://help.github.com/articles/searching-repositories#users-organizations-and-repositories)
      Limits searches to a specific user or repository
   * [Languages](https://help.github.com/articles/searching-repositories#languages)
      Searches repositories based on what language they're written in.
   * [Stars](https://help.github.com/articles/searching-repositories#stars)
      Searches repositories based on the number of stars

sort
: _Optional_ Sort field. One of `stars`, `forks`, or `updated`. If not
provided, results are sorted by best match.

order
: _Optional_ Sort order if `sort` param is provided. One of `asc` or `desc`; the default is `desc`.

<h4 id="repository-search-example">Example</h4>

Suppose you want to search for popular Tetris repositories written in Assembly.
Your query might look like this.

```
https://api.github.com/search/repositories?q=tetris+language:assembly&sort=stars&order=desc
```

In this request, we're searching for repositories with the word `tetris` in the
name, the description, or the README. We're limiting the results to only find
repositories where the primary language is Assembly. We're sorting by stars in
descending order, so that the most popular repositories appear first in the
search results.

<%= headers 200 %>
<%= json(:repo_search_v3_results) %>

### Highlighting Repository Searches

You can enable highlighting in your results by specifying the `text-match` media
type in your Accept header. For example, via curl, the above query would look like this:


    curl -H 'Accept: application/vnd.github.text-match+json' \
         https://api.github.com/search/repositories?q=tetris+language:assembly&sort=stars&order=desc


This produces the same JSON payload as above, with an extra key called `text_matches`,
an array of objects. These objects provide information such as the position of your
search terms within the text, as well as the property that it was matched against.

You can highlight the **name** and **description** fields in your results. Here's
an example response:

<%= json(:repo_search_v3_results_highlighting) %>

## Search code

Find file contents via various criteria. (This method returns up to 100 results [per page](/v3/#pagination).)

    GET /search/code

### Parameters

q
: The search terms. This can be any combination of the existing code search parameters:

   * [Search In](https://help.github.com/articles/searching-code#search-in)
     Qualifies which fields are searched. With this qualifier you can restrict the
     search to just the file contents, the file path, or both.
   * [Languages](https://help.github.com/articles/searching-code#language)
      Searches code based on what language it's written in
   * [Forks](https://help.github.com/articles/searching-code#forks)
      Specifies the number of forks a hosting repository could have
   * [Size](https://help.github.com/articles/searching-code#size)
      Finds files that match a certain size (in kilobytes)
   * [Path](https://help.github.com/articles/searching-code#path)
      Specifies the path that the resulting file must be at
   * [Extension](https://help.github.com/articles/searching-code#extension)
      Matches files with a certain extension
   * [Users or Repositories](https://help.github.com/articles/searching-code#users-organizations-and-repositories)
      Limits searches to a specific user or repository

sort
: _Optional_ Sort field. Can only be `indexed`, which indicates how recently
a file has been indexed by the GitHub search infrastructure. If not
provided, results are sorted by best match.

order
: _Optional_ Sort order if `sort` param is provided. One of `asc` or `desc`; the default is `desc`.

<h4 id="code-search-example">Example</h4>

Suppose you want to find recently-updated Ruby gems that are using the `octokit`
library. Your query might look like this:

```
https://api.github.com/search/code?q=octokit+in:file+extension:gemspec+-repo:octokit/octokit.rb&sort=indexed
```

Here, we're searching for the keyword `octokit` within a file's contents. We're
making sure that we're only looking in files that end in _.gemspec_. The `-repo`
notation ensures that we're also excluding [the Octokit.rb repo](https://github.com/octokit/octokit.rb).
We’re sorting by `indexed`, so that the most recently-indexed repositories
appear first in the search results.

<%= headers 200 %>
<%= json(:code_search_v3_results) %>

### Highlighting Code Searches

You can enable highlighting in your results by specifying the `text-match` media
type in your Accept header. For example, via curl, the above query would look like this:


    curl -H 'Accept: application/vnd.github.text-match+json' \
         https://api.github.com/search/code?q=octokit+in:file+extension:gemspec+-repo:octokit/octokit.rb

This produces the same JSON payload as above, with an extra key called `text_matches`,
an array of objects. These objects provide information such as the position of your
search terms within the text, as well as the property that it was matched against.

You can highlight the **file contents** in your results. Here's
an example response:

<%= json(:code_search_v3_results_highlighting) %>

## Search issues

Find issues by state and keyword. (This method returns up to 100 results [per page](/v3/#pagination).)

    GET /search/issues

### Parameters

q
: The search terms. This can be any combination of the existing issue search parameters:

   * [Search In](https://help.github.com/articles/searching-issues#search-in)
     Qualifies which fields are searched. With this qualifier you can restrict the
     search to just the title, body, comments, or any combination of these.
   * [Author](https://help.github.com/articles/searching-issues#author)
     Finds issues created by a certain user
   * [Assignee](https://help.github.com/articles/searching-issues#assignee)
     Finds issues that are assigned to a certain user
   * [Mentions](https://help.github.com/articles/searching-issues#mentions)
     Finds issues that mention a certain user
   * [State](https://help.github.com/articles/searching-issues#state)
     Filter issues based on whether they're open or closed
   * [Labels](https://help.github.com/articles/searching-issues#labels)
     Filters issues based on their labels
   * [Language](https://help.github.com/articles/searching-issues#language)
     Searches for issues within repositories that match a certain language
   * [Created and Last Updated](https://help.github.com/articles/searching-issues#created-and-last-updated) times
      Filters issues based on times of creation, or when they were last updated
   * [Comments](https://help.github.com/articles/searching-issues#comments)
      Filters issues based on the quantity of comments

sort
: _Optional_ Sort field. One of `comments`, `created`, or `updated`. If not
provided, results are sorted by best match.

order
: _Optional_ Sort order if `sort` param is provided. One of `asc` or `desc`; the default is `desc`.

<h4 id="issue-search-example">Example</h4>

Let's say you want to know if there are any Ruby bugs on Windows.

```
https://api.github.com/search/issues?q=win+label:bug+language:ruby+state:open
```

In this query, we're searching for the keyword `win`, within any open issue that's
labelled as `bug`. The search runs across repositories whose primary language is Ruby.

<%= headers 200 %>
<%= json(:issue_search_v3_results) %>

### Highlighting Issue Searches

You can enable highlighting in your results by specifying the `text-match` media
type in your Accept header. For example, via curl, the above query would look like this:


    curl -H 'Accept: application/vnd.github.text-match+json' \
         https://api.github.com/search/issues?q=win+label:bug+language:ruby+state:open


This produces the same JSON payload as above, with an extra key called `text_matches`,
an array of objects. These objects provide information such as the position of your
search terms within the text, as well as the property that it was matched against.

You can highlight the **title**, **body**, and **comment body** in your results. Here's
an example response:

<%= json(:issue_search_v3_results_highlighting) %>

## Search users

Find users via various criteria. (This method returns up to 100 results [per page](/v3/#pagination).)

    GET /search/users

### Parameters

q
: The search terms. This can be any combination of the existing issue search parameters:

   * [Search In](https://help.github.com/articles/searching-users#search-in)
     Qualifies which fields are searched. With this qualifier you can restrict
     the search to just the username, public email, full name, location, or any
     combination of these.
   * [Repository count](https://help.github.com/articles/searching-users#repository-count)
     Filters users based on the number of repositories they have
   * [Location](https://help.github.com/articles/searching-users#location)
     Filter users by the location indicated in their profile
   * [Language](https://help.github.com/articles/searching-users#language)
     Search for users that have repositories that match a certain language
   * [Created](https://help.github.com/articles/searching-users#created)
     Filter users based on when they joined
   * [Followers](https://help.github.com/articles/searching-users#followers)
     Filter users based on the number of followers they have

sort
: _Optional_ Sort field. One of `followers`, `repositories`, or `joined`. If not
provided, results are sorted by best match.

order
: _Optional_ Sort order if `sort` param is provided. One of `asc` or `desc`; the default is `desc`.

<h4 id="user-search-example">Example</h4>

Imagine you're looking for a list of popular users. You might try out this query:

```
https://api.github.com/search/users?q=tom+repos:%3A42+followers:%3A1000
```

Here, we're looking at users with the name Tom. We're only interested in those
with more than 42 repositories, and only if they have over 1,000 followers.

<%= headers 200 %>
<%= json(:user_search_v3_results) %>

### Highlighting Code Searches

You can enable highlighting in your results by specifying the `text-match` media
type in your Accept header. For example, via curl, the above query would look like this:


    curl -H 'Accept: application/vnd.github.text-match+json' \
         https://api.github.com/search/users?q=tom+repos:%3A42+followers:%3A1000


This produces the same JSON payload as above, with an extra key called `text_matches`,
an array of objects. These objects provide information such as the position of your
search terms within the text, as well as the property that it was matched against.

You can highlight the **login**, **email**, and **name** in your results. Here's
an example response:

<%= json(:user_search_v3_results_highlighting) %>
