require 'turnip/rspec'
require 'rspec'

module Rutabaga
  module Feature
    def feature(feature_file = find_feature)

      example_group_class = self.class

      # Hack turnip into the rspec only when needed
      example_group_class.send(:include, Turnip::RSpec::Execute)
      example_group_class.send(:include, Turnip::Steps)

      run(feature_file, example_group_class)
    end

    def find_feature
      return get_example.description if File.exists?(get_example.description)

      feature_file = caller(0).find do |call|
        call =~ /_spec.rb:/
      end.gsub(/_spec.rb:.*\Z/, '.feature')
      return feature_file if File.exists?(feature_file)

      raise "Feature file not found. Tried: #{get_example.description} and #{feature_file}"
    end

    private

    # Adapted from jnicklas/turnip v1.3.1
    def run(feature_file, example_group_class)
      Turnip::Builder.build(feature_file).features.each do |feature|
        describe = example_group_class.describe feature.name, feature.metadata_hash
        run_feature(describe, feature, feature_file, example_group_class)
      end
    end

    def run_feature(describe, feature, filename, example_group_class)
      example_group_class.before do
        # This is kind of a hack, but it will make RSpec throw way nicer exceptions
        get_example.metadata[:file_path] = filename

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

    def get_example
      @example ||= RSpec.current_example
    end
  end
end

::RSpec.configure do |c|
  c.include Rutabaga::Feature
  # Blow away turnip's pattern, and focus just on features directory
  c.pattern.gsub!(",**/*.feature", ",features/**/*.feature")
end
