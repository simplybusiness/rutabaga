# Rutabaga

[Turnip](https://github.com/jnicklas/turnip) hacks to enable running turnips from inside spec files, rather than outside.

Rutabaga allows you to invert the control of feature files, so that features are called from your `_spec.rb` files rather than the other way around. Step definitions are then put into the `_spec.rb` files as well. The steps are then scoped to that particular test.

This means that it is simple to create tests that are described by a class (such as controller tests in rspec-rails).

[![Build Status](https://travis-ci.org/simplybusiness/rutabaga.svg?branch=master)](https://travis-ci.org/simplybusiness/rutabaga)

## Installation

Install the gem

```
gem install rutabaga
```

Or add it to your Gemfile and run `bundle`.

```ruby
group :test do
  gem "rutabaga"
end
```

Now edit the `.rspec` file in your project directory (create it if doesn't
exist), and add the following:

```
-r rutabaga
```

Add the follwing lines to the bottom of your `spec_helper.rb` (assuming you want to use Capybara and the final one if you wish to have step definitions outside of your spec files:

```ruby
require 'turnip/capybara'
Dir.glob("spec/features/step_definitions/**/*_steps.rb") { |f| load f, true }
```

In order to get `rake` or `bundle exec rake` to work properly, you might need to add this in the file `lib/tasks/rspec.rake` (at least for rails)

```ruby
if defined? RSpec # otherwise fails on non-live environments
  desc "Run all specs/features in spec directory"
  RSpec::Core::RakeTask.new(:spec => 'db:test:prepare') do |t|
    t.pattern = './spec/{**/*_spec.rb,features/**/*.feature}'
  end
end
```

## Usage

### Running a feature file from a spec file

Please look in `spec/controllers/feature_test_spec.rb` and `spec/controllers/feature_test.feature` for more.

For file `spec/controllers/test_feature_spec.rb`

```ruby
it "should run feature" do
  feature
end
```

Will run `spec/controllers/test_feature.feature`.

Features are found either with the same name as the spec file, or as specified in the example name `it "relative_from_root/path/to/feature/file.feature"`. So, if you have:

`spec/controllers/feature_test_spec.rb`

Then the feature will be:

`spec/controllers/feature_test.feature`

Alternatively, if the feature is specified in the `it`, that takes precedence:

```ruby
it "spec/features/test.feature" do
    feature
end
```

Will run `spec/features/test.feature`.

Second alternative, is specifying the feature file in the `feature` command:

```ruby
it "should run the feature" do
    feature "spec/features/test.feature"
end
```

Will run `spec/features/test.feature`.

### Definining steps

Steps are defined in the same way as in Turnip, however, steps can be defined within the rspec context and are scoped to only be available there.

```ruby
describe "step will only be in this context" do
  it "should run feature" do
    feature
  end

  step "action :named" do |named| do
    expect(named).to eq("a name")
  end
end

describe "step 'action :named' is not available here" do
  it "cannot run feature due to missing step" do
    expect(feature).to raise_error
  end
end
```

### Differences from Turnip

Other than these differences, Rutabaga is a tiny shim over Turnip and all features will work as expected.

* Turnip looks anywhere below the `spec` directory for `.feature` files. Rutabaga will only load `.feature` files from below the `spec/features` directory in the old way. This avoids conflicts with `.feature` files that are loaded from `_spec.rb` files.

## Why?

* Document business rules in Gherkin/Turnip/Cucumber human readable language
* Test those rules whereever/however appropriate (not just through Capybara/black box)
* Use the full power of RSpec (so being able to describe a class and then test it)

From my point of view, the fundamental purpose of Turnip/Cucumber is to document the system in end-user readable form. It is not just to do integration tests.

The most important functionality in a system is the business rules. These range from what appears on a page, to complex rules around when emails should be sent to who. For example, we've written Gherkin tests to test premium changes when a customer changes their insurance coverage.

These rules are often implemented in a Model, a lib class, or some other specific class in the system, especially if the application is well modularized.

In any case, business rules are usually implemented somewhere inside a class tested by a unit test. I want to get those business rules tested in Cucumber/Turnip without having to go through the whole system, and without having to have duplicate tests, one inside my rspec and another inside my features.

My goal is to test just the business rule, in Turnip, and not the login, the html, the steps to get there, etc. That way, when the rule changes, I change the Turnip, the test code and the class in question. My test is not affected by wider ranging changes, and therefore less brittle. I guess, in that sense, the code runs at the unit code level, but is an acceptance test.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## For maintainers

Use `gem-release` to maintain versions https://github.com/svenfuchs/gem-release.

## Copyright

Copyright © 2012 Simply Business. See LICENSE for details.
