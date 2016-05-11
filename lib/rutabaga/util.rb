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
