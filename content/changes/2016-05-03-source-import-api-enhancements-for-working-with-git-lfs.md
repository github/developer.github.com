---
title: Source Import API enhancements for working with Git LFS
author_name: lizzhale
---

Today we're introducing enhancements to the [Source Import API][docs] to support importing repositories with files larger than 100MB.

**Changes to parameters for starting an import**

[Starting an import][start-an-import] no longer requires a `vcs` parameter. Please be aware that without this parameter, the import job will take additional time to detect the vcs type before beginning the import. This detection step will be reflected in the response.

**New methods**

We've added 3 new methods that will enable API consumers to:

  * [update][update-existing-import] the authentication or project choice for an import. If no parameters are provided during the request, the import will be restarted. Please note that this is a **breaking change**. Updating authentication for the originating URL is no longer supported through the [start an import][start-an-import] method. Please update your applications to use the new method.

  * [set their preference][set-git-lfs-preference] for using Git LFS to import files larger than 100MB.

  * [list all the files larger than 100MB][get-large-files] that were found during the import.

**New attributes for Git LFS**

Several new response attributes (`use_lfs`, `has_large_files`, `large_files_size`, `large_files`) were added to provide details regarding the large files found during the import. You can read more about the attributes [here][git-lfs-related-fields].

As before, to access the API during the preview period, you must provide a custom [media type][media-type] in the `Accept` header:

    application/vnd.github.barred-rock-preview

For more information, see the [Source Import API documentation][docs], and if you have any questions or feedback, please [let us know][contact].


[docs]: /v3/migration/source_imports/
[start-an-import]: /v3/migration/source_imports/#start-an-import
[update-existing-import]: /v3/migration/source_imports/#update-existing-import
[set-git-lfs-preference]: /v3/migration/source_imports/#set-git-lfs-preference
[get-large-files]: /v3/migration/source_imports/#get-large-files
[git-lfs-related-fields]: /v3/migration/source_imports/#git-lfs-related-fields
[media-type]: /v3/media
[contact]: https://github.com/contact?form%5Bsubject%5D=Source+Import+API
