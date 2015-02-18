---
kind: change
title: Preview the New Deployments API
created_at: 2014-01-09
author_name: atmos
---

Today we're excited to announce a [Deployments API][docs]. We ship a lot of
software at GitHub: web, mobile, and native. For the last few years, we've been
driving our deployments from our [ChatOps tooling][chatops] and we've learned a
lot. The Deployments API is a generalization of the approach that we've been
taking, and we're really excited to see what our users and integrations start
building around it.

Deployments are a new model in the GitHub ecosystem. We don't have any UI
components currently, and deployments are intended to be used exclusively by
tooling.  If you're familiar with the Status API, you know that it allows
various tools to report on the status of a commit (e.g., the progress of an
attempt to perform a build at a particular commit). The Status API doesn't
perform the build; it just reports the results. Much like the Status API, we
won't be doing actual deployments for you. Instead, the API provides a way for
you to track the status of your deployments. We're hoping to provide
consistency across the various type of release processes, regardless of the
underlying steps involved with getting your code built or shipped to your
servers.

## Highlights

### Automatic Merging

The system can auto-merge the default branch for the repository if the
requested deployment ref is behind the default branch. On active projects it's
easy to fall behind, so let automation watch your back.

### Commit Status Integration

By default, the system rejects deployment requests for repositories that have
commit statuses but don't have a green build for the deployment ref. This can
be bypassed, but is useful in cases where continuous integration is being used.

### Force Deployments

Sometimes the world crashes down on you, and you need to just get the code out
the door.  Forced deployments bypass any commit status checks or ahead/behind
checks in the repository.

### Deployment Statuses

Different deployment systems can update the status of a deployment to be
`pending`, `success`, `failure`, or `error`. There's also a field for linking
to deployment output.

### Events

Both Deployments and Deployment Statuses trigger events on GitHub. 3rd party
integrations can listen for these events via [webhooks][hooks] and choose
whether or not to actually deploy the repository that the event was created for.

## Preview Period

We're making this new API available today for developers to
<a href="/v3/repos/deployments/#preview-mode" data-proofer-ignore>preview</a>.  We think developers and existing integrations are
going to love it, but we want to [get your feedback][contact] before we declare
the Deployments API "final" and "unchangeable." We expect the preview period to
last for roughly 60-90 days.

As we discover opportunities to improve the API during the preview period, we
may ship changes that break clients using the preview version of the API. We
want to iterate quickly. To do so, we will announce any changes here (on the
developer blog), but we will not provide any advance notice.

At the end of preview period, the Deployments API will become an official
component of GitHub API v3. At that point, the new Deployments API will be
stable and suitable for production use.

We hope you’ll take it for a spin and [send us your feedback][contact].

![Shipit Squirrel](https://camo.githubusercontent.com/da8106f759bf0d163fb002e715fb1d1f1d2b6f4e/687474703a2f2f736869706974737175697272656c2e6769746875622e696f2f696d616765732f736869702532306974253230737175697272656c2e706e67)

[docs]: /v3/repos/deployments/
[hooks]: /v3/repos/hooks/
[chatops]: https://speakerdeck.com/jnewland/chatops
[contact]: https://github.com/contact?form[subject]=Deployments+API
