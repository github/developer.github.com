---
kind: change
title: Upcoming Change to Default Media Type
created_at: 2014-01-07
author_name: jasonrudolph
---

On April 15, 2014[*](#cutover-test), the GitHub API will start serving the v3 media type by default. The information below will help you determine whether your applications will be affected by this change. For affected applications, you'll find tips below to help you smoothly navigate this change.

## What's changing?

### A new default version

There are [two versions][versions] of the GitHub API: **beta** and **v3**. Today, requests receive the beta version by default. On April 15[*](#cutover-test), requests will begin receiving the v3 version by default.

For the most part, beta and v3 are remarkably similar. There are [just a few differences][differences] to keep in mind.

### A new default media type

The version is one part of the [media type][media]. By default, the API provides the beta media type:

    application/vnd.github.beta+json

On April 15[*](#cutover-test), requests will begin responding with the v3 media type by default:

    application/vnd.github.v3+json

## Who is affected?

Since 2012, we have encouraged developers to explicitly [request a specific media type via the `Accept` header][request-a-media-type]. If you are requesting either beta or v3 via the `Accept` header, then you are _not_ affected by this change. The API will continue to respond with the requested media type.

If you are not requesting beta or v3 via the `Accept` header, then the API is currently responding with the beta media type. On April 15[*](#cutover-test), the API will begin responding with the v3 media type. If your application relies on [functionality that differs between beta and v3][differences], then you are affected by this change. You will need to take steps to prepare for the change.

## What should you do?

If you are affected by this change, we recommend that you:

1. Update your applications to depend on the v3 functionality instead of the beta functionality. (If you use one of the popular [client libraries][libraries], there's a good chance that they've already done the work for you. In that case, you can just update to the latest version of that library.)
2. Request the v3 media type via the `Accept` header.

If you cannot update your application to depend on the v3 functionality by April 15[*](#cutover-test), you can just request the beta media type via the `Accept` header. Doing so will insulate you from this change.

## Cutover test on March 12, 2014 {#cutover-test}

To help you understand the impact of this change before it becomes permanent, we will temporarily implement this change for a single day on March 12. From approximately 12:01am UTC to 11:59pm UTC on March 12, the API will respond with the v3 media type by default.

Follow [@GitHubAPI][] to receive updates before and after the test.

## Stay informed

Depending on the results of the cutover test, we may schedule additional tests before the final cutover on April 15. If so, we'll to announce them in advance. Be sure to stay tuned to the [blog] or follow [@GitHubAPI] for updates.

If you have any questions, please [get in touch][contact]. We'll be happy to help.

[@GitHubAPI]: https://twitter.com/GitHubAPI
[blog]: /changes
[contact]: https://github.com/contact?form[subject]=Upcoming+change+to+default+API+media+type
[differences]: /v3/versions/#differences-from-beta-version
[libraries]: /libraries/
[media]: /v3/media
[request-a-media-type]: /v3/media/#request-specific-version
[versions]: /v3/versions
