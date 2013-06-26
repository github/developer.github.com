---
title: Search | GitHub API
---

# Search

* TOC
{:toc}

This is a listing of the Search API features for API v3.

Note: You can fetch up to 1,000 items with this API.

## Search repositories

Find repositories via various criteria. This method returns up to 100 results per page and
pages can be fetched using the `page` parameter.

    GET /search/repositories

### Parameters

q
: The search terms. This can be any one of the existing repository search parameters:
 
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
: _Optional_ Sort order if `sort` param is provided. One of `asc` or `desc`.

page
: _Optional_ Page number to fetch; defaults to `1`.

per_page
: _Optional_ Number of results per page; defaults to `30`. The maximum is `100`.

#### Example

```
https://api.github.com/search/repositories?q=tetris%20language:assembly&sort=stars&order=desc
```

<%= headers 200 %>
<%= json(:repo_search_v3_results) %>

## Search code

Find file contents via various criteria.

    GET /search/code

### Parameters

q
: The search terms. This can be any one of the existing code search parameters:
 
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
: _Optional_ Sort order if `sort` param is provided. One of `asc` or `desc`.

page
: _Optional_ Page number to fetch; defaults to `1`.

per_page
: _Optional_ Number of results per page; defaults to `30`. The maximum is `100`.

#### Example

```
https://api.github.com/search/code?q=octokit%20extension:gemspec%20-repo:octokit/octokit.rb
```

<%= headers 200 %>
<%= json(:code_search_v3_results) %>

## Search issues

Find issues by state and keyword.

    GET /search/issues

### Parameters

q
: The search terms. This can be any one of the existing issue search parameters:
 
   * [Search In](https://help.github.com/articles/searching-issues#search-in)  
     Qualifies which fields are searched. With this qualifier you can restrict the 
     search to just the title, body, comments, or any combination of these.
   * [Author](https://help.github.com/articles/searching-issues#author)  
     Finds issues created by a certain user or team
   * [Assignee](https://help.github.com/articles/searching-issues#assignee)  
     Finds issues that are assigned to a certain user or team
   * [Mentions](https://help.github.com/articles/searching-issues#mentions)  
     Finds issues that mention a certain user or team
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
: _Optional_ Sort order if `sort` param is provided. One of `asc` or `desc`.

page
: _Optional_ Page number to fetch; defaults to `1`.

per_page
: _Optional_ Number of results per page; defaults to `30`. The maximum is `100`.

#### Example

```
https://api.github.com/search/issues?q=win%20label:bug%20language:ruby%20state:open
```

<%= headers 200 %>
<%= json(:issue_search_v3_results) %>

## Search users

Find users via various criteria.

    GET /search/users

### Parameters

q
: The search terms. This can be any one of the existing issue search parameters:
 
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
: _Optional_ Sort order if `sort` param is provided. One of `asc` or `desc`.

page
: _Optional_ Page number to fetch; defaults to `1`.

per_page
: _Optional_ Number of results per page; defaults to `30`. The maximum is `100`.

#### Example

```
https://api.github.com/search/users?q=location:%22San%20Francisco%22%20repos:%3E42%20followers:%3E1000
```

<%= headers 200 %>
<%= json(:user_search_v3_results) %>
