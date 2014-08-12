---
title: Automating deployments to integrators | GitHub API
---

# Automating deployments to integrators

* TOC
{:toc}

The "[Delivering deployments](/guides/delivering-deployments/)" guide describes how to build a server that uses the [Deployments API][deploy API] to easily get your code from GitHub into production. But what if you don't want to host a separate service like [heaven][]? What if you just want to merge code and have it deploy without even thinking about maintaining another app?

You can use the GitHub Auto-Deployment service to receive changes made to your repository and configure it to deliver a deployment to integrators. The Auto-Deployment service can deliver payloads based on two events: whenever a push is made and whenever [the CI status is passing](/guides/building-a-ci-server/).

{{#tip}}

Note that the Auto-Deployment service only picks up changes from your default branch, which is usually `master`.

{{/tip}}

## Sending deployments whenever you push to a repository

To set up the Auto-Deployment service:

1. Navigate to the repository where you’re setting up your deployments.
2. In your repository's right sidebar, click <span aria-label="The edit icon" title="The edit icon" class="octicon octicon-tools"></span>.
3. On the left, click **Webhooks & Services**.
![The webhooks and services menu](https://github-images.s3.amazonaws.com/help/settings/webhooks_and_services_menu.png)
4. Click **Add service**, then type "GitHub Auto-Deployment." ![Adding the GitHub Auto-Deployment service](/images/add_github_autodeploy_service.png)
5. Under **GitHub token**, paste an access token you've created. It must have at least the `repo` scope. For more information, see "[Creating an access token for command-line use](https://help.github.com/articles/creating-an-access-token-for-command-line-use)."
6. Under **Environments**,
7. If you *only* want builds that successfully passed a continuous test suite, select **Deploy on status**.
8. Click **Add service**.

## Hooking up an integrator with deployments



[deploy API]: /v3/repos/deployments/
[heaven]: https://github.com/atmos/heaven
