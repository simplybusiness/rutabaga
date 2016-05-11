require 'turnip/rspec'
require 'rspec'

module Rutabaga
  module Feature
    def feature(feature_file = nil)
      RSpec.deprecate(
        "Calling `feature` from an `it` block",
        :message => "Calling `feature` from an `it` block " \
                    "is deprecated.\nIt should now be called directly in the " \
                    "`describe` block."
      )

      feature_file = Util.find_feature(feature_file || RSpec.current_example.description)
      example_group_class = self.class

      # Hack turnip into the rspec only when needed
      example_group_class.send(:include, Turnip::RSpec::Execute)
      example_group_class.send(:include, Turnip::Steps)

      Turnip::RSpec.rutabaga_run(feature_file, example_group_class)
    end
  end
end
