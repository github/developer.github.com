---
title: Search | GitHub API
---

# Search

* TOC
{:toc}

This is a listing of the Search API features for API v3.

Note: You can only fetch up to 1,000 items with this API.

## Search repositories

Find repositories by keywords. This method returns up to 100 results per page and
pages can be fetched using the `page` parameter.

    GET /search/repositories

### Parameters

query
: The search terms. This can be any one of the existing repository search parameters:
 
   * [Search In](https://help.github.com/articles/searching-repositories#search-in)
   * [Size](https://help.github.com/articles/searching-repositories#size)
   * [Forks](https://help.github.com/articles/searching-repositories#forks)
   * [Created and Last Updated](https://help.github.com/articles/searching-repositories#created-and-last-updated) times  
   * [Users or Repositories](https://help.github.com/articles/searching-repositories#users-organizations-and-repositories)  
   * [Languages](https://help.github.com/articles/searching-repositories#languages)
   * [Stars](https://help.github.com/articles/searching-repositories#stars)

sort
: _Optional_ Sort field. One of `stars`, `forks`, or `updated`. If not
provided, results are sorted by best match.

order
: _Optional_ Sort order if `sort` param is provided. One of `asc` or `desc`.

page
: _Optional_ Page number to fetch; defaults to 1

per_page
: _Optional_ Number of results per page; defaults to 30. The maximum is 100.

<%= headers 200 %>
<%= json(:repo_search_results) %>

## Search code

Find code by 

    GET /search/code

## Search issues

Find issues by state and keyword.

    GET /search/issues

### Parameters

query
: The search terms. This can be any one of the existing issue search parameters:
 
   * [Search In](https://help.github.com/articles/searching-issues#search-in)
   * [Author](https://help.github.com/articles/searching-issues#author)
   * [Assignee](https://help.github.com/articles/searching-issues#assignee)
   * [Mentions](https://help.github.com/articles/searching-issues#mentions)  
   * [State](https://help.github.com/articles/searching-issues#state)  
   * [Labels](https://help.github.com/articles/searching-issues#labels)
   * [Language](https://help.github.com/articles/searching-issues#language)
   * [Created and Last Updated](https://help.github.com/articles/searching-issues#created-and-last-updated) times
   * [Comments](https://help.github.com/articles/searching-issues#comments)  

sort
: _Optional_ Sort field. One of `comments`, `created`, or `updated`. If not
provided, results are sorted by best match.

order
: _Optional_ Sort order if `sort` param is provided. One of `asc` or `desc`.

page
: _Optional_ Page number to fetch; defaults to 1

per_page
: _Optional_ Number of results per page; defaults to 30. The maximum is 100.

<%= headers 200 %>
<%= json(:issue_search_results) %>

## Search users

Find users by keywords.

    GET /search/users

### Parameters

query
: The search terms. This can be any one of the existing issue search parameters:
 
   * [Search In](https://help.github.com/articles/searching-users#search-in)
   * [Repository count](https://help.github.com/articles/searching-users#repository-count)
   * [Location](https://help.github.com/articles/searching-users#location)
   * [Language](https://help.github.com/articles/searching-users#language)
   * [Created](https://help.github.com/articles/searching-users#created)
   * [Followers](https://help.github.com/articles/searching-users#followers)

sort
: _Optional_ Sort field. One of `followers`, `repositories`, or `joined`. If not
provided, results are sorted by best match.

order
: _Optional_ Sort order if `sort` param is provided. One of `asc` or `desc`.

page
: _Optional_ Page number to fetch; defaults to 1

per_page
: _Optional_ Number of results per page; defaults to 30. The maximum is 100.

<%= headers 200 %>
<%= json(:user_search_results) %>

## Email search

This API call is added for compatibility reasons only. There's no guarantee
that full email searches will always be available. The `@` character in the
address must be left unencoded. Searches only against public email addresses
(as configured on the user's GitHub profile).

    GET /legacy/user/email/:email

### Parameters

email
: Email address

<%= headers 200 %>
<%= json(:email_search_results) %>
