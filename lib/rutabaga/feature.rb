require 'turnip'

module Rutabaga
  module Feature
    def feature
      feature_file = find_feature

      rspec_class = self.class

      # Hack turnip into the rspec only when needed
      rspec_class.send(:include, Turnip::RSpec::Execute)
      rspec_class.send(:include, Turnip::Steps)

      builder = Turnip::Builder.build(feature_file)
      builder.features.each do |feature|
        rspec_class.describe(feature.name, feature.metadata_hash) do
          rspec_class.before do
            # This is kind of a hack, but it will make RSpec throw way nicer exceptions
            example.metadata[:file_path] = feature_file

            feature.backgrounds.map(&:steps).flatten.each do |step|
              run_step(feature_file, step)
            end
          end
          feature.scenarios.each do |scenario|
            rspec_class.describe(scenario.name, scenario.metadata_hash) do
              it scenario.steps.map(&:description).join(' -> ') do
                scenario.steps.each do |step|
                  run_step(feature_file, step)
                end
              end
            end
          end
        end
      end
    end

    def find_feature
      return example.description if File.exists?(example.description)

      spec_file = caller(2).first.split(':').first
      feature_file = spec_file.gsub(/_spec.rb\Z/, '.feature')
      return feature_file if File.exists?(feature_file)

      raise "Feature file not found. Tried: #{example.description} and #{feature_file}"
    end
  end
end

::RSpec.configure do |c|
  c.include Rutabaga::Feature
  # Blow away turnip's pattern, and focus just on features directory
  c.pattern.gsub!(",**/*.feature", ",features/**/*.feature")
end