class EnterpriseOnlyFilter < Nanoc::Filter
  identifier :enterprise_only_filter
  type :text

  ENTERPRISE_START_STRING = '{{#enterprise-only}}'
  ENTERPRISE_END_STRING = '{{/enterprise-only}}'

  # if we're running in Dotcom mode, we'll be lazy and just hide the content.
  # otherwise, when running script/enterprise-cutter, we'll bring these sections back
  def run(content, params={})
    start_replacement = '<div class="enterprise-only">'
    end_replacement = '</div>'

    content = content.gsub(%r{<p>#{ENTERPRISE_START_STRING}</p>}, start_replacement)
    content = content.gsub(%r{<p>#{ENTERPRISE_END_STRING}</p>}, end_replacement)

    content
  end
end
