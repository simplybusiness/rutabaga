# This file needs to be in this folder structure otherwise rspec
# will not filter it out of the caller chain, and therefore report
# incorrect file locations for example groups. This especially
# affects turnip mode.

# Monkey patch rspec to block capybara from using feature
class RSpec::Core::Configuration
  alias_method :orig_alias_example_group_to, :alias_example_group_to

  def alias_example_group_to(new_name, *args)
    return if [:feature, :xfeature, :ffeature].include?(new_name)
    orig_alias_example_group_to(new_name, *args)
  end
end

# Monkey patch RSpec to add the feature method in example groups
class RSpec::Core::ExampleGroup
  class << self
    alias_method :orig_subclass, :subclass

    def subclass(parent, description, args, registration_collection, &example_group_block)
      rutabaga = args.any? { |arg| arg.kind_of?(Hash) && arg[:rutabaga] }

      self.orig_subclass(parent, description, args, registration_collection, &example_group_block).tap do |describe|
        Rutabaga::ExampleGroup::Feature.feature(describe, description, args) if rutabaga
      end
    end
  end

  define_example_group_method :feature, :rutabaga => true
end
