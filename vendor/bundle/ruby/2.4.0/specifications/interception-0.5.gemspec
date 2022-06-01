# -*- encoding: utf-8 -*-
# stub: interception 0.5 ruby lib
# stub: ext/extconf.rb

Gem::Specification.new do |s|
  s.name = "interception".freeze
  s.version = "0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Conrad Irwin".freeze]
  s.date = "2014-03-06"
  s.description = "Provides a cross-platform ability to intercept all exceptions as they are raised.".freeze
  s.email = "conrad.irwin@gmail.com".freeze
  s.extensions = ["ext/extconf.rb".freeze]
  s.files = ["ext/extconf.rb".freeze]
  s.homepage = "http://github.com/ConradIrwin/interception".freeze
  s.rubygems_version = "2.6.14.1".freeze
  s.summary = "Intercept exceptions as they are being raised".freeze

  s.installed_by_version = "2.6.14.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
  end
end
