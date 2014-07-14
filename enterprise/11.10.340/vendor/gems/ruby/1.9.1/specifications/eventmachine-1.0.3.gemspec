# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "eventmachine"
  s.version = "1.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Francis Cianfrocca", "Aman Gupta"]
  s.date = "2013-03-08"
  s.description = "EventMachine implements a fast, single-threaded engine for arbitrary network\ncommunications. It's extremely easy to use in Ruby. EventMachine wraps all\ninteractions with IP sockets, allowing programs to concentrate on the\nimplementation of network protocols. It can be used to create both network\nservers and clients. To create a server or client, a Ruby program only needs\nto specify the IP address and port, and provide a Module that implements the\ncommunications protocol. Implementations of several standard network protocols\nare provided with the package, primarily to serve as examples. The real goal\nof EventMachine is to enable programs to easily interface with other programs\nusing TCP/IP, especially if custom protocols are required."
  s.email = ["garbagecat10@gmail.com", "aman@tmm1.net"]
  s.extensions = ["ext/extconf.rb", "ext/fastfilereader/extconf.rb"]
  s.extra_rdoc_files = ["README.md", "docs/DocumentationGuidesIndex.md", "docs/GettingStarted.md", "docs/old/ChangeLog", "docs/old/DEFERRABLES", "docs/old/EPOLL", "docs/old/INSTALL", "docs/old/KEYBOARD", "docs/old/LEGAL", "docs/old/LIGHTWEIGHT_CONCURRENCY", "docs/old/PURE_RUBY", "docs/old/RELEASE_NOTES", "docs/old/SMTP", "docs/old/SPAWNED_PROCESSES", "docs/old/TODO"]
  s.files = ["README.md", "docs/DocumentationGuidesIndex.md", "docs/GettingStarted.md", "docs/old/ChangeLog", "docs/old/DEFERRABLES", "docs/old/EPOLL", "docs/old/INSTALL", "docs/old/KEYBOARD", "docs/old/LEGAL", "docs/old/LIGHTWEIGHT_CONCURRENCY", "docs/old/PURE_RUBY", "docs/old/RELEASE_NOTES", "docs/old/SMTP", "docs/old/SPAWNED_PROCESSES", "docs/old/TODO", "ext/extconf.rb", "ext/fastfilereader/extconf.rb"]
  s.homepage = "http://rubyeventmachine.com"
  s.rdoc_options = ["--title", "EventMachine", "--main", "README.md", "-x", "lib/em/version", "-x", "lib/jeventmachine"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "eventmachine"
  s.rubygems_version = "1.8.23"
  s.summary = "Ruby/EventMachine library"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake-compiler>, ["~> 0.8.3"])
      s.add_development_dependency(%q<yard>, [">= 0.8.5.2"])
      s.add_development_dependency(%q<bluecloth>, [">= 0"])
    else
      s.add_dependency(%q<rake-compiler>, ["~> 0.8.3"])
      s.add_dependency(%q<yard>, [">= 0.8.5.2"])
      s.add_dependency(%q<bluecloth>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake-compiler>, ["~> 0.8.3"])
    s.add_dependency(%q<yard>, [">= 0.8.5.2"])
    s.add_dependency(%q<bluecloth>, [">= 0"])
  end
end
