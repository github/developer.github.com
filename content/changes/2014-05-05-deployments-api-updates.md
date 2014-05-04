---
kind: change
title: New attributes for the Deployments API
created_at: 2014-05-05
author_name: atmos
---

We're starting to feel pretty good about the Deployments API, and we'd like to introduce a new payload field plus a few extra attributes to the events API.

## API Changes

First off, we're introducing the concept of an `environment`. An environment is basically a unique identifier for a deployment target, lots of people tend toward the concept of environments for staging and QA.

![doc changes](https://camo.githubusercontent.com/5d3367127c45fc914b8dd65f3df8483459895873/687474703a2f2f636c6f75646170702e61746d6f732e6f72672f696d6167652f336d343530493031305533762f696e7465726e616c2d646576656c6f7065722e6769746875622e636f6d253230323031342d30352d303425323031342d33362d3033253230323031342d30352d303425323031342d33362d30372e6a7067)

## Event Changes

Second, we're adding a few attributes to the outbound payloads. We're now including the `ref` attribute so you know the branch or tag name that resolved to a specific sha. We're also including the `environment` and `sha` on both the Deployment and DeploymentStatus payloads.

### Deployment

![deployment payload changes](https://camo.githubusercontent.com/f4484721e95e51000400983724795d8cc5723706/687474703a2f2f636c6f75646170702e61746d6f732e6f72672f696d6167652f336730343145316f3062336a2f6576656e7473253230323031342d30352d303425323031342d33382d3436253230323031342d30352d303425323031342d33382d34382e6a7067)

### DeploymentStatus

![deployment status payload changes](https://camo.githubusercontent.com/4b80ae3a3b1579f4faf62469d89f291b6a1539f2/687474703a2f2f636c6f75646170702e61746d6f732e6f72672f696d6167652f3370324234323164324130342f6576656e7473253230323031342d30352d303425323031342d33372d3139253230323031342d30352d303425323031342d33372d34352e6a7067)

If you have any questions or feedback, please [get in touch][contact].

[contact]: https://github.com/contact?form[subject]=Deployments+API
