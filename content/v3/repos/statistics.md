---
title: Repo Stats | GitHub API
---

# Repo Stats API

* TOC
{:toc}

These API methods allow you to get the data that powers the graphs on GitHub.  All
methods, excluding `punch_card`, will return a `202` if the data isn't yet available
and cached.  Subsequent request should return the data.

## Get contributors list with additions, deletions and commit counts

    GET /repos/:owner/:repo/stats/contributors

### Response

<%= headers 200 %>
<%= json(:repo_stats_contributors) %>


**Weekly Hash**

* `w` - Start of the week
* `a` - Number of additions
* `d` - Number of deletions
* `c` - Number of commits


## Get the last year of commit activity data

    GET /repos/:owner/:repo/stats/commit_activity

### Response

<%= headers 200 %>

## Get the number of additions and deletions per week

    GET /repos/:owner/:repo/stats/code_frequency

### Response

<%= headers 200 %>

## Get the weekly commit count for the repo owner and others

    GET /repos/:owner/:repo/stats/code_frequency

### Response

<%= headers 200 %>

## Get the number of commits per hour in day

    GET /repos/:owner/:repo/stats/punch_card

### Response

<%= headers 200 %>