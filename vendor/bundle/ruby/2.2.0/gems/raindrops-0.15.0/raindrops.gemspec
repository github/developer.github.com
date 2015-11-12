# -*- encoding: binary -*-
ENV["VERSION"] or abort "VERSION= must be specified"
manifest = File.readlines('.manifest').map! { |x| x.chomp! }
test_files = manifest.grep(%r{\Atest/test_.*\.rb\z})
require 'olddoc'
extend Olddoc::Gemspec
name, summary, title = readme_metadata

Gem::Specification.new do |s|
  s.name = %q{raindrops}
  s.version = ENV["VERSION"].dup

  s.authors = ["raindrops hackers"]
  s.description = readme_description
  s.email = %q{raindrops@bogomips.org}
  s.extensions = %w(ext/raindrops/extconf.rb)
  s.extra_rdoc_files = extra_rdoc_files(manifest)
  s.files = manifest
  s.homepage = Olddoc.config['rdoc_url']
  s.summary = summary
  s.test_files = test_files
  s.add_development_dependency('aggregate', '~> 0.2')
  s.add_development_dependency('test-unit', '~> 3.0')
  s.add_development_dependency('io-extra', [ '~> 1.2', '>= 1.2.3'])
  s.add_development_dependency('posix_mq', '~> 2.0')
  s.add_development_dependency('rack', '~> 1.2')
  s.add_development_dependency('unicorn', '>= 0.98')
  s.add_development_dependency('olddoc', '~> 1.0')

  s.licenses = %w(LGPL-2.1+)
end
