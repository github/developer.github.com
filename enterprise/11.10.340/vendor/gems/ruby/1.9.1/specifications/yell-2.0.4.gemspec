# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "yell"
  s.version = "2.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Rudolf Schmidt"]
  s.date = "2014-03-20"
  s.description = "Yell - Your Extensible Logging Library. Define multiple adapters, various log level combinations or message formatting options like you've never done before"
  s.homepage = "http://rudionrails.github.com/yell"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "yell"
  s.rubygems_version = "1.8.23"
  s.summary = "Yell - Your Extensible Logging Library"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
