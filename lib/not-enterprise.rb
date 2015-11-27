class NotEnterpriseFilter < Nanoc::Filter
  identifier :not_enterprise_filter
  type :text

  ENTERPRISE_START_STRING = '{{#not-enterprise}}'
  ENTERPRISE_END_STRING = '{{/not-enterprise}}'

  # if we're running in Dotcom mode, we'll be lazy and just hide the content.
  # otherwise, when running script/enterprise-cutter, we'll bring these sections back
  def run(content, params={})
    start_replacement = '<div class="not-enterprise">'
    end_replacement = '</div>'

    content = content.gsub(%r{<p>#{ENTERPRISE_START_STRING}</p>}, start_replacement)
    content = content.gsub(%r{<p>#{ENTERPRISE_END_STRING}</p>}, end_replacement)

    content
  end
end
