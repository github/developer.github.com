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
* Assignments
* Commits the user authors or commits
* Any discussion in which the user actively participates


## List your notifications

List all notifications for the current user, grouped by repository.

    GET /notifications

### Parameters

all
: _Optional_ **boolean** `true` to show notifications marked as read.

participating
: _Optional_ **boolean** `true` to show only notifications in which the user is
directly participating or mentioned.


## List your notifications in a repository

List all notifications for the current user.

    GET /repos/:owner/:repo/notifications

### Parameters

all
: _Optional_ **boolean** `true` to show notifications marked as read.

participating
: _Optional_ **boolean** `true` to show only notifications in which the user is
directly participating or mentioned.

## Mark as read

Marking a notification as "read" archives it removes it from the [default view
on GitHub.com](https://github.com/notifications).

    POST /notifications/mark_as_read

### Parameters

ids
: _Optional_ **Array(Number)** IDs of notifications to mark as read. If this
parameter is omitted, all notifications will be marked as read.

## Mark notifications as read in a repository

Marking all notification in a repository as "read" archives them removes them
from the [default view on GitHub.com](https://github.com/notifications).

    POST /repos/:owner/:repo/notifications/mark_as_read

## Mute a thread

Muting a thread prevents future notifications from being sent for a discussion
thread.

    POST /notifications/threads/:id/mute

## Unmute a thread

Muting a thread enables future notifications from being sent for a discussion
thread.

    POST /notifications/threads/:id/unmute

## Settings

Update the notification settings for the authenticated user.

    PATCH /notifications/settings

### Parameters

participating.email
: _Optional_ **boolean** `true` to receive participating notificationsn via
email.

participating.web
: _Optional_ **boolean** `true` to receive participating notificationsn via
web.

watching.email
: _Optional_ **boolean** `true` to receive watching notificationsn via
email.

watching.web
: _Optional_ **boolean** `true` to receive watching notificationsn via
web.


## Organization email address settings

Update the notification settings for the authenticated user.

    PATCH /orgs/:org/notifications/settings

### Parameters

email
: _Required_ **string** Email address to which to send notifications to the
authenticated user for discussions related to projects for this organization.

