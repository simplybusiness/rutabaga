# Changes

## Version 3.0.2

- Fix a bug in Ruby 3.2
- Test against Ruby 3.1 and 3.2
- Stop testing against 2.5 and 2.6

## Version 3.0.2

- Implement auto deploy
- Remove support for ruby 2.4


## Version 3.0.2

- Implement auto deploy
- Remove support for ruby 2.4

## Version 3.0.1

- Removes legacy compatibility hack which stops `capybara-screenshot` from working.

## Version 3.0.0

- Adds Turnip 4 support
- Removes Turnip 2 support
- Removes deprecated way of calling features

## Version 2.1.6

- Support for Turnip 3.0
- Dropped testing for older ruby versions

## Version 2.1.5

- Support for Rspec 3.5 is fixed

## Version 2.1.4

- Locked to Rspec versions between 3 and 3.4 as currently 3.5 is not supported
- Removed activesupport dependency as no longer required.

## Version 2.1.3

- Fixes ability for parallel_tests to handle turnip output, even when rutabaga is used. This has been broken since version 2.0

## Version 2.1.0

- **No Turnip Mode**: Turnip support can now be disabled by including `rutabaga/no_turnip` for example
  by calling `rspec -r rutabaga/no_turnip`
- When requesting features outside of the turnip directory `spec/features` a warning is issued

## Version 2.0.0

- Features should now be called directly in the describe block rather than inside an `it` block. This allows specific scenarios to be run without having to run the entire feature.

Old:

```ruby
describe "the feature" do
  it "runs the feature" do
    feature
  end

  step "first step" do
    ...
  end
end
```

New:

```ruby
feature "the feature" do
  step "first step" do
    ...
  end
end
```

The old way is deprecated.
- Refactor of Turnip and RSpec integration to simplify
- Improved feature finding, allowing features in the current directory to be found without specifying full path

## Version 1.0.0

- Drop support for turnip versions less than 2.
- Drop support (because of turnip) for rspec versions less than 3.
