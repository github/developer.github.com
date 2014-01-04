---
title: Traversing with Pagination | GitHub API
---

# Traversing with Pagination

* TOC
{:toc}

The GitHub API provides a vast wealth of information for developers to consume.
Most of the time, you might even find that you're asking for _too much_ information,
and in order to keep our servers happy, the API will automatically [paginate the requested items][pagination].

In this guide, we'll make some calls to the GitHub Search API, and iterate over
the results using pagination.

## Basics of Pagination

To start with, it's important to know a few facts about receiving paginated items:

1. Different API calls respond with different defaults. For example, a call to
[list GitHub's public repositories](http://developer.github.com/v3/repos/#list-all-public-repositories)
provides paginated items in sets of 30, whereas a call to the GitHub Search API
provides items in sets of 100
2. You can specify how many items to receive (up to a maximum of 100); but,
3. For technical reasons, not every endpoint lets you specific the maximum set
(such as [events](http://developer.github.com/v3/activity/events/))

Information about pagination is provided in [the Link header](http://tools.ietf.org/html/rfc5988)
of an API call. For example, let's make a curl request to the search API, to find
out how many times Mozilla projects use the phrase `addClass`:

    curl -I "https://api.github.com/search/code?q=addClass+user:mozilla"

The `-I` parameter indicates that we only care about the headers, not the actual
content. In examining the result, you'll notice some information in the Link header
that looks like this:

    Link: <https://api.github.com/search/code?q=addClass+user%3Amozilla&page=2>; rel="next",
      <https://api.github.com/search/code?q=addClass+user%3Amozilla&page=34>; rel="last"

Let's break that down. `rel="next"` says that the next page is `page=2`. This makes
sense, since by default, all queries with pagination start at `1.` `rel="last"`
provides some more information, stating that the last page of results is on `34`.
Thus, we have 33 more pages of information about `addClass` that we can consume.
Nice!

### Navigating through the pages

Now that you know how many pages there are to receive, you can start navigating
through the pages to consume the results. You do this by passing in a `page`
parameter. By default, `page` always starts at `1`. Let's jump ahead to page 14
and see what happens:

    curl -I "https://api.github.com/search/code?q=addClass+user:mozilla&page=14"

Here's the link header once more:

    Link: <<https://api.github.com/search/code?q=addClass+user%3Amozilla&page=15>; rel="next",
      <https://api.github.com/search/code?q=addClass+user%3Amozilla&page=34>; rel="last",
      <https://api.github.com/search/code?q=addClass+user%3Amozilla&page=1>; rel="first",
      <https://api.github.com/search/code?q=addClass+user%3Amozilla&page=13>; rel="prev"

As expected, `rel="next"` is at 15, and `rel="last"` is still 34. But now we've
got some more information: `rel="first"` indicates the URL for the _first_ page,
and more importantly, `rel="prev"` lets you know the page number of the previous
page. Using this information, you could construct some UI that lets users jump
between the first, previous, next, or last list of results in an API call.

### Changing the number of items received

By passing the `per_page` parameter, you can specify how many items you want
each page to return, up to 100 items. Let's try asking for 50 items about `addClass`:

    curl -I "https://api.github.com/search/code?q=addClass+user:mozilla&per_page=50"

Notice what it does to the header response:

    Link: <https://api.github.com/search/code?q=addClass+user%3Amozilla&per_page=50&page=2>; rel="next",
      <https://api.github.com/search/code?q=addClass+user%3Amozilla&per_page=50&page=20>; rel="last"

As you might have guessed, the `rel="last"` information says that the last page
is now 20. This is because we are asking for more information per page about
our results.

## Consuming the information

You don't want to be making low-level curl calls just to be able to work with
pagination, so let's write a little Ruby script that does everything we've
just described above.

As always, first we'll require [GitHub's Octokit.rb][octokit.rb] Ruby library, and
pass in our [personal access token][personal token]:

    #!ruby
    require 'octokit'

    # !!! DO NOT EVER USE HARD-CODED VALUES IN A REAL APP !!!
    # Instead, set and test environment variables, like below
    client = Octokit::Client.new :access_token => ENV['MY_PERSONAL_TOKEN']


[pagination]: /v3/#pagination
[octokit.rb]: https://github.com/octokit/octokit.rb
[personal token]: https://help.github.com/articles/creating-an-access-token-for-command-line-use
