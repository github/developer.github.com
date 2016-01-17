---
title: Emojis
---

# Emojis

Lists all the emojis available to use on {{ site.data.variables.product.product_name }}.

    GET /emojis

### Response

<%= headers 200 %>
<%= json(:emojis)  %>
