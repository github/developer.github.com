# -*- encoding: utf-8 -*-
# stub: mercenary 0.3.3 ruby lib

Gem::Specification.new do |s|
  s.name = "mercenary"
  s.version = "0.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Tom Preston-Werner", "Parker Moore"]
  s.date = "2014-05-07"
  s.description = "Lightweight and flexible library for writing command-line apps in Ruby."
  s.email = ["tom@mojombo.com", "parkrmoore@gmail.com"]
  s.homepage = "https://github.com/jekyll/mercenary"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.3"
  s.summary = "Lightweight and flexible library for writing command-line apps in Ruby."

  s.installed_by_version = "2.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.14"])
    else
      s.add_dependency(%q<bundler>, ["~> 1.3"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.14"])
    end
  else
    s.add_dependency(%q<bundler>, ["~> 1.3"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.14"])
  end
end
