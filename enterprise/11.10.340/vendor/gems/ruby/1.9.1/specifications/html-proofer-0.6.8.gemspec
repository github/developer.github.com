# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "html-proofer"
  s.version = "0.6.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Garen Torikian"]
  s.date = "2014-05-22"
  s.description = "Test your rendered HTML files to make sure they're accurate."
  s.email = ["gjtorikian@gmail.com"]
  s.executables = ["htmlproof"]
  s.files = ["bin/htmlproof"]
  s.homepage = "https://github.com/gjtorikian/html-proofer"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "A set of tests to validate your HTML output. These tests check if your image references are legitimate, if they have alt tags, if your internal links are working, and so on. It's intended to be an all-in-one checker for your documentation output."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mercenary>, ["~> 0.3.2"])
      s.add_runtime_dependency(%q<nokogiri>, ["~> 1.6.0"])
      s.add_runtime_dependency(%q<colored>, ["~> 1.2"])
      s.add_runtime_dependency(%q<typhoeus>, ["~> 0.6.7"])
      s.add_runtime_dependency(%q<yell>, ["~> 2.0"])
      s.add_development_dependency(%q<html-pipeline>, ["~> 1.8"])
      s.add_development_dependency(%q<escape_utils>, ["~> 1.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.13.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
    else
      s.add_dependency(%q<mercenary>, ["~> 0.3.2"])
      s.add_dependency(%q<nokogiri>, ["~> 1.6.0"])
      s.add_dependency(%q<colored>, ["~> 1.2"])
      s.add_dependency(%q<typhoeus>, ["~> 0.6.7"])
      s.add_dependency(%q<yell>, ["~> 2.0"])
      s.add_dependency(%q<html-pipeline>, ["~> 1.8"])
      s.add_dependency(%q<escape_utils>, ["~> 1.0"])
      s.add_dependency(%q<rspec>, ["~> 2.13.0"])
      s.add_dependency(%q<rake>, [">= 0"])
    end
  else
    s.add_dependency(%q<mercenary>, ["~> 0.3.2"])
    s.add_dependency(%q<nokogiri>, ["~> 1.6.0"])
    s.add_dependency(%q<colored>, ["~> 1.2"])
    s.add_dependency(%q<typhoeus>, ["~> 0.6.7"])
    s.add_dependency(%q<yell>, ["~> 2.0"])
    s.add_dependency(%q<html-pipeline>, ["~> 1.8"])
    s.add_dependency(%q<escape_utils>, ["~> 1.0"])
    s.add_dependency(%q<rspec>, ["~> 2.13.0"])
    s.add_dependency(%q<rake>, [">= 0"])
  end
end
