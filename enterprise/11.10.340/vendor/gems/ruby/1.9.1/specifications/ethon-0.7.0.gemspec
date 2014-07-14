# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "ethon"
  s.version = "0.7.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.6") if s.respond_to? :required_rubygems_version=
  s.authors = ["Hans Hasselberg"]
  s.date = "2014-03-19"
  s.description = "Very lightweight libcurl wrapper."
  s.email = ["me@hans.io"]
  s.homepage = "https://github.com/typhoeus/ethon"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Libcurl wrapper."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ffi>, [">= 1.3.0"])
    else
      s.add_dependency(%q<ffi>, [">= 1.3.0"])
    end
  else
    s.add_dependency(%q<ffi>, [">= 1.3.0"])
  end
end
