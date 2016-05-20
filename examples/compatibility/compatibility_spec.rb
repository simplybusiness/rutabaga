require 'spec_helper'
require 'capybara/rspec'

describe "capaybara rails does not overwrite the feature command" do
  feature '../test2.feature' do
    step "that :first + :second is calculated" do |first, second|
      @first = first
      @second = second
    end

    step "my result is :result" do |result|
      expect(@first.to_i + @second.to_i - 1).to eq(result.to_i)
    end
  end
end

describe "turnip doesn't overwrite the type", type: :parent_group do
  feature '../test2.feature' do
    step "that :first + :second is calculated" do |first, second|
      metadata_type = RSpec.current_example.example_group.metadata[:type]

      puts "feature metadata type is preserved as #{metadata_type}"

      expect(metadata_type).to eq(:parent_group)
    end

    step "my result is :result" do |result|
    end
  end
end
