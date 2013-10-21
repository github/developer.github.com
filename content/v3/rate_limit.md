---
title: GitHub Rate Limit API | GitHub API
---

# GitHub Rate Limit API

The overview documentation describes the [rate limit rules](/v3/#rate-limiting).
You can check your current rate limit status at any time using the Rate Limit
API described below.

## Get your current rate limit status

Note: Accessing this endpoint does not count against your rate limit.

    GET /rate_limit

### Response

<%=
  headers 200,
    'X-RateLimit-Limit'     => 5000,
    'X-RateLimit-Remaining' => 4999,
    'X-RateLimit-Reset'     => 1372700873
%>
<%=
  json :resources => {
      :core   => {:limit => 5000, :remaining => 4999, :reset => 1372700873},
      :search => {:limit => 20,   :remaining => 18,   :reset => 1372697452},
    },
    :rate => {:limit => 5000, :remaining => 4999, :reset => 1372700873}
%>
<br>

#### Understanding Your Rate Limit Status

The Search API has a [custom rate limit](/v3/search/#rate-limit), separate from
the rate limit governing the rest of the API. For that reason, the response
(shown above) categorizes your rate limit by resource. Within the `"resources"`
hash, the `"search"` hash provides your rate limit status for the
[Search API](v3/search). The `"core"` hash provides your rate limit status for
all the _rest_ of the API.
