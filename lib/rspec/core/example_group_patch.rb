# frozen_string_literal: true

# This file needs to be in this folder structure otherwise rspec
# will not filter it out of the caller chain, and therefore report
# incorrect file locations for example groups. This especially
# affects turnip mode.

# Monkey patch rspec to block capybara from using feature
class RSpec::Core::Configuration
  alias orig_alias_example_group_to alias_example_group_to

  def alias_example_group_to(new_name, *)
    return if [:feature, :xfeature, :ffeature].include?(new_name)

    orig_alias_example_group_to(new_name, *)
  end
end

# Monkey patch RSpec to add the feature method in example groups
class RSpec::Core::ExampleGroup
  class << self
    alias orig_subclass subclass

    def subclass(parent, description, *all_args, &)
      rutabaga = all_args.first.any? { |arg| arg.is_a?(Hash) && arg[:rutabaga] }

      orig_subclass(parent, description, *all_args, &).tap do |describe|
        if rutabaga
          Rutabaga::ExampleGroup::Feature.feature(describe, description, all_args.last)
        end
      end
    end
  end

  define_example_group_method :feature, rutabaga: true
end
