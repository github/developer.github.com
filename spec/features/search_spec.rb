require 'spec_helper'
require 'json'

describe 'Search JSON' do
  it 'has valid search URLs' do
    Dir.glob('output/search/search-index.json').each do |search_json_path|
      json = JSON.parse(File.read(search_json_path))
      urls = json.map { |e| "output#{e['url']}/index.html" }
      missing_files = urls.select { |u| !File.exist?(u) }
      unless missing_files.empty?
        fail "Found links in #{search_json_path} search to articles that don't exist. That means that the search is potentially broken!\n\nThe following files couldn't be found: #{missing_files.join("\n")}"
      end
    end
  end
end
