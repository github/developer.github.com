---
title: Events | GitHub API
---

# Events

This is a read-only API to the GitHub events.  These events power the
various activity streams on the site.

All Events have the same response format:

<%= headers 200, :pagination => true %>
<%= json(:event) { |h| [h] } %>

## List public events

    GET /events

## List repository events

    GET /repos/:user/:repo/events

## List issue events for a repository

    GET /repos/:user/:repo/issues/events

## List public events for a network of repositories

    GET /networks/:user/:repo/events

## List public events for an organization

    GET /orgs/:org/events

## List events that a user has received

These are events that you've received by watching repos and following
users.  If you are authenticated as the given user, you will see private
events.  Otherwise, you'll only see public events.

    GET /users/:user/received_events

## List public events that a user has received

    GET /users/:user/received_events/public

## List events performed by a user

If you are authenticated as the given user, you will see your private
events.  Otherwise, you'll only see public events.

    GET /users/:user/events

## List public events performed by a user

    GET /users/:user/events/public

## List events for an organization

This is the user's organization dashboard.  You must be authenticated as
the user to view this.

    GET /users/:user/events/orgs/:org

