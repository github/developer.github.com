---
title: Best practices for integrators | GitHub API
---

# Best practices for integrators

* TOC
{:toc}

Interested in integrating with the GitHub platform? [You're in good company](https://github.com/integrations). This guide will help you provide the best experience to your users, while ensuring both services maintain a secure connection.

## Secure the payloads delivered from GitHub

It's very important that you secure [the payloads sent from GitHub](/v3/activity/events/types/). Although no personal information is transmitted, for private repositories, leaking information is generally considered a bad practice.

There are two steps to take in order to secure payloads delivered by GitHub:

1. Ensure that your receiving server is on an HTTPS connection. By default, GitHub will verify SSL certificates when delivering payloads.
2. Provide [a secret token](/webhooks/securing/) to ensure payloads are definitely coming from GitHub.

By enforcing a secret token, you're ensuring that any data received by your server is absolutely coming from GitHub. Ideally, you should provide a different secret token *per user* of your service. That way, if one token is compromised, no other user would be affected.

[Whitelisting GitHub's IP addresses](https://help.github.com/articles/what-ip-addresses-does-github-use-that-i-should-whitelist) is another heavy-duty solution. However, we reserve the right to change those numbers at any time and without advance notice.

## Provide an access token to secure access to your service

Your server may need to perform actions on behalf of the user. Rather than requiring them to provide sensitive login information, you should generate a highly random OAuth token, and have your user provide that token to interact with your service. If possible, you should ensure that [the token is scoped to just the relevant access](/v3/oauth/#scopes).

GitHub provides [a way to create OAuth tokens through the website](https://help.github.com/articles/creating-an-access-token-for-command-line-use). You should request a GitHub OAuth token with the appropriate scopes if your service needs to interact with GitHub in some way. Note that you do not need a token if your service simply responds to a webhook.
## Favor asynchronous work over synchronous

## Use appropriate HTTP status codes when responding

## Provide as much information as possible to the user
