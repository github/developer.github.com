# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "adsf"
  s.version = "1.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Denis Defreyne"]
  s.date = "2013-11-29"
  s.description = "A web server that can be spawned in any directory"
  s.email = "denis.defreyne@stoneship.org"
  s.executables = ["adsf"]
  s.files = ["bin/adsf"]
  s.homepage = "http://github.com/ddfreyne/adsf/"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.5")
  s.rubygems_version = "1.8.23"
  s.summary = "a tiny static file server"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rack>, [">= 1.0.0"])
    else
      s.add_dependency(%q<rack>, [">= 1.0.0"])
    end
  else
    s.add_dependency(%q<rack>, [">= 1.0.0"])
  end
end
