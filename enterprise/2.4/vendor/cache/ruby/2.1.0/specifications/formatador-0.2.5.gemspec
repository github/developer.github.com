# -*- encoding: utf-8 -*-
# stub: formatador 0.2.5 ruby lib

Gem::Specification.new do |s|
  s.name = "formatador"
  s.version = "0.2.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["geemus (Wesley Beary)"]
  s.date = "2014-05-23"
  s.description = "STDOUT text formatting"
  s.email = "geemus@gmail.com"
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc"]
  s.homepage = "http://github.com/geemus/formatador"
  s.rdoc_options = ["--charset=UTF-8"]
  s.rubyforge_project = "formatador"
  s.rubygems_version = "2.2.3"
  s.summary = "Ruby STDOUT text formatting"

  s.installed_by_version = "2.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<shindo>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<shindo>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<shindo>, [">= 0"])
  end
end
