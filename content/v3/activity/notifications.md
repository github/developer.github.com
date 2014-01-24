---
title: Notifications | GitHub API
---

# Notifications

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

All Notification API calls require the `notifications` or
`repo` API scopes.  Doing this will give read-only access to
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

## Notification Reasons

When retrieving responses from the Notifications API, each payload has a key titled
`reason`. These correspond to events that trigger a notification.

Here's a list of potential `reason`s for receiving a notification:

Reason Name | Description
------------|------------
`subscribed` | The notification arrived because you're watching the repository
`manual` | The notification arrived because you've specifically decided to watch the item (via an Issue or Pull Request) 
`author` | The notification arrived because you've created the item 
`comment` | The notification arrived because you've commented on the item 
`mention` | The notification arrived because you were specifically **@mentioned** in the content 
`team_mention` | The notification arrived because you were on a team that was mentioned (like @org/team) 
`state_change` | The notification arrived because you changed the item state (like closing an Issue or merging a Pull Request) 
`assign` | The notification arrived because you were assigned to the Issue 

Note that the `reason` is modified on a per-thread basis, and can change, if the
`reason` on a later notification is different. 

For example, if you are the author of an issue, subsequent notifications on that 
issue will have a `reason` of `author`. If you're then  **@mentioned** on the same 
issue, the notifications you fetch thereafter will have a `reason` of `mention`. 
The `reason` remains as `mention`, regardless of whether you're ever mentioned again.

## List your notifications

List all notifications for the current user, grouped by repository.

    GET /notifications

### Parameters

Name | Type | Description
-----|------|--------------
`all`|`boolean` | If `true`, show notifications marked as read. Default: `false`
`participating`|`boolean` | If `true`, only shows notifications in which the user is directly participating or mentioned. Default: `false`
`since`|`string` | Filters out any notifications updated before the given time. This is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`. Default: `Time.now`


### Response

<%= headers 200 %>
<%= json(:thread) { |h| [h] } %>

## List your notifications in a repository

List all notifications for the current user.

    GET /repos/:owner/:repo/notifications

### Parameters

Name | Type | Description
-----|------|--------------
`all`|`boolean` | If `true`, show notifications marked as read. Default: `false`
`participating`|`boolean` | If `true`, only shows notifications in which the user is directly participating or mentioned. Default: `false`
`since`|`string` | Filters out any notifications updated before the given time. This is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`. Default: `Time.now`


### Response

<%= headers 200 %>
<%= json(:thread) { |h| [h] } %>

## Mark as read

Marking a notification as "read" removes it from the [default view
on GitHub.com](https://github.com/notifications).

    PUT /notifications

### Parameters

Name | Type | Description
-----|------|--------------
`last_read_at`|`string` | Describes the last point that notifications were checked.  Anything updated since this time will not be updated. This is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`. Default: `Time.now`


### Response

<%= headers 205 %>

## Mark notifications as read in a repository

Marking all notifications in a repository as "read" removes them
from the [default view on GitHub.com](https://github.com/notifications).

    PUT /repos/:owner/:repo/notifications

### Parameters

Name | Type | Description 
-----|------|--------------
`last_read_at`|`string` | Describes the last point that notifications were checked.  Anything updated since this time will not be updated. This is a timestamp in ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ`. Default: `Time.now`


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

    GET /notifications/threads/:id/subscription

### Response

<%= headers 200 %>
<%= json :subscription %>

## Set a Thread Subscription

This lets you subscribe to a thread, or ignore it.  Subscribing to a thread
is unnecessary if the user is already subscribed to the repository.  Ignoring
a thread will mute all future notifications (until you comment or get
@mentioned).

    PUT /notifications/threads/:id/subscription

### Parameters

Name | Type | Description
-----|------|--------------
`subscribed`|`boolean`| Determines if notifications should be received from this thread
`ignored`|`boolean`| Determines if all notifications should be blocked from this thread


### Response

<%= headers 200 %>
<%= json :subscription %>

## Delete a Thread Subscription

    DELETE /notifications/threads/:id/subscription

### Response

<%= headers 204 %>

