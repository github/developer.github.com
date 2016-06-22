require 'nokogiri'

begin
  require 'awesome_print'
rescue LoadError; end

CURR_VERSION ||= ARGV[0].to_f
VERSIONED_ENT_PATH ||= "enterprise/#{CURR_VERSION}"
S3_PATH ||= "https://github-images.s3.amazonaws.com/enterprise/developer-site/#{CURR_VERSION}"

ASSETS_PATH_REGEX = %r{^/assets/}
IMAGES_PATH_REGEX = %r{^/assets/images}

def start_message
  if CURR_VERSION == 0.0
    puts <<-eos

*********************

No valid version number given. Run this script as `#{$PROGRAM_NAME} <enterprise_version_number>`

*********************

    eos
    exit 1
  elsif !config[:versions].include?(CURR_VERSION)
    puts <<-eos

*********************

#{CURR_VERSION} does not exist in #{config[:versions]} ...

*********************

    eos
    exit 1
  else
    puts <<-eos

*********************

Building #{$PROGRAM_NAME} for #{CURR_VERSION} ...

*********************

    eos
  end
end

def prepare
  `bundle exec rake remove_tmp_dir`
  `bundle exec rake remove_output_dir`
  FileUtils.mkdir_p "enterprise/#{CURR_VERSION}"
  FileUtils.rm_rf "enterprise/#{CURR_VERSION}/assets"
end

def copy_to_destination
  source = Dir['output/*']
  FileUtils.cp_r source, VERSIONED_ENT_PATH
end

# Rewrite local asset paths to their S3 counterparts
def rewrite_asset_paths(doc)
  doc.css('img').each do |img|
    next unless img['src'] =~ IMAGES_PATH_REGEX
    img['src'] = "#{S3_PATH}#{img['src']}"
  end

  doc.css('link').each do |link|
    if link['href'] =~ IMAGES_PATH_REGEX # the favicon
      link['href'] = "#{S3_PATH}#{link['href']}"
    elsif link['href'] =~ ASSETS_PATH_REGEX # stylesheets
      link['href'] = "/enterprise/#{CURR_VERSION}#{link['href']}"
    elsif link['rel'] == 'canonical' && link['href'] =~ %r{^/} # 301 redirects
      link['href'] = "/#{VERSIONED_ENT_PATH}#{link['href']}"
    end
  end

  doc.css('script').each do |script|
    if script['src'] =~ ASSETS_PATH_REGEX
      script['src'] = "/enterprise/#{CURR_VERSION}#{script['src']}"
    elsif script.content =~ /^location=/
      script.content = script.content.sub("'/", "'/#{VERSIONED_ENT_PATH}/")
    end
  end

  doc.css('meta').each do |meta|
    next unless meta['http-equiv'] == 'refresh'
    meta['content'] = meta['content'].sub('=/', "=/#{VERSIONED_ENT_PATH}/")
  end

  doc
end

# Rewrite local URL paths to their versioned counterparts
def rewrite_anchors(doc)
  doc.css('a').each do |a|
    next if a[:'skip-conversion']
    next if a['href'] =~ %r{^/changes} # do not rewrite blog links
    next if a['href'] =~ %r{^/enterprise} # do not rewrite Enterprise links
    a['href'] = "/enterprise/#{CURR_VERSION}#{a['href']}" if a['href'] =~ %r{^/}
  end
  doc
end

# remove excess whitespace
def rewrite_whitespace(html)
  html.lines.map { |l| l.gsub(/\A\s*\z/, '') }.join('')
end

def rewrite_octicons_path(css_path)
  css = File.read(css_path)
  css = css.gsub('/assets/vendor/octicons/octicons', "#{S3_PATH}/assets/vendor/octicons/octicons")
  File.write(css_path, css)
end

def git_porcelain_path(path)
  `git status --porcelain | grep #{path}`.chomp.split(' ')[1]
end

def cleanup
  # we do not need these files
  %w(404.html sitemap.xml CNAME robots.txt).each do |file|
    path = git_porcelain_path(file)
    `rm -rf #{path}`
  end
  FileUtils.rm_rf "#{VERSIONED_ENT_PATH}/assets/images"
  FileUtils.rm_rf "#{VERSIONED_ENT_PATH}/integrations-directory"
  FileUtils.rm_rf "#{VERSIONED_ENT_PATH}/changes"
  FileUtils.rm_rf "#{VERSIONED_ENT_PATH}/changes.atom"
  FileUtils.rm_rf "#{VERSIONED_ENT_PATH}/assets/vendor"
  FileUtils.rm_rf "#{VERSIONED_ENT_PATH}/assets/images"
end
