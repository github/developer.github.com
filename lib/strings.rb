require 'active_support/core_ext/string'

module GitHub
  module Strings
    # taken from Liquid: http://git.io/vBNqH
    def strip_html(str)
      str.to_s.gsub(%r{<script.*?</script>}m, '') \
              .gsub(/<!--.*?-->/m, '') \
              .gsub(%r{<style.*?</style>}m, '') \
              .gsub(/<.*?>/m, '')
    end

    # taken from Rails: http://git.io/vBNcY
    def squish(str)
      str.gsub(/[[:space:]]+/, ' ').strip
    end

    def escape_quoted_characters(str)
      str.gsub('\\', '\\\\\\').gsub('"', '\"')
    end

    def clean_for_json(str)
      strip_html(squish(escape_quoted_characters(str)))
    end
  end
end

include GitHub::Strings
