# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "colored"
  s.version = "1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Chris Wanstrath"]
  s.date = "2010-02-10"
  s.description = "  >> puts \"this is red\".red\n \n  >> puts \"this is red with a blue background (read: ugly)\".red_on_blue\n\n  >> puts \"this is red with an underline\".red.underline\n\n  >> puts \"this is really bold and really blue\".bold.blue\n\n  >> logger.debug \"hey this is broken!\".red_on_yellow     # in rails\n\n  >> puts Color.red \"This is red\" # but this part is mostly untested\n"
  s.email = "chris@ozmm.org"
  s.homepage = "http://github.com/defunkt/colored"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.23"
  s.summary = "Add some color to your life."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
