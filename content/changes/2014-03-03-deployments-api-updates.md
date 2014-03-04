---
kind: change
title: New Payload format for Deployments
created_at: 2014-03-03
author_name: atmos
---

As we [iterate on the preview][january-deployment-api-post] for the new Deployment API, we're making sure that it's friendly to work with for the apps built on top of it.

## Deserialize Deployment Payloads

If you've built anything around the API then you're probably doing a second deserialization of the returned JSON body for Deployment or DeploymentStatus objects. It seemed silly to keep this in place and it was a convention that we don't follow anywhere else in the API. 

## Code you need to update

You should only need to remove the JSON parsing if you're taking advantage of the custom payloads. The formats for creating Deployments remain unchanged.

As always, if you have any questions or feedback, please [get in touch][contact].

[january-deployment-api-post]: /changes/2014-01-09-preview-the-new-deployments-api/
[contact]: https://github.com/contact?form[subject]=Deployments+API
