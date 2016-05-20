# Changes

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
