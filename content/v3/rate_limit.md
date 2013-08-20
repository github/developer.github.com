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
<%= json :rate => {:limit => 5000, :remaining => 4999, :reset => 1372700873} %>
<br>

#### Future response

The current response (shown above) provides the rate limit status for _most_ of
the API. However, the Search API has a [custom rate limit](/v3/search/#rate-
limit), separate from the rate limit governing the rest of the API. For that
reason, this endpoint will
[soon](/changes/2013-07-19-preview-the-new-search-api) begin returning a
`"resources"` hash, which provides the rate limit status for all API resources.

To get this response format today, use the `application/vnd.github.preview`
[media type](/v3/media).

<%=
  headers 200,
    'X-RateLimit-Limit'     => 5000,
    'X-RateLimit-Remaining' => 4999,
    'X-RateLimit-Reset'     => 1372700873
%>
<%=
  json :rate => {:limit => 5000, :remaining => 4999, :reset => 1372700873},
    :resources => {
      :core   => {:limit => 5000, :remaining => 4999, :reset => 1372700873},
      :search => {:limit => 20,   :remaining => 18,   :reset => 1372697452},
    }
%>
