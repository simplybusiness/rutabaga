require 'turnip/rspec'
require 'rspec'

# Monkey patch RSpec to add the feature method in example groups
class RSpec::Core::ExampleGroup
  def self.define_feature_method(metadata={})
    idempotently_define_singleton_method(:feature) do |*args, &example_group_block|
      thread_data = RSpec::Support.thread_local_data
      top_level   = self == RSpec::Core::ExampleGroup

      if top_level
        if thread_data[:in_example_group]
          raise "Creating an isolated context from within a context is " \
                "not allowed. Change `RSpec.#{name}` to `#{name}` or " \
                "move this to a top-level scope."
        end

        thread_data[:in_example_group] = true
      end

      begin

        description = args.shift
        combined_metadata = metadata.dup
        combined_metadata.merge!(args.pop) if args.last.is_a? Hash
        args << combined_metadata

        feature_class = subclass(self, description, args, &example_group_block).tap do |child|
          children << child
        end

        Rutabaga::ExampleGroup::Feature.feature(feature_class, description, args)

        feature_class

      ensure
        thread_data.delete(:in_example_group) if top_level
      end
    end

    RSpec::Core::DSL.expose_example_group_alias(:feature)
  end

  define_feature_method
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
