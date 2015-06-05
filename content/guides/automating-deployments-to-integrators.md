---
title: Automating deployments to integrators | GitHub API
---

# Automating deployments to integrators

* TOC
{:toc}

The "[Delivering deployments](/guides/delivering-deployments/)" guide describes how to build a server that uses the [Deployments API][deploy API] to easily get your code from GitHub into production. But what if you don't want to host a separate service for deploying code? What if you just want to merge code and have it deploy without thinking about maintaining another app?

You can use the GitHub Auto-Deployment service to receive changes made to your repository and configure it to deliver a deployment to integrators. The Auto-Deployment service can deliver payloads based on two events: whenever a push is made and whenever [the CI status is passing](/guides/building-a-ci-server/).

Here's a diagram demonstrating what the process might look like:

<pre>
+--------------------+        +--------+                    +-----------+
| GitHub Auto-Deploy |        | GitHub |                    |  Heroku   |
|      Service       |        +--------+                    +-----------+
+--------------------+         |                                  |
     |                         |                                  |
     |  Create Deployment      |                                  |
     |------------------------>|                                  |
     |                         |                                  |
     |                         |                                  |
     |                         |       Deployment Event           |
     |                         |--------------------------------->|
     |                         |                                  |
     |                         |    Deployment Status (pending)   |
     |                         |<---------------------------------|
     |                         |                                  |
     |                         |                                  |
     |                         |   Deployment Status (success)    |
     |                         |<---------------------------------|
     |                         |                                  |
</pre>

{{#tip}}

Note that the Auto-Deployment service only picks up changes from your default branch, which is usually `master`.

{{/tip}}

## Sending deployments whenever you push to a repository

The Auto-Deployment service will be responsible for creating deployments when a push is made to your default branch. Next, we'll set up a service to receive those deployment events and handle the deployment of your project.

1. Navigate to the repository where you’re setting up your deployments.
2. In your repository's right sidebar, click <span aria-label="The edit icon" title="The edit icon" class="octicon octicon-tools"></span>.
3. On the left, click **Webhooks & Services**.
![The webhooks and services menu](https://github-images.s3.amazonaws.com/help/settings/webhooks_and_services_menu.png)
4. Click **Add service**, then type "GitHub Auto-Deployment." ![Adding the GitHub Auto-Deployment service](/images/add_github_autodeploy_service.png)
5. Under **GitHub token**, paste an access token you've created. It must have at least the `repo` scope. For more information, see "[Creating an access token for command-line use](https://help.github.com/articles/creating-an-access-token-for-command-line-use)."
6. Under **Environments**, optionally provide a list of environments you'd like to send your deployments to. This can be [any string you define](https://developer.github.com/v3/repos/deployments/#parameters) to describe your environment. The default is "production."
7. If you *only* want builds that successfully passed a continuous test suite, select **Deploy on status**.
8. If you're running this service on GitHub Enterprise, you must pass in your appliance's [endpoint URL](https://developer.github.com/v3/enterprise/#endpoint-urls).
9. Click **Add service**.

## Hooking up an integrator to deployments

To implement our deployments, we'll use Heroku as an example service.

1. Navigate to the repository where you’re setting up your deployments.
2. In your repository's right sidebar, click <span aria-label="The edit icon" title="The edit icon" class="octicon octicon-tools"></span>.
3. On the left, click **Webhooks & Services**.
![The webhooks and services menu](https://github-images.s3.amazonaws.com/help/settings/webhooks_and_services_menu.png)
4. Click **Add service**, then type "Heroku." ![Adding the GitHub Auto-Deployment service](/images/add_heroku_autodeploy_service.png)
5. Type the name of the Heroku application your GitHub repository should deploy to.
6. Enter in your [Heroku OAuth token](https://devcenter.heroku.com/articles/oauth#direct-authorization). You must generate this yourself following the instructions in Heroku's documentation.
7. Under **GitHub token**, paste the same token you provided earlier.
8. Click **Add service**.

From now on, any commits made to your `master` branch--including those generated from merging pull requests--will automatically trigger a deployment to your Heroku application.

[deploy API]: /v3/repos/deployments/
