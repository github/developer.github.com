---
kind: change
title: New Payload Format for Deployments
created_at: 2014-03-03
author_name: atmos
---

As we [iterate on the preview][january-deployment-api-post] for the new Deployments API, we're making sure that it's friendly to work with for the apps built on top of it.

## Deserialize Deployment Payloads

To make the API even easier to use, we'll now return your custom payload as a JSON object along with the rest of the Deployment resource. No need to parse it as JSON again.

## Code You Need to Update

You should only need to remove the JSON parsing if you're taking advantage of the custom payloads. The formats for creating Deployments remain unchanged.

As always, if you have any questions or feedback, please [get in touch][contact].

[january-deployment-api-post]: /changes/2014-01-09-preview-the-new-deployments-api/
[contact]: https://github.com/contact?form[subject]=Deployments+API
