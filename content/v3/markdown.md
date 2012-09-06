---
title: Markdown Rendering | GitHub API
---

# Markdown Rendering API

* TOC
{:toc}

## Render an arbitrary Markdown document

	POST /markdown

### Input

text
: _Required_ **string** - The Markdown text to render

mode
: _Optional_ **string** - The rendering mode

	- `markdown` to render a document as plain Markdown, just like README files are rendered.
	- `gfm` to render a document as user-content, e.g. like user comments or issues are rendered. In GFM mode, hard line breaks are always taken into account, and issue and user mentions are linked accordingly.

context
: _Optional_ **string** - The repository context, only taken into account when rendering as `gfm`

<%= json \
  :text => "Hello world github/linguist#1 **cool**, and #1!",
  :mode => "gfm",
  :context => "github/gollum"
%>

### Response

<%= text_html \
	%(<p>Hello world <a href="http://github.com/github/linguist/issues/1" class="issue-link" title="This is a simple issue">github/linguist#1</a> <strong>cool</strong>, and <a href="http://github.com/github/gollum/issues/1" class="issue-link" title="This is another issue">#1</a>!</p>), 200
%>

## Render a Markdown document in raw mode

	POST /markdown/raw

### Input

The raw API is not JSON-based. It takes a Markdown document as plaintext (`text/plain` or `text/x-markdown`) and renders it as plain Markdown without a repository context (just like a README.md file is rendered -- this is the simplest way to preview a readme online).

### Response

<%= text_html \
	%(<p>Hello world github/linguist#1 <strong>cool</strong>, and #1!</p>), 200
%>
