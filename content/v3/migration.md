---
title: Migration
---

# Migration

These APIs help you move projects to or from {{ site.data.variables.product.product_name }}.

{% if page.version == 'dotcom' %}

## [Enterprise Migrations][migrations]

The [Enterprise Migrations API][migrations] lets you move a repository from GitHub to GitHub Enterprise.

## [Source Imports][source_imports]

The [Source Imports API][source_imports] lets you import a source repository to
{{ site.data.variables.product.product_name }}.

{% else %}

The migration APIs are only available on github.com. To learn more about migration,
read the [API documentation on github.com](https://developer.github.com/v3/migration/)
or check out the [Enterprise Migration Guide](https://help.github.com/enterprise/admin/guides/migrations/).

{% endif %}

[migrations]: /v3/migration/migrations/
[source_imports]: /v3/migration/source_imports/
