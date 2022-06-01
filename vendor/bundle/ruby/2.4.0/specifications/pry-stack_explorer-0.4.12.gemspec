# -*- encoding: utf-8 -*-
# stub: pry-stack_explorer 0.4.12 ruby lib

Gem::Specification.new do |s|
  s.name = "pry-stack_explorer".freeze
  s.version = "0.4.12"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["John Mair (banisterfiend)".freeze]
  s.date = "2020-08-17"
  s.email = "jrmair@gmail.com".freeze
  s.homepage = "https://github.com/pry/pry-stack_explorer".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0.0".freeze)
  s.rubygems_version = "2.6.14.1".freeze
  s.summary = "Walk the stack in a Pry session".freeze

  s.installed_by_version = "2.6.14.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<binding_of_caller>.freeze, ["~> 0.7"])
      s.add_runtime_dependency(%q<pry>.freeze, ["~> 0.13"])
      s.add_development_dependency(%q<bacon>.freeze, ["~> 1.1.0"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 0.9"])
    else
      s.add_dependency(%q<binding_of_caller>.freeze, ["~> 0.7"])
      s.add_dependency(%q<pry>.freeze, ["~> 0.13"])
      s.add_dependency(%q<bacon>.freeze, ["~> 1.1.0"])
      s.add_dependency(%q<rake>.freeze, ["~> 0.9"])
    end
  else
    s.add_dependency(%q<binding_of_caller>.freeze, ["~> 0.7"])
    s.add_dependency(%q<pry>.freeze, ["~> 0.13"])
    s.add_dependency(%q<bacon>.freeze, ["~> 1.1.0"])
    s.add_dependency(%q<rake>.freeze, ["~> 0.9"])
  end
end
