---
kind: change
title: Extending the preview period for the Deployments API
created_at: 2014-04-10
author_name: atmos
---

We're going to extend the Deployment API preview timeframe based on feedback from end-users.  We're still fleshing out what the [Deployments API][january-deployment-api-post] will look like when it graduates from preview mode and becomes a fully supported part of the GitHub API. We've already [updated the payload][payload-update] that integrations can use to customize deployments. We're also integrating with the [Combined Status API][combined-statuses] to help ensure that only verified code gets deployed, even if you have multiple systems verifying different aspects of your software.

We've decided to extend the Deployments API preview for another 30-60 days in order to make sure that everything works well with the changes we've been introducing. As always, if you have any questions or feedback, please [get in touch][contact].

[january-deployment-api-post]: /changes/2014-01-09-preview-the-new-deployments-api/
[payload-update]: /changes/2014-03-03-deployments-api-updates/
[combined-statuses]: /changes/2014-03-27-combined-status-api/
[contact]: https://github.com/contact?form[subject]=Deployments+API
