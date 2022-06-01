# -*- encoding: utf-8 -*-
# stub: turnip 4.3.0 ruby lib

Gem::Specification.new do |s|
  s.name = "turnip".freeze
  s.version = "4.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jonas Nicklas".freeze]
  s.date = "2021-05-16"
  s.description = "Provides the ability to define steps and run Gherkin files from with RSpec".freeze
  s.email = ["jonas.nicklas@gmail.com".freeze]
  s.homepage = "https://github.com/jnicklas/turnip/".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3".freeze)
  s.rubygems_version = "2.6.14.1".freeze
  s.summary = "Gherkin extension for RSpec".freeze

  s.installed_by_version = "2.6.14.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rspec>.freeze, ["< 4.0", ">= 3.0"])
      s.add_runtime_dependency(%q<cucumber-gherkin>.freeze, ["~> 14.0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
      s.add_development_dependency(%q<pry-byebug>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rspec>.freeze, ["< 4.0", ">= 3.0"])
      s.add_dependency(%q<cucumber-gherkin>.freeze, ["~> 14.0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
      s.add_dependency(%q<pry-byebug>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, ["< 4.0", ">= 3.0"])
    s.add_dependency(%q<cucumber-gherkin>.freeze, ["~> 14.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<pry-byebug>.freeze, [">= 0"])
  end
end
