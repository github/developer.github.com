---
kind: change
title: Preview the New Combined Status API
created_at: 2014-03-27
author_name: bhuga
---

What does it mean for a branch to be "green?" The [Status API][status-api] helps
thousands of teams answer that question. Developers use it to record the status
of continuous integration builds, contributor license agreements, code coverage
analysis, automated security testing, dependency management, and more.

For many teams, a branch is considered "green" only when _all_ of their various
status checks are successful. With the new [Combined Status
API][combined-status-api], developers can easily fetch this single, consolidated
status for any branch, commit, or tag.

### Status context

To help multiple service providers use the Status API simultaneously, statuses
now support a `context` field. This field allows a provider to distinguish its
statuses from another provider's statuses. For example, your [Jenkins][] builds
might use a context of `ci/jenkins`, while your [Brakeman][] checks might adopt a
context of `security/brakeman`.

The new [Combined Status endpoint][combined-status-api] returns a single,
combined state, as well as the latest status from each context. Systems that
consume status updates can now get all the information they need in one place.

### Opt-in

The existing [Status API][list-statuses] continues to work as it always has. The
`context` field is entirely optional, and the [color of the merge button on pull
requests](https://github.com/blog/1227-commit-status-api) does not currently
take context into account.

### Preview period

We're making this new API available today for developers to
[preview][status-api]. During this period, we may change aspects of the Combined
Status API from time to time. We will announce any changes here (on the
developer blog), but we will not provide any advance notice.

We expect the preview period to last 30-60 days. At the end of preview period,
the Combined Status API will become an official component of GitHub API v3. At
that point, this new API will be stable and suitable for production use.

We hope you'll [try it out][status-api] and [send us your feedback][contact]!

[status-api]: /v3/repos/statuses/
[contact]: https://github.com/contact?form[subject]=Combined+Status+API
[combined-status-api]: /v3/repos/statuses/#get-the-combined-status-for-a-specific-ref
[create-a-status]: /v3/repos/statuses/#create-a-status
[brakeman]: http://brakemanscanner.org/
[jenkins]: http://jenkins-ci.org/
[list-statuses]: /v3/repos/statuses/#list-statuses-for-a-specific-ref
