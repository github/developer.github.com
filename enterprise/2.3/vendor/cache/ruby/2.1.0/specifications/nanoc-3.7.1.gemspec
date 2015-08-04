# -*- encoding: utf-8 -*-
# stub: nanoc 3.7.1 ruby lib

Gem::Specification.new do |s|
  s.name = "nanoc"
  s.version = "3.7.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Denis Defreyne"]
  s.date = "2014-06-16"
  s.description = "nanoc is a simple but very flexible static site generator written in Ruby. It operates on local files, and therefore does not run on the server. nanoc \u{201c}compiles\u{201d} the local source files into HTML (usually), by evaluating eRuby, Markdown, etc."
  s.email = "denis.defreyne@stoneship.org"
  s.executables = ["nanoc"]
  s.extra_rdoc_files = ["ChangeLog", "LICENSE", "README.md", "NEWS.md"]
  s.files = ["ChangeLog", "LICENSE", "NEWS.md", "README.md", "bin/nanoc"]
  s.homepage = "http://nanoc.ws/"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--main", "README.md"]
  s.rubygems_version = "2.2.3"
  s.summary = "a web publishing system written in Ruby for building small to medium-sized websites."

  s.installed_by_version = "2.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<cri>, ["~> 2.3"])
      s.add_development_dependency(%q<bundler>, ["~> 1.5"])
    else
      s.add_dependency(%q<cri>, ["~> 2.3"])
      s.add_dependency(%q<bundler>, ["~> 1.5"])
    end
  else
    s.add_dependency(%q<cri>, ["~> 2.3"])
    s.add_dependency(%q<bundler>, ["~> 1.5"])
  end
end
