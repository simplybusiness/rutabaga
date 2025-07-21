# frozen_string_literal: true

require File.expand_path('lib/rutabaga/version', __dir__)

Gem::Specification.new do |gem|
  gem.authors       = ['Simply Business']
  gem.email         = ['opensource@simplybusiness.co.uk']
  gem.description   = 'Allows using feature from within RSpec and is built on top of Turnip'
  gem.summary       = 'Calling Turnip feature files from RSpec, which allows encapsulating a feature inside a describe block'
  gem.homepage      = 'https://github.com/simplybusiness/rutabaga'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = 'rutabaga'
  gem.require_paths = ['lib']
  gem.version       = Rutabaga::VERSION
  gem.license       = 'MIT'

  gem.add_dependency 'activesupport'
  gem.add_dependency 'rspec', ['~> 3.0']
  gem.add_dependency 'turnip', ['~> 4.4']

  gem.add_development_dependency 'capybara'
  gem.add_development_dependency 'pry', '~> 0'
  gem.add_development_dependency 'simplycop'
end
