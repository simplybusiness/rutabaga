require 'turnip/rspec'
require 'rspec'

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

    def subclass(parent, description, args, &example_group_block)
      self.orig_subclass(parent, description, args, &example_group_block).tap do |describe|

        if args.any? { |arg| arg.kind_of?(Hash) && arg[:rutabaga] }
          Rutabaga::ExampleGroup::Feature.feature(describe, description, args)
        end

      end
    end
  end

  define_example_group_method :feature, :rutabaga => true
end

module Rutabaga
  module ExampleGroup
    module Feature
      class << self
        def feature(example_group_class, description, args)
          Util.require_if_exists 'turnip_helper'

          Turnip::RSpec.rutabaga_run(Util.find_feature(description), example_group_class)
        end
      end
    end
  end
end
