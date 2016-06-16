require 'turnip/rspec'
require 'rspec'

module Rutabaga
  module ExampleGroup
    module Feature
      class << self
        def feature(example_group_class, description, args)
          Util.require_if_exists 'turnip_helper'

          Turnip::RSpec.rutabaga_run(Util.find_feature(description), example_group_class)
        end
      end
    end
  end
end
