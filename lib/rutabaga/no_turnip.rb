module Rutabaga
  NO_TURNIP = true
end

require 'rutabaga'
##
#
# Disables turnip completely
#
module Turnip
  module RSpec
    module Loader
      def load(*a, &b)
        if a.first.end_with?('.feature')
          ::RSpec.warning "Calling features directly has been disabled by rutabaga. To re-enable, do not require rutabaga/no_turnip."
        else
          super
        end
      end
    end
  end
end

::RSpec.configure do |c|
  # Blow away rutabaga's pattern if still there
  c.pattern.gsub!(",features/**/*.feature", "")
end
