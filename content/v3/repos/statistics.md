---
title: Repo Stats | GitHub API
---

# Repo Stats API

* TOC
{:toc}

The repository stats API allows you to fetch the data that GitHub uses for visualizing different
types of repository activity.

### A word about caching

Computing repository statistics is an expensive operation, so we try to return cached
data whenever possible.  When you ask for a repositories statistics, and the data hasn't
been cached, you'll receive a `202` response and a background job will get kicked off that
starts compiling these statistics.  Subsequent requests should return the data.

Reposotiry statistics are cached by the master sha.  Pushing to a repository will
bust its stats cache.

***NOTE:** `202` responses do *not* count towards API rate limits.

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

Returns the last year of commit activity grouped by week.  The `days` array
is a group of commits per day, starting on `Sunday`.

    GET /repos/:owner/:repo/stats/commit_activity

### Response

<%= headers 200 %>
<%= json(:repo_stats_commit_activity) %>

## Get the number of additions and deletions per week

    GET /repos/:owner/:repo/stats/code_frequency

### Response

<%= headers 200 %>
<%= json(:repo_stats_code_frequency) %>

## Get the weekly commit count for the repo owner and others

    GET /repos/:owner/:repo/stats/code_frequency

### Response

<%= headers 200 %>
<%= json(:repo_stats_participation) %>

## Get the number of commits per hour in each day

    GET /repos/:owner/:repo/stats/punch_card

### Response

Each array contains the day number, hour number and number of commits:

* `0-6` = Sunday - Saturday
* `0-23` = Hour of day
* Number of commits

For example, `[2, 14, 25]` would indicate that there were 25 total commits, during the 2:00pm hour on Tuesdays.

<%= headers 200 %>
<%= json(:repo_stats_punch_card) %>