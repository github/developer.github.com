# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "yajl-ruby"
  s.version = "0.8.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brian Lopez", "Lloyd Hilaiel"]
  s.date = "2011-08-16"
  s.email = "seniorlopez@gmail.com"
  s.extensions = ["ext/yajl/extconf.rb"]
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc", "ext/yajl/extconf.rb"]
  s.homepage = "http://github.com/brianmario/yajl-ruby"
  s.require_paths = ["lib", "ext"]
  s.rubygems_version = "1.8.23"
  s.summary = "Ruby C bindings to the excellent Yajl JSON stream-based parser library."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake-compiler>, [">= 0.7.5"])
      s.add_development_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_development_dependency(%q<activesupport>, [">= 0"])
      s.add_development_dependency(%q<json>, [">= 0"])
    else
      s.add_dependency(%q<rake-compiler>, [">= 0.7.5"])
      s.add_dependency(%q<rspec>, [">= 2.0.0"])
      s.add_dependency(%q<activesupport>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake-compiler>, [">= 0.7.5"])
    s.add_dependency(%q<rspec>, [">= 2.0.0"])
    s.add_dependency(%q<activesupport>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
  end
end
