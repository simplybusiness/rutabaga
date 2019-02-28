require 'turnip/rspec'
require 'rspec'

module Rutabaga
  module Feature
    # Adapted from jnicklas/turnip v2.0.0
    def run(feature_file, example_group_class)
      features = Util.build_scenario_groups(feature_file)
      features.each do |feature|
        describe = example_group_class.describe feature.name, feature.metadata_hash
        run_scenario_group(describe, feature, feature_file, example_group_class)
      end
    end

    def run_scenario_group(describe, feature, filename, example_group_class)
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
    alias_method :run_feature, :run_scenario_group # Turnip 3 support
  end
end
