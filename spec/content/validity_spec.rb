require 'spec_helper'

describe 'Validity' do
  it 'has no Liquid errors' do
    failed_files = []
    Dir.glob('output/**/*.html').each do |html_path|
      html = File.read(html_path)
      failed_files.push(html_path) if html =~ /Liquid error/
    end
    unless failed_files.empty?
      fail "Found files with broken Liquid syntax!\n\nThe following files are broken:\n #{failed_files.join("\n")}"
    end
  end

  it 'has no unresolved conrefs' do
    failed_files = []
    Dir.glob('output/**/*.html').each do |html_path|
      html = File.read(html_path)
      failed_files.push(html_path) if html =~ /{{ site.data/
    end
    unless failed_files.empty?
      fail "Found #{failed_files.length} files with unresolved conrefs! These are conrefs that still say `{{ site.data` in the output.\n\nThe following files are not resolving: #{failed_files.join("\n")}"
    end
  end

  it 'has a working search' do
    output = `jsonlint output/search/search-index.json`
    fail output unless output.empty?
  end
end
