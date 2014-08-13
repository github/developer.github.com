---
title: Best practices for integrators | GitHub API
---

# Best practices for integrators

* TOC
{:toc}

Interested in integrating with the GitHub platform? [You're in good company](https://github.com/integrations). This guide will help you design a flexible system that provides the best experience for your users, and ensure that both services maintain a secure connection.

## Secure payloads delivered from GitHub

It's very important that you secure [the payloads sent from GitHub](/v3/activity/events/types/). Although no personal information is ever transmitted in a payload, leaking *any* information is not good.

There are two steps to take in order to secure payloads delivered by GitHub:

1. Ensure that your receiving server is on an HTTPS connection. By default, GitHub will verify SSL certificates when delivering payloads.
2. Provide [a secret token](/webhooks/securing/) to ensure payloads are definitely coming from GitHub.

By enforcing a secret token, you're ensuring that any data received by your server is absolutely coming from GitHub. Ideally, you should provide a different secret token *per user* of your service. That way, if one token is compromised, no other user would be affected.

Whitelisting [the IP address used when delivering hooks](https://help.github.com/articles/what-ip-addresses-does-github-use-that-i-should-whitelist) is another heavy-duty solution. However, we reserve the right to change those numbers at any time and without advance notice. To ensure that you're always checking the right IP address, you can [use the `/meta` endpoint](/v3/meta/#meta) to find the address we use.

## Provide a token to secure access to your service

Your server may need to perform actions on behalf of the user. Rather than requiring them to provide sensitive login information, you should generate a highly random OAuth token, and have your user provide that token to interact with your service. If possible, you should ensure that [the token is scoped to just the relevant access](/v3/oauth/#scopes).

GitHub provides [a way to create OAuth tokens through the website](https://help.github.com/articles/creating-an-access-token-for-command-line-use). Your service also request a GitHub OAuth token with the appropriate scopes if your service needs to interact with GitHub in some way. Note that you do not need a token if your service simply responds to a webhook.

{{#warning}}

Treat OAuth tokens just like user passwords. Don't store your user's OAuth tokens directly in a database; instead, use a hash of the token. In case your database gets compromised, attackers won't be able to use the hashed token to act on behalf of a user.

{{/warning}}

## Favor asynchronous work over synchronous

GitHub expects that services that integrate with GitHub finish their work within thirty seconds. If your service takes longer than that to complete, then GitHub terminates the connection and the payload is lost.

Since it's impossible to predict how fast your service will complete, you should do all of "the real work" in a background job. [Resque](http://resquework.org/) (for Ruby), [RQ](http://python-rq.org/) (for Python), or [RabbitMQ](http://www.rabbitmq.com/) (for Java) are examples of libraries that can handle queuing and processing of background jobs.

Note that even with a background job running, GitHub still expects your server to respond within thirty seconds. Your server simply needs to acknowledge that it received the payload by sending some sort of response. It's critical that your service to performs any validations on a payload as soon as possible, so that you can accurately report whether your server can continue with the request or not.

## Use appropriate HTTP status codes when responding to GitHub

Every webhook has its own "Recent Deliveries" section, which lists whether a deployment was successful or not.

![Recent Deliveries view](/images/webhooks_recent_deliveries.png)

You should make use of proper HTTP status codes in order to inform users. You can use codes like `201` or `202` to acknowledge receipt of payload that won't be processed (for example, a payload delivered by a branch that's not the default). Reserve the `500` error code for catastrophic failures.

## Provide as much information as possible to the user

Users can dig into the server responses you send back to GitHub. Ensure that your messages are clear and informative.  

![Viewing a payload response](/images/payload_response_tab.png)
