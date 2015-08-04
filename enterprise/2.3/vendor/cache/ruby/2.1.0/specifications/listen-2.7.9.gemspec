# -*- encoding: utf-8 -*-
# stub: listen 2.7.9 ruby lib

Gem::Specification.new do |s|
  s.name = "listen"
  s.version = "2.7.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Thibaud Guillaume-Gentil"]
  s.date = "2014-06-20"
  s.description = "The Listen gem listens to file modifications and notifies you about the changes. Works everywhere!"
  s.email = "thibaud@thibaud.gg"
  s.executables = ["listen"]
  s.files = ["bin/listen"]
  s.homepage = "https://github.com/guard/listen"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.3")
  s.rubygems_version = "2.2.3"
  s.summary = "Listen to file modifications"

  s.installed_by_version = "2.2.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<celluloid>, [">= 0.15.2"])
      s.add_runtime_dependency(%q<rb-fsevent>, [">= 0.9.3"])
      s.add_runtime_dependency(%q<rb-inotify>, [">= 0.9"])
      s.add_development_dependency(%q<bundler>, [">= 1.3.5"])
      s.add_development_dependency(%q<celluloid-io>, [">= 0.15.0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0.0rc1"])
      s.add_development_dependency(%q<rspec-retry>, [">= 0"])
    else
      s.add_dependency(%q<celluloid>, [">= 0.15.2"])
      s.add_dependency(%q<rb-fsevent>, [">= 0.9.3"])
      s.add_dependency(%q<rb-inotify>, [">= 0.9"])
      s.add_dependency(%q<bundler>, [">= 1.3.5"])
      s.add_dependency(%q<celluloid-io>, [">= 0.15.0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 3.0.0rc1"])
      s.add_dependency(%q<rspec-retry>, [">= 0"])
    end
  else
    s.add_dependency(%q<celluloid>, [">= 0.15.2"])
    s.add_dependency(%q<rb-fsevent>, [">= 0.9.3"])
    s.add_dependency(%q<rb-inotify>, [">= 0.9"])
    s.add_dependency(%q<bundler>, [">= 1.3.5"])
    s.add_dependency(%q<celluloid-io>, [">= 0.15.0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 3.0.0rc1"])
    s.add_dependency(%q<rspec-retry>, [">= 0"])
  end
end
