source 'https://rubygems.org'

# Specify your gem's dependencies in rutabaga.gemspec
gemspec

unless RUBY_PLATFORM
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-stack_explorer'
  gem 'pry-rescue'
end

# Gem a dependency of Capybara, new version of rack 2.0 onwards require ruby 2.2 and above.
if RUBY_VERSION.to_f < 2.2
  gem 'rack', '~> 1.6'
else
  gem 'rack'
end
