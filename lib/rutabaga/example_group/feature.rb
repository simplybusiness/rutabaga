require 'turnip/rspec'
require 'rspec'

# Monkey patch RSpec to add the feature method in example groups
class RSpec::Core::ExampleGroup
  idempotently_define_singleton_method(:feature) do |*all_args|
    desc, *args = *all_args

    options = RSpec::Core::Metadata.build_hash_from(args)

    Rutabaga::ExampleGroup::Feature.feature(self, desc, options)
  end
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
