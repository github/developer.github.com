require 'json'
require 'nokogiri'

class SearchFilter < Nanoc::Filter
  identifier :search
  type :text

  $search_file_path = File.join(Dir.pwd, "static", "search-index.json")
  $search_file_contents = { :pages => [] }
  
  sidebar = File.open(File.join(Dir.pwd, "layouts", "sidebar.html"))
  $sidebar_doc = Nokogiri::HTML(sidebar)
  sidebar.close

  def run(content, params={})
    # uses nokogiri to determine parent section name
    containing_li_text = $sidebar_doc.xpath("//a[@href='#{@item.identifier}']/../../../h3/a[2]/text()")

    # we're looking at an overview page
    containing_li_text = $sidebar_doc.xpath("//a[@href='#{@item.identifier}']/text()") if containing_li_text.empty?

    page = { :url => @item.identifier, :title => @item[:title].split("|")[0].strip, :section => "API/#{containing_li_text}" }

    $search_file_contents[:pages] << page
    $search_file_contents[:pages] = merge_sort($search_file_contents[:pages])

    write_search_file

    content
  end

  def write_search_file
    begin
      File.open($search_file_path, 'w') {|f| f.write(JSON.pretty_generate($search_file_contents)) }
    rescue
      puts 'WARNING: cannot write search file.'
    end
  end

  private

  # basically we need a merge sort for elements like "/v3/orgs." Otherwise,
  # nanoc puts "/v3/orgs/members" before "/v3/orgs." Children should respect their
  # parents, yo.
  def merge_sort(a)
      return a if a.size <= 1
      l, r = split_array(a)
      result = combine(merge_sort(l), merge_sort(r))
  end
   
  def split_array(a)
    mid = (a.size / 2).round
    [a.take(mid), a.drop(mid)]
  end
   
  def combine(a, b)
    return b.empty? ? a : b if a.empty? || b.empty?
    smallest = a.first[:url] <= b.first[:url] ? a.shift : b.shift
    combine(a, b).unshift(smallest)
  end
end
