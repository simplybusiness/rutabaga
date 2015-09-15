require 'turnip/rspec'

module Rutabaga
  module Feature
    def feature(feature_file = find_feature)

      rspec_class = self.class

      # Hack turnip into the rspec only when needed
      rspec_class.send(:include, Turnip::RSpec::Execute)
      rspec_class.send(:include, Turnip::Steps)

      # Point the describe (used for creating the feature) in turnip from 
      # RSpec to the current class so we get steps within the current 
      # example group
      ::RSpec.singleton_class.send(:alias_method, :real_describe, :describe)
      ::RSpec.define_singleton_method(:new_describe) do |*args, &example_group_block|
        rspec_class.describe(args, &example_group_block)
      end
      ::RSpec.singleton_class.send(:alias_method, :describe, :new_describe)

      Turnip::RSpec.run(feature_file)

      ::RSpec.singleton_class.send(:alias_method, :describe, :real_describe)
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

    # For compatibility with rspec 2 and rspec 3. RSpec.current_example was added late in
    # the rspec 2 cycle.
    def get_example
      begin
        @example ||= RSpec.current_example
      rescue NameError => e
        @example ||= example
      end
    end
  end
end

::RSpec.configure do |c|
  c.include Rutabaga::Feature
  # Blow away turnip's pattern, and focus just on features directory
  c.pattern.gsub!(",**/*.feature", ",features/**/*.feature")
end
