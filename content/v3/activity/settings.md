---
title: Notification Settings | GitHub API
---

# Notification Settings API

This API is not implemented.  This documentation is a placeholder for when it
is ready for public consumption.

## View Settings

    GET /notifications/settings

## Update Settings

Update the notification settings for the authenticated user.

    PATCH /notifications/settings

### Parameters

participating.email
: _Optional_ **boolean** `true` to receive participating notifications via
email.

participating.web
: _Optional_ **boolean** `true` to receive participating notifications via
web.

watching.email
: _Optional_ **boolean** `true` to receive watching notifications via
email.

watching.web
: _Optional_ **boolean** `true` to receive watching notifications via
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

