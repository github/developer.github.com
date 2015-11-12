# -*- encoding: utf-8 -*-
# stub: nanoc 4.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "nanoc"
  s.version = "4.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Denis Defreyne"]
  s.date = "2015-11-07"
  s.description = "Nanoc is a static-site generator focused on flexibility. It transforms content from a format such as Markdown or AsciiDoc into another format, usually HTML, and lays out pages consistently to retain the site\u{2019}s look and feel throughout. Static sites built with Nanoc can be deployed to any web server."
  s.email = "denis.defreyne@stoneship.org"
  s.executables = ["nanoc"]
  s.extra_rdoc_files = ["ChangeLog", "LICENSE", "README.md", "NEWS.md"]
  s.files = ["ChangeLog", "LICENSE", "NEWS.md", "README.md", "bin/nanoc"]
  s.homepage = "http://nanoc.ws/"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--main", "README.md"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.0")
  s.rubygems_version = "2.4.5.1"
  s.summary = "A static-site generator with a focus on flexibility."

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<cri>, ["~> 2.3"])
      s.add_development_dependency(%q<bundler>, ["< 2.0", ">= 1.7.10"])
    else
      s.add_dependency(%q<cri>, ["~> 2.3"])
      s.add_dependency(%q<bundler>, ["< 2.0", ">= 1.7.10"])
    end
  else
    s.add_dependency(%q<cri>, ["~> 2.3"])
    s.add_dependency(%q<bundler>, ["< 2.0", ">= 1.7.10"])
  end
end
