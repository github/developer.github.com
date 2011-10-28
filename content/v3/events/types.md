---
title: Event types | GitHub API
---

# Event Types

Each event has a similar JSON schema, but a unique `payload` object that is
determined by its event type.  [Repository hook](http://developer.github.com/v3/repos/hooks/) names relate to event types, and will have the exact same payload.  The only exception to this is the `push` hook, which has a larger, more detailed payload.

## PushEvent

Hook name: push

head
: **string** - The SHA of the HEAD commit on the repository.

ref
: **string** - The full Git ref that was pushed.  Example:
"refs/heads/master"

size
: **integer** - The number of commits in the push.

commits
: **array** - The list of pushed commits.

commits[][sha]
: **string** - The SHA of the commit.

commits[][message]
: **message** - The commit message.

commits[][author]
: **object** - The git author of the commit.

commits[][author][name]
: **string** - The git author's name.

commits[][author][email]
: **string** - The git author's email address.
  
commits[][url]
: **url** - Points to the commit API resource.

