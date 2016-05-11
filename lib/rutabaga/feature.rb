require 'turnip/rspec'
require 'rspec'

module Rutabaga
  module Feature
    def feature(feature_file = find_feature)

      example_group_class = self.class

      # Hack turnip into the rspec only when needed
      example_group_class.send(:include, Turnip::RSpec::Execute)
      example_group_class.send(:include, Turnip::Steps)

      Turnip::RSpec.rutabaga_run(feature_file, example_group_class)
    end

    private

    def find_feature
      description = RSpec.current_example.description
      Util.find_feature(description)
    end
  end
end
