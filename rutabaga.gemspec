# coding: utf-8
require File.expand_path('../lib/rutabaga/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Lukas Oberhuber']
  gem.email         = ['lukas.oberhuber@simplybusiness.co.uk']
  gem.description   = %q{Allows using feature from within RSpec and is built on top of Turnip}
  gem.summary       = %q{Calling Turnip feature files from RSpec, which allows encapsulating a feature inside a describe block}
  gem.homepage      = 'https://github.com/simplybusiness/rutabaga'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'rutabaga'
  gem.require_paths = ['lib']
  gem.version       = Rutabaga::VERSION
  gem.license       = 'MIT'

  gem.add_runtime_dependency 'turnip', ['~> 2.0.0']
  gem.add_runtime_dependency 'gherkin', ['~> 2.0']
  gem.add_runtime_dependency 'activesupport'
  # There is a bug in 3.4.1 with turnip 2.0.x
  gem.add_runtime_dependency 'rspec-mocks', ['<= 3.4.0']
  gem.add_development_dependency 'capybara'
  gem.add_development_dependency 'pry', '~> 0'
end
