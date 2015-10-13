# -*- encoding: utf-8 -*-
# stub: guard-nanoc 1.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "guard-nanoc"
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Denis Defreyne"]
  s.date = "2013-11-27"
  s.description = "Automatically rebuilds nanoc sites"
  s.email = "denis.defreyne@stoneship.org"
  s.homepage = "http://nanoc.ws/"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.3"
  s.summary = "guard gem for nanoc"

  s.installed_by_version = "2.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<guard>, [">= 1.8.0"])
      s.add_runtime_dependency(%q<nanoc>, [">= 3.6.3"])
    else
      s.add_dependency(%q<guard>, [">= 1.8.0"])
      s.add_dependency(%q<nanoc>, [">= 3.6.3"])
    end
  else
    s.add_dependency(%q<guard>, [">= 1.8.0"])
    s.add_dependency(%q<nanoc>, [">= 3.6.3"])
  end
end
