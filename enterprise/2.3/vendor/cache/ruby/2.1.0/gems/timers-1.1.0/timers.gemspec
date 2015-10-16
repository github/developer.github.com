# -*- encoding: utf-8 -*-
require File.expand_path('../lib/timers/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tony Arcieri"]
  gem.email         = ["tony.arcieri@gmail.com"]
  gem.description   = "Pure Ruby one-shot and periodic timers"
  gem.summary       = "Schedule procs to run after a certain time, or at periodic intervals, using any API that accepts a timeout"
  gem.homepage      = "https://github.com/tarcieri/timers"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "timers"
  gem.require_paths = ["lib"]
  gem.version       = Timers::VERSION

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
end
