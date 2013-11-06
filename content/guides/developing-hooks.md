---
title: Developing Hooks | GitHub API
---

# Developing Hooks

* TOC
{:toc}

At their core, Hooks are post-receive messages that are deliver a payload of 
information about activity in a repository. Hooks can trigger across several 
different actions. For example, you can fire a payload of information any time
a commit is made, a repository is forked, or an issue is created.

A full list of hooks, and when they fire, can be found on [the hooks API][hooks-api].
In this guide, we'll take a look at how you can build and test a hook for your
own repositories. Our hook will be responsible for listing out how popular our
repository is, based on the number of Issues it receives per day.

## Creating Hooks

Developing a hook is a two-step process. You'll first need to set up how you want
your hook to behave through GitHub--what events should it listen to, and what
fields (if any) should be passed along. After that, you'll manage how to receive 
the payload on your server.

### Setting up a Hook

To set up a hook on GitHub, head over to [the hook creation page][hook-new-url]. (TODO: this sounds like it'll change)
We'll run through the options below:

(TODO: missing `public`)

* **Hook Name** - This is the name of your hook. We'll call ours `Issuematic`.
* **Owner** - Hooks can be owned by either your personal account, or an organization
you belong to. This field helps users that install your hook contact you. Let's 
keep this one personal.
* **Payload URL** - This is the server endpoint that will receive the hook 
payload. Since we're developing locally for now, let's set it to `http://localhost:4567`.
We'll explain why below. 
* **Description** - This helps users that install your hook understand what, 
exactly, the hook does.
* **Supported Triggers** - Toggling one or more of these triggers changes the sort
of information sent through the payload. Since we're only interested in issues,
we'll toggle just the **Issues** button.
* **Configuration Fields** - You might find that your hook needs additional 
information from users that install it. This could be a piece of information,
like an authentication token. We'll add a `text` one for our Issuematic hook.
Let's call it `greeting_message`. 

Phew! Once your hook is created, you'll need to actually install it onto a 
repository to test it out. You can pick any repository you own, or, create a 
dummy one to test things out. For more information on installing a hook, check 
out [this help article][installing-hooks].

(TODO: add image)

Since we required a greeting message from our users, let's add one: `"Hey, how it's going~!"`

## Testing Hooks

(TODO: are we going to continue to recommend outside services, like RequestBin?)

### Configuring the Server

Now, the fun part. We'll set up a basic Sinatra server to handle incoming payloads:

```ruby
require 'sinatra'
require 'rest_client'
require 'json'

post '/callback' do
  puts request.body.read
end
```


```json
{
   "payload":{
      "ref":"refs/heads/master",
      "after":"9a21d582f13c5b652c2c9546322bbf71682d3f06",
      "before":"05333fedb2f49ee2dd0dcc24b01d3d964f43c255",
   },
   ...
   "event":"push",
   "config":{
      "greeting_message":"Hey, how it's going~!",
      "url":"http://4pw3.localtunnel.com/callback"
   },
   "guid":"6168aab4-4737-11e3-9ac9-7403c7a52ec3"
}
```

[hooks-api]: http://developer.github.com/v3/repos/hooks/#events
[hook-new-url]: https://github.com/hooks/new
[installing-hooks]: https://help.github.com