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

    POST /notifications/mark

## Mark notifications as read in a repository

Marking all notification in a repository as "read" archives them removes them
from the [default view on GitHub.com](https://github.com/notifications).

    POST /repos/:owner/:repo/notifications/mark

## View a single summary

    GET /notifications/summaries/:id

## Mark a summary as read

    POST /notifications/summaries/:id/mark

## Mute a summary

Muting a thread prevents future notifications from being sent for a discussion
summary.

    POST /notifications/summaries/:id/mute

## Unmute a summary

Muting a thread enables future notifications from being sent for a discussion
summary.

    POST /notifications/summaries/:id/unmute

## View Settings

    GET /notifications/settings

## Update Settings

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

<%= json \
  :participating => {:email => true, :web => false},
  :watching => {:email => true, :web => false} %>

## Get notification email settings

    GET /notifications/emails

## Get the global email settings

    GET /notifications/global/emails

## Get notification email settings for an organization

    GET /notifications/organization/:org/emails

## Update email settings

    PATCH /notifications/emails

## Update global email settings

    PUT /notifications/global/emails

### Parameters

email
: _Required_ **string** Email address to which to send notifications to the
authenticated user for discussions related to projects for this organization.

## Update Organization email settings

Update the notification settings for the authenticated user.

    PUT /notifications/organization/:org/emails

### Parameters

email
: _Required_ **string** Email address to which to send notifications to the
authenticated user for discussions related to projects for this organization.

