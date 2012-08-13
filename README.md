# Rutabaga

Turnip hacks to enable running turnips from inside spec files, rather than outside.

Rutabaga allows you to invert the control of feature files, so that features are called from your `_spec.rb` files rather than the other way around. Step definitions are then put into the `_spec.rb` files as well.

This means that it is simple to create tests that are described by a class (such as controller tests in rspec-rails).

## Installation

Install the gem

```
gem install rutabaga
```

Or add it to your Gemfile and run `bundle`.

``` ruby
group :test do
  gem "rutabaga", :git => 'git://github.com/simplybusiness/rutabaga.git'
end
```

Now edit the `.rspec` file in your project directory (create it if doesn't
exist), and add the following line:

```
-r rutabaga
```

Add the follwing lines to the bottom of your `spec_helper.rb` (assuming you want to use Capybara and the final one if you wish to have step definitions outside of your spec files:

```
require 'turnip/capybara'
Dir.glob("spec/features/step_definitions/**/*_steps.rb") { |f| load f, true }
```

## Usage

### Running a feature file from a spec file

Please look in `spec/controllers/feature_test_spec.rb` and `spec/controllers/feature_test.feature` for more.

For file `spec/controllers/test_feature_spec.rb`

```
it "should run feature" do
  feature
end
```

Will run `spec/controllers/test_feature.feature`.

Features are found either with the same name as the spec file, or as specified in the example name `it "/path/to/feature/file.feature"`. So, if you have:

`spec/controllers/feature_test_spec.rb`

Then the feature will be:

`spec/controllers/feature_test.feature`

Alternatively, if the feature is specified in the `it`, that takes precedence:

```
it "spec/features/test.feature" do
    feature
end
```

Will run `spec/features/test.feature`.

### Differences from Turnip

Other than these differences, Rutabaga is a tiny shim over Turnip and all features will work as expected.

* Turnip looks anywhere below the `spec` directory for `.feature` files. Rutabaga will only load `.feature` files from below the `spec/features` directory in the old way. This is to avoid conflicts with `.feature` files that are loaded from `_spec.rb` files.

## Why?

The fundamental purpose of Turnip/Cucumber is to document the system in end-user readable form.

The most important functionality in a system is the business rules. These range from what appears on a page, to complex rules around when emails should be sent to who. For example, we've written Gherkin tests for what amount to charge a customer when they change what's covered on their insurance policy.

Those rules are often implemented in a Model, a lib class, or some other specific class in the system, especially if the application is well modularized.

In any case, business rules are usually implemented somewhere inside a class tested by a unit test. I want to get those business rules tested in Cucumber/Turnip without having to go through the whole system, and without having to have duplicate tests, one inside my rspec and another inside my features.

My goal is to test just the business rule, in Turnip, and not the login, the html, the steps to get there, etc. That way, when the rule changes, I change the Turnip, the test code and the class in question. My test is not affected by wider ranging changes, and therefore less brittle. (This should all be familiar territory.) I guess, in that sense, the code runs at the unit code level, but is an acceptance test.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

Copyright © 2012 SimplyBusiness. See LICENSE for details.
