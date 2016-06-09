# Rutabaga

![image](rutabaga-vs-turnip.jpg)

[Turnip](https://github.com/jnicklas/turnip) extension to enable running turnip features from inside spec files, rather than outside.

Rutabaga allows you to invert the control of feature files, so that features are called from your `_spec.rb` files rather than the other way around. Step definitions are then put into the `_spec.rb` files as well. The steps are then scoped to that particular test.

This means that it is simple to create tests that are described by a class (such as controller tests in rspec-rails).

[![Build Status](https://travis-ci.org/simplybusiness/rutabaga.svg?branch=master)](https://travis-ci.org/simplybusiness/rutabaga)
[![Gem Version](https://badge.fury.io/rb/rutabaga.svg)](https://badge.fury.io/rb/rutabaga)

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

Choose which mode you want to use: __Turnip compatibility mode__ or __No Turnip mode__.

### Turnip compatibility mode

In this mode, you can still have and call classic Turnip features directly, as long
as they are situated under the `spec/features` directory.

Edit the `.rspec` file in your project directory (create it if doesn't
exist), and add the following:

```
-r rutabaga
```

Add the following line to the bottom of your `spec_helper.rb` in order to use
Turnip global step definitions:

```ruby
Dir.glob("spec/features/step_definitions/**/*_steps.rb") { |f| load f, true }
```

In order to get `rake` or `bundle exec rake` to work properly you might need to add this in the file `lib/tasks/rspec.rake` (at least for rails).

```ruby
if defined? RSpec # otherwise fails on non-live environments
  desc "Run all specs/features in spec directory"
  RSpec::Core::RakeTask.new(:spec => 'db:test:prepare') do |t|
    t.pattern = './spec/{**/*_spec.rb,features/**/*.feature}'
  end
end
```

### No Turnip Mode

If you do not want to use Turnip features then you can disable turnip by adding the following to you `.rspec` file instead of `-r rutabaga`:

```ruby
-r rutabaga/no_turnip
```

### Capybara support

Add the following line to the bottom of your `spec_helper.rb` in order to use Capybara javascript driver (when features are tagged with `@javascript`):

```ruby
require 'turnip/capybara'
```

## Usage

### Running a feature file from a spec file

If you create a file `spec/controllers/test_feature_spec.rb` and add:

```ruby
feature "should run feature" do

end
```

Rutabaga will run `spec/controllers/test_feature.feature`.

Features are found either with the same name as the spec file, or as specified by the feature `feature "relative_from_root/path/to/feature/file.feature"`. So, if you have:

`spec/controllers/feature_test_spec.rb`

Then the feature will be:

`spec/controllers/feature_test.feature`

Alternatively, if the feature is specified in the `feature`, that takes precedence:

```ruby
feature "spec/features/test.feature" do

end
```

Path can also be relative to the spec location so:

```ruby
feature "test.feature" do

end
```

Will run `spec/controllers/test.feature`.

**Note** Anywhere that a `.feature` extension can be used, a `.rutabaga` extension is also valid.

### Definining steps

Steps are defined in the same way as in Turnip, however, steps can be defined within the rspec context and are scoped to only be available there.

```ruby
feature "step will only be in this context" do
  step "action :named" do |named| do
    expect(named).to eq("a name")
  end
end

feature "step 'action :named' is not available here" do
  # missing step will cause tests to be marked as pending"
end
```

### Differences from Turnip

Other than these differences, Rutabaga is a tiny shim over Turnip and all features will work as expected.

* Turnip looks anywhere below the `spec` directory for `.feature` files. Rutabaga will only load `.feature` files from below the `spec/features` directory in the old way. This avoids conflicts with `.feature` files that are loaded from `_spec.rb` files.

## Why?

* Allows you to document business rules in Gherkin/Turnip/Cucumber human readable language
* Test those rules wherever/however appropriate (not just through Capybara/black box)
* Use the full power of RSpec (being able to describe a class and then test it)

The most important functionality in a system is the business rules. These range from what appears on a page, to complex rules around when emails should be sent to who. For example, we've written Gherkin tests to test premium changes when a customer changes their insurance coverage.

These rules are often implemented in a Model, a lib class, or some other specific class in the system, especially if the application is well modularized.

In any case, business rules are usually implemented somewhere inside a class tested by a unit test. Those business rules should be tested in Cucumber/Turnip without having to go through the whole system, and without having to have duplicate tests, one inside rspec and another inside features.

The goal is to test just the business rule in Rutabaga, and not the login, the html, the steps to get there, etc. That way, when the rule changes, only the feature, the test code and the class in question need to change. The test is not affected by wider ranging changes, and is therefore less brittle. The features run at the unit code level, but are acceptance tests.

## Notes/Issues

1. Capybara's rspec extension also redefines feature, so rutabaga will block
   capaybara's feature example groups from working.
1. In order to call a specific scenario, you can use `rspec`'s filtering. Here is an example:
    `$ rspec spec/test_file_spec.rb -e "Title of my scenario"`.
   This will only call the Scenario titled `Title of my scenario` in file `spec/test_file_spec.rb`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## For maintainers

Use `gem-release` to maintain versions https://github.com/svenfuchs/gem-release.

To update the minor version (e.g. 0.0.1 to 0.0.2), after merging the PR to `master` run:

```
gem bump --tag --release
```

if instead you want to bump the minor version (e.g. 0.0.1 to 0.1.0):

```
gem bump --version minor --tag --release
```

or major version (e.g. 0.0.1 to 1.0.0):

```
gem bump --version major --tag --release
```

## Testing alternate versions

Put the following (example in a `Gemfile_for_xxx`) to test other versions of gems.

```
# Use global Gemfile and customize
eval(IO.read('Gemfile'), binding)

gem 'turnip', '2.0.0'
```

## Copyright

Copyright © 2012-2016 Simply Business. See LICENSE for details.
