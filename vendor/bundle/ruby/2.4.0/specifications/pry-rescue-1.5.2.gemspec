# -*- encoding: utf-8 -*-
# stub: pry-rescue 1.5.2 ruby lib

Gem::Specification.new do |s|
  s.name = "pry-rescue".freeze
  s.version = "1.5.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Conrad Irwin".freeze, "banisterfiend".freeze, "epitron".freeze]
  s.date = "2020-06-25"
  s.description = "Allows you to wrap code in Pry::rescue{ } to open a pry session at any unhandled exceptions".freeze
  s.email = ["conrad.irwin@gmail.com".freeze, "jrmair@gmail.com".freeze, "chris@ill-logic.com".freeze]
  s.executables = ["kill-pry-rescue".freeze, "rescue".freeze]
  s.files = ["bin/kill-pry-rescue".freeze, "bin/rescue".freeze]
  s.homepage = "https://github.com/ConradIrwin/pry-rescue".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.14.1".freeze
  s.summary = "Open a pry session on any unhandled exceptions".freeze

  s.installed_by_version = "2.6.14.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<pry>.freeze, [">= 0.12.0"])
      s.add_runtime_dependency(%q<interception>.freeze, [">= 0.5"])
      s.add_development_dependency(%q<pry-stack_explorer>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<redcarpet>.freeze, [">= 0"])
      s.add_development_dependency(%q<capybara>.freeze, [">= 0"])
    else
      s.add_dependency(%q<pry>.freeze, [">= 0.12.0"])
      s.add_dependency(%q<interception>.freeze, [">= 0.5"])
      s.add_dependency(%q<pry-stack_explorer>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<redcarpet>.freeze, [">= 0"])
      s.add_dependency(%q<capybara>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<pry>.freeze, [">= 0.12.0"])
    s.add_dependency(%q<interception>.freeze, [">= 0.5"])
    s.add_dependency(%q<pry-stack_explorer>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<redcarpet>.freeze, [">= 0"])
    s.add_dependency(%q<capybara>.freeze, [">= 0"])
  end
end
