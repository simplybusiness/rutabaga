# frozen_string_literal: true

require 'rutabaga'
##
#
# Enables turnip in the spec/features
#
module Turnip
  module RSpec
    module Loader
      def load(*a, &b)
        if a.first.end_with?('.feature')
          # if legal_directories.none? { |d| a.first.end_with? d }
          #   ::RSpec.warning 'Features can only be called from turnip enable directories. These are configured ' \
          #                   "in RSpec.configuration.pattern which is currently '#{::RSpec.configuration.pattern}'"
          # else
            require_if_exists 'turnip_helper'
            require_if_exists 'spec_helper'

            Turnip::RSpec.run(a.first)
          # end
        else
          super
        end
      end

      private

      def legal_directories
        @legal_directories ||= ::RSpec.configuration.pattern.split(',')
                                      .select { |p| /\.feature\Z/ =~ p }
                                      .map { |d| Dir.glob(File.join(::RSpec.configuration.default_path, d)) }
                                      .flatten
      end
    end
  end
end
