---
title: Creating webhooks
layout: webhooks
---

# Creating Webhooks!

{:toc}

Now that we understand [the basics of webhooks][webhooks-overview], let's go
through the process of building out our own webhook powered integration.  In
this tutorial, we'll create a repository webhook that will be responsible for
listing out how popular our repository is, based on the number of Issues it
receives per day.

Creating a webhook is a two-step process. You'll first need to set up how you want
your webhook to behave through {{ site.data.variables.product.product_name }}--what events should it listen to. After that,
you'll set up your server to receive and manage the payload.

## Setting up a Webhook

To set up a repository webhook on {{ site.data.variables.product.product_name }}, head over to the **Settings** page of
your repository, and click on **Webhooks & services**. After that, click on
**Add webhook**.

Alternatively, you can choose to build and manage a webhook [through the Webhooks API][webhook-api].

Webhooks require a few configuration options before you can make use of them.
We'll go through each of these settings below.

## Payload URL

This is the server endpoint that will receive the webhook payload.

Since we're developing locally for our tutorial, let's set it to `http://localhost:4567/payload`.
We'll explain why in the [Configuring Your Server](/webhooks/configuring/) docs.

## Content Type

Webhooks can be delivered using different content types:

- The `application/json` content type will deliver the JSON payload directly as the body of the POST.
- The `application/x-www-form-urlencoded` content type will send the JSON payload as a form parameter
  called "payload".

Choose the one that best fits your needs. For this tutorial, the default content type of
`application/json` is fine.

## Events

Events are at the core of webhooks. These webhooks fire whenever a certain action is
taken on the repository, which your server's payload URL intercepts and acts upon.

A full list of webhook events, and when they execute, can be found in [the webhooks API][hooks-api] reference.

Since our webhook is dealing with Issues in a repository, we'll click on **Issues**,
and toggle the options there.

When you're finished, click on **Add webhook**. Phew! Now that the webhook is created,
it's time to set up our local server to test the webhook. Head on over to
[Configuring Your Server](/webhooks/configuring/) to learn how to do that.

[webhooks-overview]: /webhooks/
[webhook-api]: /v3/repos/hooks/
[hooks-api]: /webhooks/#events
