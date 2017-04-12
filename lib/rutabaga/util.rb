# Utils and monkey patches for both versions of feature

# Monkey patch for Turnip to not have to copy loads of code
module Turnip::RSpec
  def self.rutabaga_run(feature_file, example_group_class)
    features = Rutabaga::Util.build_features(feature_file)
    features.each do |feature|
      instance_eval <<-EOS, feature_file, feature.line
        describe = example_group_class.describe feature.name, feature.metadata_hash.reject { |key, _| key == :type }
        run_feature(describe, feature, feature_file)
      EOS
    end
  end
end

module Rutabaga
  class Util
    class << self
      def find_feature(description)
        tried = []

        if description =~ /.*\.(feature|rutabaga)\Z/
          return description if File.exists?(description)
          tried << description

          candidate = File.join(extract_directory, description)
          return candidate if File.exists?(candidate)
          tried << candidate
        else
          feature_files = extract_features
          feature_files.each do |feature_file|
            return feature_file if File.exists?(feature_file)
          end
          tried += feature_files
        end

        raise "Feature file not found. Tried: #{tried.join(', ')}"
      end

      def require_if_exists(filename)
        require filename
      rescue LoadError => e
        # Don't hide LoadErrors raised in the spec helper.
        raise unless e.message.include?(filename)
      end

      def build_features(feature_file)
        if Gem::Version.new(Turnip::VERSION) >= Gem::Version.new('3.0.0')
          [Turnip::Builder.build(feature_file)]
        else
          Turnip::Builder.build(feature_file).features
        end
      end

      private

      def extract_directory
        caller(0).find do |call|
          call =~ /_spec.rb:/
        end.gsub(/\/[^\/]+_spec.rb:.*\Z/, '')
      end

      def extract_features
        base = caller(0).find do |call|
          call =~ /_spec.rb:/
        end.gsub(/_spec.rb:.*\Z/, '')
        [base+'.feature', base+'.rutabaga']
      end
    end
  end
end

::RSpec.configure do |c|
  c.include Rutabaga::Feature
  # Blow away turnip's pattern, and focus just on features directory
  if defined?(Rutabaga::NO_TURNIP)
    c.pattern.gsub!(",**/*.feature", "")
  else
    c.pattern.gsub!(",**/*.feature", ",features/**/*.feature")
  end
end
