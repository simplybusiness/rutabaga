require 'turnip/rspec'
require 'rspec'

# Monkey patch RSpec to add the feature method in example groups
class RSpec::Core::ExampleGroup
  idempotently_define_singleton_method(:feature) do |*args|
    description = args.shift
    Rutabaga::ExampleGroup::Feature.feature(self, description, args)
  end
end

module Turnip::RSpec
  def self.rutabaga_run(feature_file, example_group_class)
    Turnip::Builder.build(feature_file).features.each do |feature|
      instance_eval <<-EOS, feature_file, feature.line
        describe_thing = example_group_class.describe feature.name, feature.metadata_hash
        run_feature(describe_thing, feature, feature_file)
      EOS
    end
  end
end

module Rutabaga
  module ExampleGroup
    module Feature
      include Turnip::RSpec::Loader

      class << self
        def feature(example_group_class, description, args)
          Util.require_if_exists 'turnip_helper'

          Turnip::RSpec.rutabaga_run(Util.find_feature(description), example_group_class)
        end

        private

      end
    end
  end
end

::RSpec.configure do |c|
  # Blow away turnip's pattern, and focus just on features directory
  c.pattern.gsub!(",**/*.feature", ",features/**/*.feature")
end
