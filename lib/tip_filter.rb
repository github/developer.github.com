class TipFilter < Nanoc::Filter
  identifier :tip_filter
  type :text

  def run(content, params={})
    content = content.gsub(/<p>\{\{#(tip|warning|error)}}<\/p>/,  '<div class="alert \1">')
    content.gsub(/<p>\{\{\/(tip|warning|error)}}<\/p>/, '</div>')
  end
end
