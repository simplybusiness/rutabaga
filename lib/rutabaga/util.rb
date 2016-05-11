# Utils and monkey patches for both versions of feature

# Monkey patch for Turnip to not have to copy loads of code
module Turnip::RSpec
  def self.rutabaga_run(feature_file, example_group_class)
    Turnip::Builder.build(feature_file).features.each do |feature|
      instance_eval <<-EOS, feature_file, feature.line
        describe = example_group_class.describe feature.name, feature.metadata_hash
        run_feature(describe, feature, feature_file)
      EOS
    end
  end
end

module Rutabaga
  class Util
    class << self
      def find_feature(description)
        return description if File.exists?(description)

        feature_file = caller(0).find do |call|
          call =~ /_spec.rb:/
        end.gsub(/_spec.rb:.*\Z/, '.feature')
        return feature_file if File.exists?(feature_file)

        raise "Feature file not found. Tried: #{description} and #{feature_file}"
      end

      def require_if_exists(filename)
        require filename
      rescue LoadError => e
        # Don't hide LoadErrors raised in the spec helper.
        raise unless e.message.include?(filename)
      end
    end
  end
end

::RSpec.configure do |c|
  c.include Rutabaga::Feature
  # Blow away turnip's pattern, and focus just on features directory
  c.pattern.gsub!(",**/*.feature", ",features/**/*.feature")
end