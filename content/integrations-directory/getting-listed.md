---
title: Getting listed in the Integrations Directory | GitHub API
---

# Getting your integration listed

* TOC
{:toc}

## Listing requirements

### Provide the right contacts

We want to be sure GitHub can contact your team, if needed. Specifically, we're asking for:

* A technical support contact
* A security contact
* An escalation contact

All three are for GitHub-use only. If there's an urgent issue that needs your attention, we'll contact your escalation contact and expect a response within one business day. A delayed response from your escalation contact may result in temporary or permanent de-listing of your integration from the directory.

### Provide standard links

We'd like to have a minimum set of links to include in every integration listing, so that our users have all the information they need. These are:

- Documentation - Please provide a URL with more information on how to use your integration.
- Terms of service - Please provide the Terms of Service URL for users using your integration.
- Privacy Policy - If different than Terms of Service, please include the URL here.
- Support - Please provide a URL or email address for users to contact you directly.
- Status - You should provide us a URL that will be updated when your application is down or experiencing problems. This could be a status site, a blog, a Twitter account, or more. This URL should be publicly accessible.
- Pricing - If your integration costs money or has differed priced tiers of service, please include this URL.
- Installation - Provide the URL for direct installation for users. Note the OAuth requirement below.

### Provide updates to your listing

We want GitHub users to have consistent messaging within the Integrations Directory and your
marketing site. As your product changes, keep your Integration Directory listing up to date. We ask that you refresh the information at least once a year. Please send updates to [partnerships@github.com](mailto:partnerships@github.com).

### Provide categories for your listing

Help GitHub users find your integration faster with the appropriate categories. Please send us your suggested categories for the listing. We reserve the right to remove categories from a listing, but we won't add any categories without your approval. Currently, the following categories are available:

* Build
* Collaborate
* Deploy

## Technical requirements

### Use TLS

Anytime you display GitHub data in your integration, use TLS. If you also use [webhooks](https://developer.github.com/webhooks/) to receive updated data from GitHub, use SSL/TLS there too.

### Delete GitHub data once you lose access to the information

Once you realize you've lost access to a user, organization, repository, or its related objects,
delete that information in your system within 60 days.

## Choose your type of listing

We offer two types of listings: OAuth installation listings and "learn more" listings.

### OAuth installation listing

{{#tip}}

This is our preferred type of listing wherever possible.

{{/tip}}

The OAuth installation listings are used so customers can immediately install your integration directly
within GitHub's UI. To use this type of listing, provide a URL that will immediately redirect to
GitHub's OAuth authorization flow.

We are happy to help you identify if your integration can already support this. If you'd like a direct installation from the Integrations Directory, your provided installation URL should always forward the user immediately to an OAuth authorization screen. You should never add interstitial pages within that flow.

### "Learn more" listing

The "learn more" listing is used when a user cannot use GitHub OAuth to sign up for an account within
your integration. You will provide a URL that will link a "learn more" button within your
listing to your website. This type of listing is *only used when OAuth is not available before
account creation*.

## Send us your information

In addition to this checklist, please follow the [Marketing Guidelines](/integrations-directory/marketing-guidelines/) as well.  The best format for delivery is Markdown (.md) or plain text (.txt).

Please attach images at the proper resolution. We aren't able to extract photos from PDFs or Word docs.

Once you're ready, just send the materials over email to [partnerships@github.com](mailto:partnerships@github.com). Thanks! We're looking forward to reviewing your listing.
