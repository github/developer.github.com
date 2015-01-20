# -*- encoding: utf-8 -*-
require File.expand_path( '../lib/yell/version', __FILE__ )

Gem::Specification.new do |s|
  s.name        = "yell"
  s.version     = Yell::VERSION
  s.authors     = ["Rudolf Schmidt"]
  s.license     = 'MIT'

  s.homepage    = "http://rudionrails.github.com/yell"
  s.summary     = %q{Yell - Your Extensible Logging Library}
  s.description = %q{Yell - Your Extensible Logging Library. Define multiple adapters, various log level combinations or message formatting options like you've never done before}

  s.rubyforge_project = "yell"

  s.files         = `git ls-files`.split($\)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})

  s.require_paths = ["lib"]
end

