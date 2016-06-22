---
title: Deployment and DeploymentStatus API enhancements preview period
author_name: tarebyte
---

We've expanded our Deployments APIs to accommodate more powerful deployment practices and to lay the foundation for a more seamless integration of deployments within GitHub.

## Link to a live deployment

To enable easy access to a live version of a deployment, we've added an `environment_url` field to the Deployments API. This environment will be exposed as a link in the Pull Request timeline to enable users to directly access a running version of their code without leaving the context of their work.

*Note: To add some clarity, we've renamed the `target_url` field to `log_url`. We will continue accept `target_url` to support legacy uses, but we recommend modifying this to the new name to avoid confusion. Future API versions might not support `target_url`*.

## Inactive deployment status

We recognize that deployments in many common practices don't last forever. So, we've added a new `inactive` state to Deployment Statuses. You can use this state to communicate that a deployment is no longer active (e.g. something different has been deployed to the environment or the environment has been destroyed).

## More information about environments

We've expanded our Deployments API to provide additional information about the environments associated with deployments.

We've added a new `transient_environment` field to allow you to communicate that an environment is specific to a deployment and will no longer exist at some point in the future (e.g. a temporary testing environment like a [Heroku Review App][heroku-review-app]). By pairing this with other additions, we can determine that an `inactive` deployment associated with a `transient_environment` has an `environment_url` that is no longer accessible.

Similarly, we've added a new `production_environment` field to allow you to communicate that an environment is one with which end users directly interact. We automatically set `production_environment` to `true` if the value for `environment` is ``"production"``.

## Automatic creation of inactive statuses

Each time we receive a new successful deployment status, we automatically add a new `inactive` status to all previous deployments made within the relevant repository to the same environment (based on the value of `environment`) given the environment is both non-transient and non-production. You can opt out of this behavior by passing `false` with the new `auto_inactive` parameter.

For example, if `feature-branch` within `https://github.com/user/repository` is deployed to an environment named `staging` (which is a non-transient, non-production environment) and `bugfix-branch` within `https://github.com/user/repository` is later deployed to an environment named `staging`, we would automatically create a new `inactive` status for the deployment associated with `feature-branch`.

#### How can I try it?

Starting today, these API enhancements are available for developers to preview. At the end of the preview period, these enhancements will become official components of the GitHub API.

To access the API during the preview period, you must provide a custom [media type][media-types] in the Accept header:

```
application/vnd.github.ant-man-preview+json
```

During the preview period, we may change aspects of these enhancements. If we do, we will announce the changes on the developer blog, but we will not provide any advance notice.

Take a look at [the documentation][docs] for full details. We would love to hear your thoughts on these enhancements. If you have any questions or feedback, please [get in touch with us][contact]!

[contact]: https://github.com/contact?form%5Bsubject%5D=Deployment+and+DeploymentStatus+API+enhancements+preview+period
[media-types]: /v3/media/
[heroku-review-app]: https://devcenter.heroku.com/articles/github-integration-review-apps
[docs]:https://developer.github.com/v3/repos/deployments/
