require 'turnip/rspec'
require 'rspec'

module Rutabaga
  module Feature
    def feature(feature_file = nil)
      RSpec.deprecate(
        "Calling `feature` from an `it` block",
        :message => "Calling `feature` from an `it` block " \
                    "is deprecated.\nYou should now put your steps inside " \
                    "a `feature` block.\n\n" \
                    "```\n" \
                    "feature \"optional feature file location\" do\n" \
                    "  step \"a step\" do\n" \
                    "    ...\n" \
                    "  end\n" \
                    "end\n" \
                    "```"
      )

      feature_file = Util.find_feature(feature_file || RSpec.current_example.description)
      example_group_class = self.class

      # Hack turnip into the rspec only when needed
      example_group_class.send(:include, Turnip::RSpec::Execute)
      example_group_class.send(:include, Turnip::Steps)

      run(feature_file, example_group_class)
    end

    # Adapted from jnicklas/turnip v2.0.0
    def run(feature_file, example_group_class)
      features = Util.build_features(feature_file)
      features.each do |feature|
        describe = example_group_class.describe feature.name, feature.metadata_hash
        run_feature(describe, feature, feature_file, example_group_class)
      end
    end

    def run_feature(describe, feature, filename, example_group_class)
      example_group_class.before do
        # This is kind of a hack, but it will make RSpec throw way nicer exceptions
        RSpec.current_example.metadata[:file_path] = filename

        feature.backgrounds.map(&:steps).flatten.each do |step|
          run_step(filename, step)
        end
      end

      feature.scenarios.each do |scenario|
        example_group_class.describe scenario.name, scenario.metadata_hash do
          it(scenario.steps.map(&:to_s).join(' -> ')) do
            scenario.steps.each do |step|
              run_step(filename, step)
            end
          end
        end
      end
    end
  end
end
