require 'spec_helper'

describe "it prints out the RSpec.configuration.pattern" do
  it "examples/test2.feature" do
    puts "RSpec.configuration.pattern: #{RSpec.configuration.pattern}"
  end
end
