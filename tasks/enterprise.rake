require 'nokogiri'

def setup
  `git checkout gh-pages`
  `git pull origin gh-pages`

  `git checkout -b #{BRANCH_NAME}`
end

# we need to point links not to the root, but to the enterprise version root
# for assets and links
def rewrite_content(path)
  Dir.glob("#{path}/**/*.html") do |html_file|
    doc = Nokogiri::HTML(File.read(html_file))

    # add '.enterprise' to `@class` in `body`
    body = doc.search('body').first
    unless body.nil?
      classes = body.get_attribute('class').to_s.split(' ')
      body.set_attribute('class', classes.push('enterprise').uniq.join(' '))
    end

    doc.css('a').each do |a|
      a['href'] = "/enterprise/#{VERSION}#{a['href']}" if a['href'] =~ /^\//
    end

    doc.css('link').each do |link|
      link['href'] = "/enterprise/#{VERSION}#{link['href']}" if link['href'] =~ /^\//
    end

    doc.css('script').each do |script|
      script['src'] = "/enterprise/#{VERSION}#{script['src']}" if script['src'] =~ /^\//
    end

    doc.css('img').each do |img|
      img['src'] = "/enterprise/#{VERSION}#{img['src']}" if img['src'] =~ /^\//
    end

    doc.search('//*[@class="not-enterprise"]').remove
    File.open(html_file, 'w') { |file| file.write(doc.to_html) }
  end

  Dir.glob("#{path}/**/*.css") do |css_file|
    contents = File.read(css_file)
    contents.gsub!(/url\(\/shared/, "url(/enterprise/#{VERSION}/shared")
    File.open(css_file, 'w') { |file| file.write(contents) }
  end
end