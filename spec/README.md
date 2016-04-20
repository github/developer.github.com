### What's in the *spec* folder?

This folder contains (almost) our entire test suite. We split these tests into different subfolders in this directory.

In addition, we use [HTML-Proofer](https://github.com/gjtorikian/html-proofer) to validate our built site. More on this below.

The tests in this directory include:

* The *content* folder contains tests which are run over our Markdown and YAML files before they are built. These tests include:
  * Ensuring that reusables are written correctly.
  * Ensuring that there are no Liquid errors.
  * Ensuring that there are no search errors.
* The *features* folder contains tests that deal with how the site functions. These tests include:
  * Whether the search links are valid.
  * Whether the sidebar is working.
  * Whether redirects are working.

There are two more types of tests that are controlled by HTML-Proofer:

* HTML-Proofer validates that our *internal* content is working. That means that internal links are working, our images have alt tags, etc.
* HTML-Proofer also validates our *external* content. That means URLs to external websites, external images, etc.
