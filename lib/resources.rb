require 'pp'
require 'stringio'
require 'cgi'
require 'securerandom'
require 'json'

Dir[File.join(File.dirname(__FILE__), 'lib', 'responses', '*.rb')].each { |file| load file }

module GitHub
  module Resources
    module Helpers

      STATUSES ||= {
        200 => '200 OK',
        201 => '201 Created',
        202 => '202 Accepted',
        204 => '204 No Content',
        205 => '205 Reset Content',
        301 => '301 Moved Permanently',
        302 => '302 Found',
        307 => '307 Temporary Redirect',
        304 => '304 Not Modified',
        401 => '401 Unauthorized',
        403 => '403 Forbidden',
        404 => '404 Not Found',
        405 => '405 Method not allowed',
        409 => '409 Conflict',
        422 => '422 Unprocessable Entity',
        500 => '500 Server Error',
        502 => '502 Bad Gateway'
      }

      DefaultTimeFormat ||= "%B %-d, %Y".freeze

      def post_date(item)
        strftime item[:created_at]
      end

      def strftime(time, format = DefaultTimeFormat)
        return "" if time.nil?
        attribute_to_time(time).strftime(format)
      end

      def avatar_for(login)
        %(<img height="16" width="16" src="%s" alt="Avatar for #{login}" data-proofer-ignore/>) % avatar_url_for(login)
      end

      def avatar_url_for(login)
        "https://github.com/#{login}.png"
      end

      def headers(status, head = {})
        lines = ["Status: #{STATUSES[status]}"]
        head.each do |key, value|
          case key
            when :pagination
              lines << link_header(value)
            else
              lines << "#{key}: #{value}"
          end
        end

        lines << "X-RateLimit-Limit: 5000" unless head.has_key?('X-RateLimit-Limit')
        lines << "X-RateLimit-Remaining: 4999" unless head.has_key?('X-RateLimit-Remaining')

        %(``` headers\n#{lines.join("\n")}\n```\n)
      end

      def link_header(rels)
        formatted_rels = rels.map { |name, url| link_header_rel(name, url) }

        lines = ["Link: #{formatted_rels.shift}"]
        while formatted_rels.any?
          lines.last << ","
          lines << "      #{formatted_rels.shift}"
        end

        lines
      end

      def link_header_rel(name, url)
        %Q{<#{url}>; rel="#{name}"}
      end

      def default_pagination_rels
        {
          :next => "https://api.github.com/resource?page=2",
          :last => "https://api.github.com/resource?page=5"
        }
      end

      def json(key)
        hash = get_resource(key)
        hash = yield hash if block_given?

        "``` json\n" + JSON.pretty_generate(hash) + "\n```\n"
      end

      def get_resource(key)
        hash = case key
          when Hash
            h = {}
            key.each { |k, v| h[k.to_s] = v }
            h
          when Array
            key
          else Resources.const_get("GitHub::Resources::Responses::#{key.to_s.upcase}")
        end
      end

      def text_html(response, status, head = {})
        hs = headers(status, head.merge('Content-Type' => 'text/html'))
        res = CGI.escapeHTML(response)
        hs + %(<pre class="body-response"><code>) + res + "</code></pre>"
      end

      def webhook_headers(event_name)
        "<pre><code>" + File.read("lib/webhooks/#{event_name}.headers.txt") + "</code></pre>"
      end

      def webhook_payload(event_name)
        "``` json\n" + File.read("lib/webhooks/#{event_name}.payload.json") + "```"
      end

      CONTENT ||= {
        'IF_SITE_ADMIN' => "If you are an [authenticated](/v3/#authentication) site administrator for your Enterprise instance,",
        "PUT_CONTENT_LENGTH" => "Note that you'll need to set `Content-Length` to zero when calling out to this endpoint. For more information, see \"[HTTP verbs](/v3/#http-verbs).\"",
        "OPTIONAL_PUT_CONTENT_LENGTH" => "Note that, if you choose not to pass any parameters, you'll need to set `Content-Length` to zero when calling out to this endpoint. For more information, see \"[HTTP verbs](/v3/#http-verbs).\"",
        "ORG_HOOK_CONFIG_HASH" =>
        '''
Name | Type | Description
-----|------|--------------
`url`          | `string` | **Required** The URL to which the payloads will be delivered.
`content_type` | `string` | The media type used to serialize the payloads. Supported values include `json` and `form`. The default is `form`.
`secret`       | `string` | If provided, payloads will be delivered with an `X-Hub-Signature` header. The value of this header is computed as the [HMAC hex digest of the body, using the `secret` as the key][hub-signature].
`insecure_ssl` | `string` | Determines whether the SSL certificate of the host for `url` will be verified when delivering payloads. Supported values include `"0"` (verification is performed) and `"1"` (verification is not performed). The default is `"0"`. **We strongly recommend not setting this to "1" as you are subject to man-in-the-middle and other attacks.**
''',
      "PRS_AS_ISSUES" =>
      '''
{{#tip}}

**Note**: In the past, pull requests and issues were more closely aligned than they are now. As far as the API is concerned, every pull request is an issue, but not every issue is a pull request.

This endpoint may also return pull requests in the response. If an issue *is* a pull request, the object will include a `pull_request` key.

{{/tip}}
'''
      }

      def fetch_content(key)
        CONTENT[key.to_s.upcase]
      end

    end
  end
end

include GitHub::Resources::Helpers
