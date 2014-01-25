---
title: Testing Hooks | GitHub API
layout: hooks
---

# Testing Hooks

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
