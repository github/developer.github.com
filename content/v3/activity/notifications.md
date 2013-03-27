---
title: Notifications | GitHub API
---

# Notifications API

* TOC
{:toc}

GitHub Notifications are powered by [watched repositories](/v3/activity/watching/).
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

All Notification API calls require the <strong>"notifications"</strong> or
<strong>"repo</strong> API scopes.  Doing this will give read-only access to
some Issue/Commit content. You will still need the "repo" scope to access
Issues and Commits from their respective endpoints.

Notifications come back as "threads".  A Thread contains information about the
current discussion of an Issue/PullRequest/Commit.

Notifications are optimized for polling with the "Last-Modified" header.  If
there are no new notifications, you will see a "304 Not Modified" response,
leaving your current rate limit untouched.  There is an "X-Poll-Interval"
header that specifies how often (in seconds) you are allowed to poll.  In times
of high server load, the time may increase.  Please obey the header.

    # Add authentication to your requests
    $ curl -I https://api.github.com/notifications
    HTTP/1.1 200 OK
    Last-Modified: Thu, 25 Oct 2012 15:16:27 GMT
    X-Poll-Interval: 60

    # Pass the Last-Modified header exactly
    $ curl -I https://api.github.com/notifications
        -H "If-Modified-Since: Thu, 25 Oct 2012 15:16:27 GMT"
    HTTP/1.1 304 Not Modified
    X-Poll-Interval: 60

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
<%= json(:thread) { |h| [h] } %>

## List your notifications in a repository

List all notifications for the current user.

    GET /repos/:owner/:repo/notifications

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
<%= json(:thread) { |h| [h] } %>

## Mark as read

Marking a notification as "read" removes it from the [default view
on GitHub.com](https://github.com/notifications).

    PUT /notifications

### Input

last_read_at
: _Optional_ **Time** Describes the last point that notifications were checked.  Anything
updated since this time will not be updated.  Default: Now.  Expected in ISO
8601 format: `YYYY-MM-DDTHH:MM:SSZ`.  Example: "2012-10-09T23:39:01Z".

### Response

<%= headers 205 %>

## Mark notifications as read in a repository

Marking all notifications in a repository as "read" removes them
from the [default view on GitHub.com](https://github.com/notifications).

    PUT /repos/:owner/:repo/notifications

### Input

last_read_at
: _Optional_ **Time** Describes the last point that notifications were checked.  Anything
updated since this time will not be updated.  Default: Now.  Expected in ISO
8601 format: `YYYY-MM-DDTHH:MM:SSZ`.  Example: "2012-10-09T23:39:01Z".

### Response

<%= headers 205 %>

## View a single thread

    GET /notifications/threads/:id

### Response

<%= headers 200 %>
<%= json(:thread) %>

## Mark a thread as read

    PATCH /notifications/threads/:id

### Response

<%= headers 205 %>

## Get a Thread Subscription

This checks to see if the current user is subscribed to a thread.  You can also
[get a Repository subscription](/v3/activity/watching/#get-a-repository-subscription).

    GET /notifications/threads/1/subscription

### Response

<%= headers 200 %>
<%= json :subscription %>

## Set a Thread Subscription

This lets you subscribe to a thread, or ignore it.  Subscribing to a thread
is unnecessary if the user is already subscribed to the repository.  Ignoring
a thread will mute all future notifications (until you comment or get
@mentioned).

    PUT /notifications/threads/1/subscription

### Input

subscribed
: **boolean** Determines if notifications should be received from this
thread.

ignored
: **boolean** Determines if all notifications should be blocked from this
thread.

### Response

<%= headers 200 %>
<%= json :subscription %>

## Delete a Thread Subscription

    DELETE /notifications/threads/1/subscription

### Response

<%= headers 204 %>

