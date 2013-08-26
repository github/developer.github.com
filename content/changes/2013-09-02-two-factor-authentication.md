---
kind: change
title: Two-Factor Authentication and the API
created_at: 2013-09-02
author_name: mastahyeti
---

To improve user security, GitHub has added the option for two-factor
authentication. Users with the feature enabled with be asked to provide a
two-factor authentication code in addition to their username and password when
authenticating to GitHub. For users with this feature enabled, some
improvements have been made to ensure that two-factor authentication
requirements in the API are consistent with GitHub.com.

Nothing will change for users without the feature enabled or for applications
using the [OAuth web flow](http://developer.github.com/v3/oauth/#web-application-flow) for authentication. For those who wish to enabled
two-factor authentication and use Basic Authentication, we have provided a few
options to make the flow simple and easy.

The simplest option for scripts using Basic Authentication is to send a
personal access token instead of a password. These tokens are similar to OAuth
access tokens, but can be created through GitHub.com via the 
[application settings page](https://github.com/settings/applications). More information about authenticating to the API
using personal access tokens can be found in [this](https://help.github.com/articles/creating-an-access-token-for-command-line-use) help article.

For those wishing to integrate GitHub two-factor authentication into their
application, some updates have been made to Basic Authentication to allow
sending the user's two-factor authentication code in addition to username and
password. Information about this approach can be found in the
[API doccumentation](http://developer.github.com/v3/auth/#working-with-two-factor-authentication).
