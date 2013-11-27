require 'json'

class SearchFilter < Nanoc::Filter
  identifier :search
  type :text

  $search_file_path = File.join(Dir.pwd, "static", "search-index.json")
  $search_file_contents = { :pages => [] }

  def initialize(hash = {})
    super
  end

  def run(content, params={})
    page = { :url => @item.identifier, :title => @item[:title].split("|")[0].strip, :section => "API" }

    $search_file_contents[:pages] << page

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
end
