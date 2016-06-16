# Changes

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
