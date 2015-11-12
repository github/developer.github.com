# -*- encoding: utf-8 -*-
# stub: raindrops 0.15.0 ruby lib
# stub: ext/raindrops/extconf.rb

Gem::Specification.new do |s|
  s.name = "raindrops"
  s.version = "0.15.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["raindrops hackers"]
  s.date = "2015-07-22"
  s.description = "raindrops is a real-time stats toolkit to show statistics for Rack HTTP\nservers.  It is designed for preforking servers such as unicorn, but\nshould support any Rack HTTP server on platforms supporting POSIX shared\nmemory.  It may also be used as a generic scoreboard for sharing atomic\ncounters across multiple processes."
  s.email = "raindrops@bogomips.org"
  s.extensions = ["ext/raindrops/extconf.rb"]
  s.extra_rdoc_files = ["README", "LICENSE", "NEWS", "lib/raindrops.rb", "lib/raindrops/aggregate.rb", "lib/raindrops/aggregate/last_data_recv.rb", "lib/raindrops/aggregate/pmq.rb", "lib/raindrops/last_data_recv.rb", "lib/raindrops/linux.rb", "lib/raindrops/middleware.rb", "lib/raindrops/middleware/proxy.rb", "lib/raindrops/struct.rb", "lib/raindrops/watcher.rb", "ext/raindrops/raindrops.c", "ext/raindrops/linux_inet_diag.c", "ext/raindrops/linux_tcp_info.c"]
  s.files = ["LICENSE", "NEWS", "README", "ext/raindrops/extconf.rb", "ext/raindrops/linux_inet_diag.c", "ext/raindrops/linux_tcp_info.c", "ext/raindrops/raindrops.c", "lib/raindrops.rb", "lib/raindrops/aggregate.rb", "lib/raindrops/aggregate/last_data_recv.rb", "lib/raindrops/aggregate/pmq.rb", "lib/raindrops/last_data_recv.rb", "lib/raindrops/linux.rb", "lib/raindrops/middleware.rb", "lib/raindrops/middleware/proxy.rb", "lib/raindrops/struct.rb", "lib/raindrops/watcher.rb"]
  s.homepage = "http://raindrops.bogomips.org/"
  s.licenses = ["LGPL-2.1+"]
  s.rubygems_version = "2.4.5.1"
  s.summary = "real-time stats for preforking Rack servers"

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<aggregate>, ["~> 0.2"])
      s.add_development_dependency(%q<test-unit>, ["~> 3.0"])
      s.add_development_dependency(%q<io-extra>, [">= 1.2.3", "~> 1.2"])
      s.add_development_dependency(%q<posix_mq>, ["~> 2.0"])
      s.add_development_dependency(%q<rack>, ["~> 1.2"])
      s.add_development_dependency(%q<unicorn>, [">= 0.98"])
      s.add_development_dependency(%q<olddoc>, ["~> 1.0"])
    else
      s.add_dependency(%q<aggregate>, ["~> 0.2"])
      s.add_dependency(%q<test-unit>, ["~> 3.0"])
      s.add_dependency(%q<io-extra>, [">= 1.2.3", "~> 1.2"])
      s.add_dependency(%q<posix_mq>, ["~> 2.0"])
      s.add_dependency(%q<rack>, ["~> 1.2"])
      s.add_dependency(%q<unicorn>, [">= 0.98"])
      s.add_dependency(%q<olddoc>, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<aggregate>, ["~> 0.2"])
    s.add_dependency(%q<test-unit>, ["~> 3.0"])
    s.add_dependency(%q<io-extra>, [">= 1.2.3", "~> 1.2"])
    s.add_dependency(%q<posix_mq>, ["~> 2.0"])
    s.add_dependency(%q<rack>, ["~> 1.2"])
    s.add_dependency(%q<unicorn>, [">= 0.98"])
    s.add_dependency(%q<olddoc>, ["~> 1.0"])
  end
end
