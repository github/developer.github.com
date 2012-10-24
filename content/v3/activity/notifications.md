---
title: Notifications | GitHub API
---

# Notifications API

* TOC
{:toc}

GitHub Notifications are powered by [watched repositories](/v3/repos/watching/).
Users receive notifications for discussions in repositories they watch
including:

* Issues and their comments
* Pull Requests and their comments
* Comments on any commits

Notifications are also sent for discussions in unwatched repositories when the
user is involved including:

* **@mentions**
* Issue assignments
* Commits the user authors or commits
* Any discussion in which the user actively participates

Notifications come back as Summary objects.  A Summary contains information
about the current discussion of an Issue/PullRequest/Commit.

## List your notifications

List all notifications for the current user, grouped by repository.

    GET /notifications

### Parameters

all
: _Optional_ **boolean** `true` to show notifications marked as read.

participating
: _Optional_ **boolean** `true` to show only notifications in which the user is
directly participating or mentioned.

since
: _Optional_ **time** filters out any notifications updated before the given
time.  The time should be passed in as UTC in the ISO 8601 format:
`YYYY-MM-DDTHH:MM:SSZ`.  Example: "2012-10-09T23:39:01Z".

### Response

<%= headers 200 %>
<%= json(:summaries) %>

## List your notifications in a repository

List all notifications for the current user.

    GET /repos/:owner/:repo/notifications

### Parameters

all
: _Optional_ **boolean** `true` to show notifications marked as read.

participating
: _Optional_ **boolean** `true` to show only notifications in which the user is
directly participating or mentioned.

### Response

<%= headers 200 %>
<%= json(:summary) { |h| [h] } %>

## Mark as read

Marking a notification as "read" removes it from the [default view
on GitHub.com](https://github.com/notifications).

    POST /notifications/mark

### Response

<%= headers 205 %>

## Mark notifications as read in a repository

Marking all notifications in a repository as "read" removes them
from the [default view on GitHub.com](https://github.com/notifications).

    POST /repos/:owner/:repo/notifications/mark

### Response

<%= headers 205 %>

## View a single summary

    GET /notifications/summaries/:id

### Response

<%= headers 200 %>
<%= json(:summary) { |h| [h] } %>

## Mark a summary as read

    POST /notifications/summaries/:id/mark

### Response

<%= headers 205 %>

## Get a Summary Subscription

This checks to see if the current user is subscribed to a summary.  You can also
[get a Repository subscription](http://localhost:3000/v3/activity/watching/#get-a-repository-subscription).

    GET /notifications/summary/1/subscription

### Response

<%= headers 200 %>
<%= json :subscription %>

## Set a Summary Subscription

This lets you subscribe to a summary, or ignore it.  Subscribing to a summary
is unnecessary if the user is already subscribed to the repository.  Ignoring
a summary will mute all future notifications (until you comment or get
@mentioned).

    PUT /notifications/summary/1/subscription

### Input

subscribed
: **boolean** Determines if notifications should be received from this
repository.

ignored
: **boolean** Deterimines if all notifications should be blocked from this
repository.

### Response

<%= headers 200 %>
<%= json :subscription %>

## Delete a Summary Subscription

    DELETE /notifications/summary/1/subscription

### Response

<%= headers 204 %>
